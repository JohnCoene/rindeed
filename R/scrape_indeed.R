#' Scrape Indeed
#'
#' Scrapes indeed.com
#'
#' @param q query keyword, "what" on official website. Required
#' @param l location, "where" on official website. Optional
#' @param p number of pages to scrape
#' @param sleep break between queries in seconds, 
#' applies when requesting more than the default one page of results 
#' (\code{p = 1}), defaults to \code{sample(10:20, 1)}
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
#' in_setup(country = "us") # setup
#' options(stringsAsFactors = FALSE)
#' ds <- in_scrape(q = "data scientist", l = "Washington", p = 3)
#' }
#' 
#' @importFrom methods is
#' @import magrittr
#' 
#' @seealso \code{\link{in_setup}}
#'
#' @export
in_scrape <- function(q, l, p = 1, sleep = sample(15:20, 1)){

  if(missing(q)) stop("query required")
  if(missing(l)) l <- ""
  
  res <- data.frame()
  for(i in seq(0, p * 10, 10)[-length(seq(0, p * 10, 10))]){
    if(i != 0) Sys.sleep(sleep)
    scraps <- scrapy(q, l, p, start = i)
    res <- rbind.data.frame(res, scraps)
  }

  return(res)
}

scrapy <- function(q, l, p = 1, start = 0){

  base.url <- get_base_url()
  
  adr <- paste0(base.url, "/jobs?q=", gsub(" ", "+", q), 
                "&l=", gsub(" ", "+", l), "&start=", start)
  
  uri <- tryCatch({xml2::read_html(adr)}, error = function(e) e)
  
  if(is(uri, "error")) stop("cannot ping url")

  jobtitles <- uri %>%
    rvest::html_nodes(".jobtitle") %>%
    rvest::html_text(trim = TRUE)

  if(length(jobtitles) == 10){
    companies <- uri %>%
      rvest::html_nodes(".company span") %>%
      rvest::html_text(trim = TRUE)
  } else {
    companies <- uri %>%
      rvest::html_nodes(".company") %>%
      rvest::html_text(trim = TRUE)
  }

  summary <- uri %>%
    rvest::html_nodes(".summary") %>%
    rvest::html_text(trim = TRUE)

  date <- uri %>%
    rvest::html_nodes(".date") %>%
    rvest::html_text()

  if(length(jobtitles) == 10){
    link <- uri %>%
      rvest::html_nodes(".jobtitle .turnstileLink") %>%
      rvest::html_attr("href")
  } else {
    link <- uri %>%
      rvest::html_nodes(".jobtitle") %>%
      rvest::html_attr("href")
  }

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
