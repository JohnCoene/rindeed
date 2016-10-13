get_base_url <- function(){
  base.url <- tryCatch(getOption("base.url"), error = function(e) e)
  
  if(is(base.url, "error")) stop("must set base.url first, see ?in_setup",
                                 call. = FALSE)
  return(base.url)
}

url_country_match <- function(base.url, country){
  
  if(is.null(base.url) && is.null(country)){
    stop("must specify either base.url or country")
  }
  
  if(length(base.url) && length(country)){
    country <- tolower(country)
    cn <- base_url_country[which(base_url_country$base.url == base.url), 
                           "country"]
    
    if(!length(cn)) warning("cannot find country of base.url")
    
    if(cn != country){
      warning(paste0("did you mean:", cn, "?"))
    }
  }
  
  if(is.null(country) && length(base.url)){
    base.url <- gsub("/$", "", base.url)
    country <- base_url_country[which(base_url_country$base.url == base.url), 
                                "country"]
  
    if(!length(country)){
      warning("url not found")
      country <- "unknown"
    }
  }
  
  if(is.null(base.url) && length(country)){
    country <- tolower(country)
    base.url <- base_url_country[which(base_url_country$country == country), 
                                 "base.url"]
    
    if(!length(base.url)) stop("wrong country, see details for valid values")
  }
  
  df <- data.frame(country = country, base.url = base.url)
  
  return(df)
}

parse_date <- function(x){
  cn <- getOption("country")
  
  en <- c("us", "uk")
  
  if(length(grep(cn, en))){
    
  }
}