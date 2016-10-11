#' Retrieve settings
#' 
#' Rerieve settings set with \code{\link{in_setup}}
#' 
#' @return Returns data.frame of settings:
#' \itemize{
#'  \item base.url
#'  \item country
#' }
#' 
#' @examples
#' in_setup(country = "us") 
#' (my_settings <- in_settings())
#' 
#' @export
in_settings <- function(){
  base.url <- tryCatch({get("base.url", setup_env)},
                  error = function(e) e)
  if(is(base.url, "error")) stop("no settings")
  
  country <- tryCatch({get("country", setup_env)},
                       error = function(e) e)
  set = data.frame(base.url = base.url,
                   country = country)
  return(set)
}