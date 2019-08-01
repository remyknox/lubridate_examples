library(tidyverse)
library(lubridate)

#' Father/Mother's day Function Example
#' Father's day: the thrid Sunday of June every year
#' Mother's day: the second Sunday of May every year
#' 
#' @param year 
#'
#' @return the date of father and mother's day of the input year
#' @export
#'
#' @examples fm.day(2000)
#' 
fm.day <- function(year){
  
  # check if the parameter is a number with 4 digits
  if(is.numeric(year) == F | nchar(year) != 4){
    stop("Year must be a four digit number, i.e. 2019")
  }
  fday <- ymd(paste(year,6,1,sep = "-"))
  mday <- ymd(paste(year,5,1,sep = "-"))
  
  f_temp <- 8 - wday(fday)
  m_temp <- 8 - wday(mday)
  
  fday <- fday + days(f_temp) + weeks(2)
  mday <- mday + days(m_temp) + weeks(1)
  
  print(paste0("Father's day of year ", year," is: ", fday))
  print(paste0("Mother's day of year ", year," is: ", mday))
  
}


