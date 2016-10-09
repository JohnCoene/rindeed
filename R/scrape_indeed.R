#' Scrape Indeed
#'
#' Scrapes indeed.com
#'
#' @param q query keyword, "what" on official website. Required
#' @param l location, "where" on official website. Optional
#' @param n number of pages to scrape
#' @param sleep break between queries in seconds, 
#' applies when requesting more than the default \code{10} results (\code{n})
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
#' @importFrom methods is
#' @import magrittr
#' 
#' @seealso \code{\link{in_setup}}
#'
#' @export
in_scrape <- function(q, l, n = 1, sleep = sample(20:30, 1)){
  
  base.url <- get_base_url()

  if(missing(q)) stop("query required")
  if(missing(l)) l <- ""
  
  if(n <= 1){
    
    res <- scrapy(q, l, n, start = 0)
    
  } else {
    res <- scrap_n(q, l, n, sleep)
  }

  return(res)
}

scrapy <- function(q, l, n = 1, start = 0){

  base.url <- get_base_url()
  
  uri <- xml2::read_html(paste0(base.url, 
                                "/jobs?q=", gsub(" ", "+", q), 
                                "&l=", gsub(" ", "+", l), 
                                "&start=", start))

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

scrap_n <- function(q, l, n = 1, sleep = sample(20:30, 1)){
  
  base.url <- get_base_url()
  
  res <- data.frame()
  for(i in seq(0, n * 10, 10)[-length(seq(0, n * 10, 10))]){
    scraps <- scrapy(q, l, n, start = i)
    res <- rbind.data.frame(res, scraps)
    Sys.sleep(sleep)
  }
  
  return(res)
}
