# Coursera exdata - Course project 1

downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
fromDate = as.Date("2007-02-01")
toDate = as.Date("2007-02-02")

# download and unzip data file
if (!file.exists(dataFile)) {
    if (!file.exists(zipFile)) {
        download.file(downloadUrl, zipFile, mode="wb")
    }
    unzip(zipFile)
}

# load and subset data
if (!exists("dat")) {
    data <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")
    dat <- transform(data, Date = as.Date(Date, "%d/%m/%Y"))
    dat <- subset(dat, Date >= fromDate & Date <= toDate)
    dat <- transform(dat, DateTime = strptime(paste(dat$Date, dat$Time),
                                              format="%Y-%m-%d %H:%M:%S"))
}

# plot 2
png("plot2.png", width=480, height=480)

par("mfrow" = c(1,1), "cex" = 0.9)
with(dat, plot(DateTime, Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()