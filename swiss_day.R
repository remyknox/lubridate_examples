
#' For a specific year, return the day of the week at which the Swiss National Day will occur
#'
#' @param yoi A number or Character -- Year you want to search.
#'
#' @return Day of the week
#' @export
#'
#' @examples
#' swiss_day(2019)
#' 
swiss_day <- function(yoi){
  
  # Transform the year as characted in cas it was apssed as an integer
  yoic <- as.character(yoi)
  
  # Check if the year has 4 digits
  stopifnot(nchar(yoic)==4)
  
  # Create the Swiss national day date (first of August)
  swiss_date <- lubridate::ymd(paste(yoic, "08", "01", sep = "-"))
  
  # Get the day of the week
  lubridate::wday(swiss_date, label =TRUE, abbr = FALSE)
}