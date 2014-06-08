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
#here I concatenate them with the paste and strptime commands
raw_data$datetime <- strptime(paste(raw_data$dates, raw_data$times), "%Y-%m-%d %H:%M:%S")


#Lets melt our global active power data to make it easier to work #with

power_melt <- melt(raw_data, id=c("datetime"),measure.vars=c("Global_active_power"))

#now that we have the data set we need lets check how much memory
#the raw data is using

print(object.size(raw_data),units="Mb")

#lets remove the raw data object to free up space
rm(raw_data)

#Now lets subset by the suggested dates

power_melt_filtered <- subset(power_melt, as.Date(datetime) >= '2007-02-01 00:00:00' & as.Date(datetime) <= '2007-02-02 23:59:59', select=c(datetime, value))

# remove ? values
power_melt_filtered[power_melt_filtered=="?"]<-NA
power_melt_filtered_no_outlier <- (na.omit(power_melt_filtered))


#Lets plot our cleaned up values and convert to kilowatts
png(filename = "C:\\coursera\\images\\plot2.png", width = 480, height = 480,bg = "white")

plot(power_melt_filtered_no_outlier$datetime, as.double(power_melt_filtered_no_outlier$value)/1000, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()

#close our png image
