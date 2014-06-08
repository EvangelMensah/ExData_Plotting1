## Set working directory
setwd(".../Household_project")



hdata <- read.table ("household_power_consumption.txt", sep= ";", header = TRUE, stringsAsFactors=FALSE)



classes <- sapply(hdata, class)    #### Checking the classes of the data

newdata <-  subset(hdata, hdata$Date == "1/2/2007" | hdata$Date == "2/2/2007")   ### Subsetting the required data

newdata <- data.frame(newdata, row.names = NULL)
newdata[, 3]<- as.numeric(newdata[, 3])
newdata[, 4]<- as.numeric(newdata[, 4])
newdata[, 5]<- as.numeric(newdata[, 5])
newdata[, 6]<- as.numeric(newdata[, 6])
newdata[, 7]<- as.numeric(newdata[, 7])
newdata[, 8]<- as.numeric(newdata[, 8])
newdata[, 9]<- as.numeric(newdata[, 9])

write.csv(newdata, "subHousing.csv", row.names = F)    #### Write a new file for easy loading

#### Reading of New Files

hsedata <- read.csv("subHousing.csv", stringsAsFactors=FALSE )





## Plot 2
# convert Date and Time variables to Date,Time classes and concatenate
hsedata$Date <- as.Date(hsedata$Date , "%d/%m/%Y", TZ = " GMT")
hsedata$DateTime <- paste(hsedata$Date, hsedata$Time, sep=" ")
hsedata$DateTime <- strptime(hsedata$DateTime, "%Y-%m-%d %H:%M:%S")

png("plot2.png", width = 480, height = 480)
plot(hsedata$DateTime, hsedata[,3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off() 




