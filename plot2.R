# install and import libraries required for the script
requirements <- function () {
    checkList <- c("data.table")
    installed <- installed.packages()
    
    for (p in checkList) {
        if (!p %in% installed) install.packages(p)
        
        library(p, character.only = TRUE)
    }
}

# prepare (read and clean) data for later analysis
prepare <- function (filePath = "household_power_consumption.txt") {
    # read using data.table
    dt <- fread(filePath, 
                sep = ";", 
                na.strings = c("?"),
                stringsAsFactors = FALSE,
                colClasses = c(
                    "character", "character",
                    rep("numeric", 7)
                    ))
    
    # cast character Date & Time cols to IDate & ITime and return
    dt[Date %in% c("1/2/2007", "2/2/2007"), ][
        , DateTime := strptime(
            paste(Date, Time, sep = " "), 
            format = "%d/%m/%Y %H:%M:%S"
            )
    ][, c("Date", "Time") := NULL]
}

# plot2 function draw to a png file
plot2 <- function (dt) {
    png("plot2.png", width=480, height=480)
    
    plot(dt$DateTime, 
         dt$Global_active_power, 
         type="l", xlab="",
         ylab="Global Active Power(Kilowatts)")
  
    dev.off()
}

# entrance point of this script
main <- function () {
    requirements()
    dt <- prepare()
    plot2(dt)
    
    View(dt)
}

# invoke the entrance function when sourced
main()