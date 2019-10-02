#PLOT: TABS salinity data Sept 2019

#Date Created: 2 Oct 2019

#libraries
library(tidyverse)
library(scales)

#read data in ---
d <- read.csv(file = "TABS_BuoyB_prepped.txt", header = T, stringsAsFactors = F)

names(d) <- tolower(names(d))

d$datetime <- as.POSIXct(strptime(x = paste(d$date," ",d$time), format = "%m/%d/%Y %H:%M:%S"), tz = "America/Chicago")
d$date <- NULL; d$time <- NULL
d <- d[,c(6,1:5)]

bi <- d[d$datetime < "2019-09-17",]
ai <- d[d$datetime >= "2019-09-17",]

#create plot ----
p <- ggplot(d) + geom_line(aes(x=datetime, y=salt), colour = "darkblue", size = 1) +
  geom_smooth(data = bi, aes(x=datetime, y=salt), position = "identity", stat = "smooth", color = "chartreuse4") +
  geom_smooth(data = ai, aes(x=datetime, y=salt), position = "identity", stat = "smooth", color = "darkorange3") +
  geom_vline(xintercept=as.integer(as.POSIXct("2019-09-17")), size=1, linetype = "dashed", color = "black") +
  scale_y_continuous(name = "salinity (psu)", breaks = seq(18,34,2)) +
  scale_x_datetime(name = NULL, breaks = date_breaks("2 day"), minor_breaks = date_breaks("1 day")) +
  theme_light(base_size = 14, base_line_size = 1) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1, color = "black"),
        axis.text.y = element_text(color = "black"))
p

file = "TABS_B_salt_Sept2019.png"
png(file = file, width = 8, height = 8, units = "in", res = 250)
plot(p)
dev.off()

