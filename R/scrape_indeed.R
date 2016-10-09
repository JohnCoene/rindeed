#' Scrape Indeed
#'
#' Scrapes indeed.com
#'
#' @param q query keyword, "what" on official website. Required
#' @param l location, "where" on official website. Optional
#' @param n number of results requested
#' @param base.url base url for queries defaults to global \code{http://www.indeed.com}
#' @param sleep break between queries in seconds, applies when requesting more than the default \code{10} results (\code{n})
#' @param verbose sets verbose of \code{rvest::read_html}
#'
#' @importFrom utils URLencode
#' @import magrittr
#'
#' @return returns data.frame with following variables:
#' \itemize{
#'  \item{job title}
#'  \item{company}
#'  \item{summary}
#'  \item{date}
#'  \item{location}
#'  \item{url} 
#' }
#' 
#' @examples 
#' \dontrun{
#' ds <- in_scrape("data scientist", "United States")
#' da <- in_scrape("data analyst", "New York", 30)
#' ds_cn <- in_scrape("data scientist", "Beijing", 10, 
#'                    "http://cn.indeed.com/")
#' }
#'
#' @export
in_scrape <- function(q, l, n = 10, base.url = "http://www.indeed.com",
                      sleep = sample(20:30, 1), verbose = FALSE){

  if(missing(q)) stop("query required")
  if(missing(l)) l <- ""
  
  if(n <= 10){
    
    res <- scrapy(q, l, n, base.url, start = 0, verbose)
    
  } else {
    res <- scrap_n(q, l, n, base.url, verbose, sleep)
  }

  return(res)
}

scrapy <- function(q, l, n = 10, base.url = "http://www.indeed.com", start = 0,
                   verbose = FALSE){

  uri <- xml2::read_html(paste0(base.url, 
                                "/jobs?q=", gsub(" ", "+", q), 
                                "&l=", gsub(" ", "+", l), 
                                "&start=", start),
                         verbose = verbose)

  jobtitles <- uri %>%
    rvest::html_nodes(".jobtitle") %>%
    rvest::html_text(trim = TRUE)

  companies <- uri %>%
    rvest::html_nodes(".company span") %>%
    rvest::html_text(trim = TRUE)

  summary <- uri %>%
    rvest::html_nodes(".summary") %>%
    rvest::html_text(trim = TRUE)

  date <- uri %>%
    rvest::html_nodes(".date") %>%
    rvest::html_text()

  link <- uri %>%
    rvest::html_nodes(".jobtitle .turnstileLink") %>%
    rvest::html_attr("href")

  location <- uri %>%
    rvest::html_nodes(".location") %>%
    rvest::html_text()

  scrp <- data.frame(job.title = jobtitles,
                     company = companies,
                     summary = summary,
                     date = date,
                     location = location,
                     url = paste0(base.url, link))
  return(scrp)
}

scrap_n <- function(q, l, n = 10, base.url = "http://www.indeed.com",
                    verbose = FALSE, sleep = sample(20:30, 1)){
  
  sequ <- seq(0, n, 10)[-length(seq(0, n, 10))]
  
  res <- data.frame()
  
  for(i in sequ){
    scraps <- scrapy(q, l, n, base.url, start = i, verbose = verbose)
    res <- rbind.data.frame(res, scraps)
    Sys.sleep(sleep)
    
  }
  
  return(res)
}
