#Day 2
################################################################################
# 2 	02-11-2021 	Points 	A map with lines.
#Peacelines in Belfast
library(sf)
library(tmap)
library(tmaptools)
library(dplyr)

# Source: Northern Ireland Statistics and Research Agency
url <-"https://www.nisra.gov.uk/sites/nisra.gov.uk/files/publications/ESRI-Peacelines.zip"
temp <- tempfile()
temp2 <- tempfile()
download.file(url, temp)
unzip(zipfile = temp, exdir = temp2)

# read in shapefile using {sf}

PeaceLines <- read_sf(temp2)

unlink(c(temp, temp2))
rm (temp, temp2, url)

# test plot
plot(st_geometry(PeaceLines), col="red")

BelfastPeaceLines <- PeaceLines %>%
  filter(LOCATION=="Belfast")

#tmap_mode("view")
tm_shape(PeaceLines) + tm_lines()

tmap_mode("plot")
LINES <-  tm_shape(PeaceLines) + tm_lines(col="red", lty=3) +
  tm_legend(text.size=1,title.size=1.2,position=c("left","top")) + 
  tm_layout(main.title="Peace Lines, Northern Ireland") +
  tm_compass(position=c("right","bottom"), type="rose", size=4) +
  tm_scale_bar(width=0.15, position=c("right","bottom")) +
  tm_credits(text = "Created by A.Prof Malcolm Campbell \n
             Source: Northern Ireland Statistics and Research Agency") 
LINES

tmap_mode("view")
LINES <-  tm_shape(BelfastPeaceLines) + tm_lines(col="red", lwd=3) +
  tm_layout(main.title="Peace Lines, Belfast, Northern Ireland") +
  tm_credits(text = "Source: NISRA \n Northern Ireland Statistics and Research Agency \n
             Created by A.Prof Malcolm Campbell",
             position=c("right","top")) 
LINES
# END