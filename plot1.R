library(data.table)
library(dplyr)
library(tidyverse)
pwread <- fread('household_power_consumption.txt',na.strings="?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
pwread$Date <- as.Date(pwread$Date,format="%d/%m/%Y")

d <- subset(pwread,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
datetime <- paste(d$Date,d$Time)
datetime <- strptime(datetime,"%Y-%m-%d %H:%M:%S")
d <- d[,!c("Date","Time")]
d <- cbind(datetime,d)
d <- d %>% rename(DateTime=datetime)
par(mfrow=c(1,1))
hist(d$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts",col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()