#' Scrape Indeed
#'
#' Scrapes indeed.com
#'
#' @param q query keyword, "what" on official website. Required
#' @param l location, "where" on official website. Optional
#' @param n number of results requested
#' @param base.url base url for queries defaults to global \code{http://www.indeed.com}
#' @param sleep break between queries in seconds, applies when requesting more than the default \code{10} results (\code{n})
#' @param verbose if \code{TRUE} prints feedback in console
#'
#' @importFrom utils URLencode
#' @import magrittr
#'
#' @return returns data.frame of
#'
#' @export
in_scrape <- function(q, l, n = 10, base.url = "http://www.indeed.com", sleep = sample(20:30, 1), verbose = FALSE){

  if(missing(q)) stop("Query required")
  if(missing(l)) l <- ""

  res <- data.frame()
  for(i in seq(0, n, 10)[-length(seq(0, n, 10))]){
    scraps <- scrappy(q, l, n, base.url, start = i)
    res <- rbind.data.frame(res, scraps)
    if(verbose == TRUE){
      cat(paste0("q ", i, "results", ": ", nrow(res), " results\n"))
    }
    Sys.sleep(sleep)
  }

  return(res)
}

scrappy <- function(q, l, n = 10, base.url = "http://www.indeed.com", start = 0){

  uri <- xml2::read_html(paste0(base.url, "/jobs?q=", q, "&l=", URLencode(l), "&start=", start))

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
