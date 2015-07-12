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

Sys.setlocale("LC_TIME", "English")

png(file = "plot4.png", width = 480, height = 480) # used instead of dev.copy due to problems with the legend on the png file
par(mar = c(5.1, 5.1, 4.1, 2.1))
par(mfrow = c(2, 2))

with(dataset, {
        # plot 1 (upper left)
        plot(Time, Global_active_power, xlab = "", ylab= "Global Active Power", type='l')
        # plot 2 (upper right)
        plot(Time, Voltage, xlab = "datetime", ylab= "Voltage", type='l')
        # plot 3 (bottom left)
        plot(Time, Sub_metering_1, xlab = "", ylab= "Energy sub metering", type='l')
        lines(Time, Sub_metering_2, xlab = "", ylab= "Energy sub metering", type='l', col = "red")
        lines(Time, Sub_metering_3, xlab = "", ylab= "Energy sub metering", type='l', col = "blue")
        legend("topright", lty = "solid", bty = "n", cex = 0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        # plot 4 (bottom right)
        plot(Time, Global_reactive_power, xlab = "datetime", type='l')
})
dev.off()
