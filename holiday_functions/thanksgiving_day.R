#' Take in year return Thanksgiving date.
#'
#' @param year expects a 4 digit integer
#'
#' @return Character
#' @export
#'
#' @examples thanksgiving_day(2019)
 
thanksgiving_day <- function(year){
  # check if the parameter is a number and length of 4
  if(is.numeric(year) == FALSE){
    stop('Year must be a number (ie. 2019).')
  }
  if((!nchar(year) %in% 4)){
    stop('Year must be 4 digits (ie. 2019).')
  }
  
  # set date to 1st of january of year provided then change to november 1st
  date <- lubridate::ymd(paste(year, 1, 1, sep = "-"))
  lubridate::month(date) <- 11
  
  # get suffix of date (ie. 1st, 2nd, ..., 28th,...)
  append_date_suffix <- function(dates){
    dayy <- day(dates)
    suff <- case_when(dayy %in% c(11,12,13) ~ "th",
                      dayy %% 10 == 1 ~ 'st',
                      dayy %% 10 == 2 ~ 'nd',
                      dayy %% 10 == 3 ~'rd',
                      TRUE ~ "th")
    paste0(suff)
  }
  
  # add days and weeks to date to get to thanksgiving day
  x <- 5 - wday(date)
  date <- date + days(x) + weeks(3)
  paste('Thanksgiving falls on',
      paste(month(date, label = T, abbr = F), 
            paste(day(date), append_date_suffix(date), ",", sep = ""), 
            paste(year(date), ".", sep = ""))
  )
}
