#' rindeed: Scrape indeed.com.
#'
#' rindeed provides a few functions to fetch results from \url{www.indeed.com}.
#' 
#' @section Functions:
#' \itemize{
#'  \item \code{\link{in_setup}} setup scraping
#'  \item \code{\link{in_scrape}} scrape
#'  \item \code{\link{in_settings}} fetch your settings
#' }
#' 
#' @examples 
#' \dontrun{
#' in_setup(country = "us")
#' 
#' da_us <- in_scrape(q = "data science", l = "New York", p = 5)
#' 
#' in_setup(country = "China")
#' 
#' da_cn <- in_scrape("data science", "Beijing")
#' 
#' in_settings()
#' }
#' 
#' @docType package
#' @name rindeed
#' @keywords internal
NULL