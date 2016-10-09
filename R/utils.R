get_base_url <- function(){
  base.url <- tryCatch(get("base.url", envir = url_env),
                       error = function(e) e)
  
  if(is(base.url, "error")) stop("must set base.url first, see ?in_setup",
                                 call. = FALSE)
  return(base.url)
}

get_in_base_url <- function(base.url, country){
  if(is.null(base.url) && is.null(country)){
    stop("must specify either base.url or country", call. = FALSE)
  }
  
  if(length(base.url) && length(country)){
    warning("specified both base.url and country - using base.url",
            call. = FALSE)
    country <- NULL
  }
  
  if(is.null(country) && length(base.url)){
    base.url <- gsub("/$", "", base.url)
  }
  
  if(is.null(base.url) && length(country)){
    country <- tolower(country)
    base.url <- base_url_country[which(base_url_country$country == country), 
                                 "base.url"]
    
    if(!length(base.url)) stop("wrong country, see details for valid values")
  }
  
  return(base.url)
}