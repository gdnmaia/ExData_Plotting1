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

#2) Plot 1

hist(dataHouseHold$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "Red", 
     ylim = c(0, 1200),
     cex.axis = 0.8,
     cex.lab = 0.8,
     cex.main = 0.9)

dev.copy(png, file = "plot1.pgn", height = 480, width = 480)
dev.off()

