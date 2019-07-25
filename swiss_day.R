
#' For a specific year, return the day of the week at which the Swiss National Day will occur
#'
#' @param yoi A number or character -- Year you want to search.
#'
#' @return Day of the week
#' @export
#'
#' @examples
#' swiss_day(2019)
#' 
swiss_day <- function(yoi){
  # Check if the parameter can be transfomed into a 4 digit number
  stopifnot(is.na(as.integer(yoic)))
  stopifnot(nchar(yoic)==4)
  
  # Transform the year as character in case it was passed as an integer
  yoic <- as.character(yoi)
  
  # Create the Swiss national day date (first of August -- although everybody should know that)
  swiss_date <- lubridate::ymd(paste(yoic, "08", "01", sep = "-"))
  
  # Get the day of the week
  lubridate::wday(swiss_date, label =TRUE, abbr = FALSE)
}