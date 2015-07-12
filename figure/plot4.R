library(dplyr)
library(timeDate)

#1) DATA PRE-PROCESSING
##Read text file
dataHouseHold <- read.table(
        "~/Desktop/Coursera_Data_Science_Tools/DataScienceSpecialization/ExploratoryDataAnalysis/Assigment1Code-ExploDataAnaysis/household_power_consumption.txt",
        header = TRUE, 
        sep = ";",
        na.strings = "?",
        stringsAsFactors = FALSE)

##Transform Date from factor to date - dplyr
dataHouseHold <- mutate(dataHouseHold, Date = as.Date(Date, "%d/%m/%Y")) 

##Create dataframe with elements required for the exercise - baseR
dataHouseHold <- subset(dataHouseHold, Date >= '2007-02-01' & Date <= '2007-02-02')

##Merge Date and Time chars into a timeDate class - timeDate
DateTime <- timeDate(paste(dataHouseHold$Date, dataHouseHold$Time))

##Transform into POSIXct type - baseR
DateTime <- as.POSIXct(DateTime,"%Y/%m/%d %H:%M:%S", tz = "GMT")

##Insert new class into Date column - dplyr
dataHouseHold <- mutate(dataHouseHold, Date = DateTime)

##rename column to DateTime
dataHouseHold <- rename(dataHouseHold, DateTime = Date)

##Remove old second column with time as char - baseR
dataHouseHold <- dataHouseHold[,-2]

#2) DATAFRAME PROCESSED - Plot 4


par(mfrow = c(2,2))
par(mai = c(0.5,0.5,0.5,0.5))
      
plot(dataHouseHold$DateTime, dataHouseHold$Global_active_power, 
             ylab = "Global Active Power (kilowatts)", xlab = "",
             type = 'l',
             cex.axis = 0.7,
             cex.lab = 0.8)
plot(dataHouseHold$DateTime, dataHouseHold$Voltage, 
             ylab = "Voltage", xlab = "",
             type = 'l',
             cex.axis = 0.7,
             cex.lab = 0.8)
plot(dataHouseHold$DateTime, dataHouseHold$Sub_metering_1, 
             ylab = "Energy sub metering", xlab = "",
             type = 'l',
             cex.axis = 0.7,
             cex.lab = 0.8)
        lines(dataHouseHold$DateTime, dataHouseHold$Sub_metering_2, col = "red")
        lines(dataHouseHold$DateTime, dataHouseHold$Sub_metering_3, col = "blue")
        legend("topright",
               col=c("black", "red", "blue"), 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty=1, lwd=2, 
               yjust = 1,
               xjust = 1,
               cex = 0.75)
plot(dataHouseHold$DateTime, dataHouseHold$Global_reactive_power, 
             ylab = "Global Reactive Power", xlab = "",
             type = 'l',
             cex.axis = 0.7,
             cex.lab = 0.8)      

dev.copy(png, file = "plot4.pgn", height = 480, width = 480)
dev.off()