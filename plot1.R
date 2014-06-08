#Plot1
# find location for files
setwd('C:\\coursera\\exdata-data-household_power_consumption')

#upload raw data

raw_data <- read.table("household_power_consumption.txt", header = T, sep=';')

 
#Make data frame based off the raw data.

power <- data.frame(Date=as.character(as.Date(raw_data$Date, "%d/%m/%Y")), Global_Active_Power=as.double(raw_data$Global_active_power), Global_reactive_power=as.double(raw_data$Global_reactive_power),Voltage=as.double(raw_data$Voltage ),Global_intensity=as.double(raw_data$Global_intensity), Sub_metering_1=as.double(raw_data$Sub_metering_1), Sub_metering_2=as.double(raw_data$Sub_metering_2), Sub_metering_3=as.double(raw_data$Sub_metering_3))

#Lets subset the data by the suggested dates
power_results <- power[power$Date %in% c('2007-02-01', '2007-02-02'),]

# Check to see how much memory is used by the raw data object.
print(object.size(raw_data),units="Mb")

# Lets free up memory and remove the raw_data object since we #already created a data frame

rm(raw_data)

# now lets build a histogram based off the global active power. 
# show its frequency and convert it to show in kilowatts
# To get it into kilowatts divide by 500
#create a PNG

png(filename = "C:\\coursera\\images\\plot1.png", width = 480, height = 480,bg = "white")

hist((power$Global_Active_Power/500), col="red", xlab ="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

dev.off()





