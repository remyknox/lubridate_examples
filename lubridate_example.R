library(tidyverse)
library(lubridate)

####----Comparing Base R to Lubridate----####

# 'date' as a POSIXct date-time object
# The POSIXct class stores date/time values as the number of seconds since January 1, 1970, 
# while the POSIXlt class stores them as a list with elements for second, minute, hour, day, month, and year, among others.
r_date <- as.POSIXct("01-01-2010", format = "%d-%m-$Y", tz = "UTC")  # Base R
print(r_date)
date <- dmy("01-01-2010")  # Lubridate
print(date)

# extracting the month from 'date'
as.numeric(format(date, "%m")) 
month(date) 

# changing the month in 'date'
date <- as.POSIXct(format(date, "%Y-2-%d", tz = "UTC"))
month(date) <- 2

# change 'date' to one day earlier and set time zone to "GMT" 
date <- seq(date, length = 2, by = "-1 day")[2]; as.POSIXct(format(as.POSIXct(date), tz = "UTC"), tz = "GMT")
date <- date - days(1); with_tz(date, tz = "GMT")


# some other useful date manipulation

# parsing dates
z = "1970-10-15" 
ymd(z)

z = "10/15/1970"
mdy(z)

z = 15101970
dmy(z)

date <- c("31.12.2010", "01.01.2011")
dmy(date)

date <- c("31.12.2010", "01.01.2011")
mdy(date) # fail cause there is no 31st month

# sequence of dates
date <- origin
date <- date + c(0:9) * days(1)

# exploring dates
wday(date) # day of the week
yday(date) # day of the year




####----Thanksgiving Example----####

# thanksgiving is not celebrated on the same date every year 
# rather it is the 4th thursday of november
# so what was that date in 2010?

# create 'date'
date <- ymd("2010-01-01")
month(date) <- 11 # date = "2010-11-01"

# check which day of the week november 1st is
wday(date, label = T, abbr = F) # Monday
# thus novermber 4th will be the first thursday so add three days and three weeks
date <- date + days(3) + weeks(3)
print(date)


####----Father/Mother's day Example----####

# Father's day: the thrid Sunday of June every year
# Mother's day: the second Sunday of May every year

# create a date
fday <- ymd("2000-01-01")
mday <- ymd("2100-01-01")

# set the month
month(fday) <- 6
month(mday) <- 5

#check the day
wday(fday, label = T, abbr = F) #2000-6-1 is Thursday
wday(mday, label = T, abbr = F) #2100-5-1 is Saturday
fday <- fday + days(3) + weeks(2)
mday <- mday + days(1) + weeks(1)
paste0("Father's day of year 2000 is: ", fday)
paste0("Mother's day of year 2100 is: ", mday)


####----Thanksgiving Function----####
#' function that takes in a year and returns when what thanksgiving date. 
#' thanksgiving is not celebrated on the same date every year, rather it is the 4th thursday of november
#' 
#' @param year should be an integer/string that is 2 or 4 characters long
#' @example thanksgiving_date(2019)

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
    cat('Thanksgiving falls on',
        paste(month(date, label = T, abbr = F), 
              paste(day(date), append_date_suffix(date), ",", sep = ""), 
              paste(year(date), ".", sep = ""))
        )
}


####----Basketball Example----####

lakers <- lubridate::lakers
view(lakers)

# 'date' are integer objects
str(lakers$date)

# dates look to be in the year-month-day format so use ymd() to parse them into R as date-time objects
lakers$date <- ymd(lakers$date)
str(lakers$date)

# now R recognizes 'date' as POSIXct date-time object 
# which means functions that use this method will treat them as date-times

# ggplot2 functions will recognize these date-times
qplot(x = date, y = 0, data = lakers, colour = game_type)
# notice how tick marks and breaks are automatically generated
# this is through lubridate pretty.dates()

# lets look at times within the game
# 'time' has minutes and seconds but is not a unique date-time object 
# lubridate ms() lets you store this as a period object
lakers$time <- ms(lakers$time)
str(lakers$time)

# since periods have relative length we should convert periods to durations
lakers$time <- as.duration(lakers$time)
# and then multiply the period by 12m and subtract the time to compare and plot
lakers$time <- dminutes(12) * lakers$period - lakers$time

# some games have overtime (period 5) which is not 12 minutes so we will remove this period
lakers <- subset(lakers, period != 5)

# ggplot does not support difftimes, so convert 'time' so that all oberservations 
# have the same starting date (this date is abitrary for this example)
lakers$minutes <- ymd("2008-01-01") + lakers$time
str(lakers$minutes)
# plot histogram of play count based on the time of game
qplot(minutes, data = lakers, geom = "histogram", binwidth = 60)
# --- End of Example --- #




