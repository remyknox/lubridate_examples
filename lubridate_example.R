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
date <- date -days(1); with_tz(date, tz = "GMT")


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




