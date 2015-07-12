library(sqldf)
# creates a dummy data frame to be used as filter
dataset <- read.csv2.sql(file = "household_power_consumption.txt",
                         sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                         field.types = list(Date = "DATE",
                                           Time = "TIME",
                                           Global_active_power = "REAL",
                                           Global_reactive_power = "REAL",
                                           Voltage = "REAL",
                                           Global_intensity = "REAL",
                                           Sub_metering_1 = "REAL",
                                           Sub_metering_2 = "REAL",
                                           Sub_metering_3 = "REAL"),
                         nrows = 2880,
                         filter = NULL,
                         colClasses = c("character", "character", rep("numeric", 7)),
                         header = TRUE,
                         comment.char = "",
                         na.strings = "?")
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
dataset$Time <- strptime(paste(dataset$Date, dataset$Time), "%Y-%m-%d %H:%M:%S")

par(mar = c(5.1, 5.1, 4.1, 2.1))
hist(dataset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")


dev.copy(png, file = "plot1.png")
dev.off()
