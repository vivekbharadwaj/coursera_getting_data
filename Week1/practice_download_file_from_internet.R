# prepping the environment
setwd(./coursera)
if(!file.exists("coursera_getting_data")) {
        dir.create("coursera_getting_data")
        } 
setwd("./coursera_getting_data")

# getting the data now
# information is present in the following website -> https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru -> export
fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileurl,destfile="./speed_camera_data.csv") #method="curl" in case of https optional for windows - testing this out
list.files()
dateDownloaded <- date()
