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
    dt <- fread(filePath, 
                sep = ";", 
                na.strings = c("?"),
                stringsAsFactors = FALSE,
                colClasses = c(
                    "character", "character",
                    rep("numeric", 7)
                    ))
    
    dt[Date %in% c("1/2/2007", "2/2/2007"), ]
}

# plot1 function draw to a png file
plot1 <- function (dt) {
    png("plot1.png", width=480, height=480)
    
    hist(dt$Global_active_power, 
         col="red", 
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)")
    
    dev.off()
}

# entrance point of this script
main <- function () {
    requirements()
    dt <- prepare()
    plot1(dt)
    
    View(dt)
}

# invoke the entrance function when sourced
main()