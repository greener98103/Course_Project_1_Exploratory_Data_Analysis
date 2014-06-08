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

#melt data points

#Lets melt our all our individual data types to make it easier to #work with


Global_active_power <- melt(raw_data, id=c("datetime"),measure.vars=c("Global_active_power"))
Voltage <- melt(raw_data, id=c("datetime"),measure.vars=c("Voltage"))
power_melt1 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_1"))

power_melt2 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_2"))

power_melt3 <- melt(raw_data, id=c("datetime"),measure.vars=c("Sub_metering_3"))

Global_reactive_power <- melt(raw_data, id=c("datetime"),measure.vars=c("Global_reactive_power"))

#how big is the raw data object?
print(object.size(raw_data),units="Mb")

#lets remove it free up space
rm(raw_data)

# Now lets subset our melted objected by the dates were #interested in

power_melt_filtered1 <- subset(power_melt1, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

power_melt_filtered2 <- subset(power_melt2, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

power_melt_filtered3 <- subset(power_melt3, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

Global_active_power_filtered <- subset(Global_active_power, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

Global_reactive_power_filtered <- subset(Global_reactive_power, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

Voltage_filtered <- subset(Voltage, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

#Lets create a PNG and plot our values seperately over datetime

png(filename = "C:\\coursera\\images\\plot4.png", width = 480, height = 480,bg = "white")

#we will need to load 4 images so a 2 by 2 image 
par(mfrow=c(2,2))

# First plot our global active power over datetime
plot(Global_active_power_filtered$datetime, as.character(Global_active_power_filtered$value), ylab ="Global Active Power", type="l", xlab="")

# Second plot Voltage over datetime
plot(Voltage_filtered$datetime, as.character(Voltage_filtered$value), ylab ="Voltage", type="l", xlab="datetime" )

#Third begin plot the sub metering values over datetime

#plot sub meter 1 over datetime

plot(power_melt_filtered1$datetime, as.character(power_melt_filtered1$value), type="l", ylab="Energy Sub Metering", xlab="")

#plot sub meter 2 over datetime

lines(power_melt_filtered1$datetime, as.character(power_melt_filtered2$value), type="l", col="red", ylab="Energy Sub Metering")

#plot sub meter 3 over datetime

lines(power_melt_filtered1$datetime, as.character(power_melt_filtered3$value), type="l", col="blue", ylab="Energy Sub Metering")


legend(1170389416,39.00000, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, cex=.8, box.col=0 ,box.lwd = 0,  col=c("black", "red", "blue"))


#Last image plot Global reactive power over datetime
plot(Global_reactive_power_filtered$datetime, as.character(Global_reactive_power_filtered$value), ylab ="Global_reactive_power", type="l", xlab="datetime")

dev.off()
