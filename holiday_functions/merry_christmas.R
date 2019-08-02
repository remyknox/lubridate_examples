library(lubridate)
library(tidyverse)

#' What day of the week is christmas?
#' 
#' @param year should be an integer/string that contains the year
#' Must be 2 or 4 digits

christmas_day <- function(year){
  #check that the year is either a 2 or 4 digit number
  if(!(nchar(year) %in% c(2,4))){
    stop('Year must be 2 or 4 digits')
  }
  #alternate way of testing! this one looks for a warning when we try to coerce the year into a number (in the case of string)
  tryCatch(as.numeric(year),
           warning = function(c) stop('Year should be an integer, in either character or numeric form'))
  
  #for 2 digit years, lubridate considers numbers less than 69 to be in the 21st centry, and numbers greater to be in the 20th
  if(nchar(year) == 2){
    if(as.numeric(year) <= 68){
      cat('Christmas day in', paste0('20',year), 'falls on a', paste0(20,year, 12, 25) %>% ymd %>% lubridate::wday(label = T, abbr = FALSE) %>% as.character)
    }
    else{
      cat('Christmas day in', paste0('19',year), 'falls on a', paste0(19,year, 12, 25) %>% ymd %>% lubridate::wday(label = T, abbr = FALSE) %>% as.character)
    }
  }
  else{
    cat('Christmas day in', year, 'falls on a', paste0(year, 12, 25) %>% ymd %>% lubridate::wday(label = T, abbr = FALSE) %>% as.character)
  }
}
