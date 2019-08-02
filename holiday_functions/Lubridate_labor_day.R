library(tidyverse)
library(lubridate)

#Using Lubridate to find labor day
#Labor day is always the first Monday of September

labor_day <- ymd("1989-01-01") #starting with the year 1989
month(labor_day) <- 9 #changing the month to september

#checking the day of the week september 1 in 1989 was on
wday(labor_day, label= TRUE, abbr = FALSE) #Friday

labor_day <- labor_day + days(3)

wday(labor_day, label=TRUE, abbr =FALSE) #Monday
