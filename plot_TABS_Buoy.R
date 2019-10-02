#PLOT: TABS salinity data Sept 2019

#Date Created: 2 Oct 2019

#libraries
library(tidyverse)

#read data in ---
d <- read.csv(file = "TABS_BuoyB_prepped.txt", header = T, stringsAsFactors = F)

names(d) <- tolower(names(d))

d$datetime <- as.POSIXct(strptime(x = paste(d$date," ",d$time), format = "%m/%d/%Y %H:%M:%S"), tz = "America/Chicago")
d$date <- NULL; d$time <- NULL
d <- d[,c(6,1:5)]


