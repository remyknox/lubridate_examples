library(tidyverse)
library(lubridate)

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
