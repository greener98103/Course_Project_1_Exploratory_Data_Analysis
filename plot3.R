install.packages("reshape")
library(reshape)
#we will need to do some melting of data in order to make quick #exploratory images

#find my file directory

setwd('C:\\coursera\\exdata-data-household_power_consumption')
#upload files
raw_data <- read.table("household_power_consumption.txt", header = T, sep=';')

#I will need to create a custom value called datetime
#it will include the concatenation of Date and Time
#first I need to convert these from the raw data into character #vectors

raw_data$date_char <- as.character(raw_data$Date)
raw_data$times <- as.character(raw_data$Time)
raw_data$dates <- as.Date(raw_data$date_char,"%d/%m/%Y")
raw_data$datetime <- strptime(paste(raw_data$dates, raw_data$times), "%Y-%m-%d %H:%M:%S")


#Lets melt our sub metering data to make it easier to work with

power_melt1 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_1"))

power_melt2 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_2"))

power_melt3 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_3"))



#how big is the raw data object?
print(object.size(raw_data),units="Mb")

#lets remove it free up space
rm(raw_data)

# Now lets subset our melted objected by the dates were #interested in

power_melt_filtered1 <- subset(power_melt1, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

power_melt_filtered2 <- subset(power_melt2, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

power_melt_filtered3 <- subset(power_melt3, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))


#Lets create a PNG and plot our sub meter 1 followed by our
#other sub meter readings over datetime

png(filename = "C:\\coursera\\images\\plot3.png", width = 480, height = 480,bg = "white")

#plot sub meter 1 over datetime
plot(power_melt_filtered1$datetime, as.character(power_melt_filtered1$value), type="l", ylab="Energy Sub Metering",xlab="")

#plot sub meter 2 over datetime
lines(power_melt_filtered1$datetime, as.character(power_melt_filtered2$value), type="l", col="red", ylab="Energy Sub Metering",xlab="")

#plot sub meter 3 over datetime
lines(power_melt_filtered1$datetime, as.character(power_melt_filtered3$value), type="l", col="blue", ylab="Energy Sub Metering", xlab="")

#build a top right legend for the sub meter readings
#mark them by color
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, cex=1,  col=c("black", "red", "blue"))

dev.off()
#close our png image