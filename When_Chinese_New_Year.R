# packages
library(tidyverse)
library(lubridate)
library(seasonal)


# "The solar year, which is the basis of the Gregorian calendar used around the world, 
#is a bit more than 365 days long. The traditional Chinese calendar, 
# which determines the date of the Lunar New Year, is lunisolar, 
# which means it's based on the cycle of the moon as well as on Earth's course around the sun.
# A month on this Chinese calendar is 28 days long, and a normal year lasts from 353 to 355 days. 
# To keep the calendar in sync with the sun and the seasons, the Chinese add an extra leap month about once every three years.
# source: https://people.howstuffworks.com/culture-traditions/holidays-other/chinese-new-year1.htm."

#' Title
#'
#' @param year 
#'
#' @return the new year date and the zodiac animal of the year
#' @export
#'
#' @examples
#' 
lunar.newyear <- function(year){
  index = year - 1929
  month_ny = month(ymd(cny[index]), label = T, abbr = F)
  day_ny = day(ymd(cny[index]))
  weekday_ny = wday(ymd(cny[index]), label = T, abbr = F)
  animals = c( "Pig", "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog")
  zodiac = animals[(index + 6)%%12+1]
  print(paste0("The ", year, " Chinese New Year is ", weekday_ny, ", ", month_ny, " ", day_ny, ".",
               " It's a ", zodiac, " year!"))
        }
