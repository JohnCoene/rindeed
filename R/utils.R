get_base_url <- function(){
  base.url <- tryCatch(get("base.url", envir = setup_env),
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
    country <- base_url_country[which(base_url_country$base.url == base.url), 
                                "country"]
    
    if(!length(base.url)) stop("url cannot be found")
  }
  
  if(is.null(base.url) && length(country)){
    country <- tolower(country)
    base.url <- base_url_country[which(base_url_country$country == country), 
                                 "base.url"]
    
    if(!length(base.url)) stop("wrong country, see details for valid values")
  }
  
  df <- data.frame(country = country, 
                   base.url = base.url)
  
  return(df)
}

parse_date <- function(x){
  
}