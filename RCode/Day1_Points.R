#Day 1
################################################################################
# SOURCE - "BusLifeExpectancy.R"
# 1 	01-11-2021 	Points 	A map with points.
library(sf)
library(dplyr)
library(tmap)
# Metro Bus Network, Christchruch, Orbiter
# orbiter <- dplyr::filter(MetroBusChch, grepl('Or', RouteNos))
orbiter <- 
  readRDS(gzcon(url("https://github.com/malcolmcampbell/30DayMapChallenge2021/raw/main/Data/OrbiterMetroBusChch_sf.rds")))
plot(st_geometry(orbiter))

#tmap_mode("view")
tm_shape(orbiter) + tm_dots()

tmap_mode("plot")
tmap_mode("view")
POINTS <-  tm_shape(orbiter) + tm_dots(title="Bus Stops") +
  tm_legend(text.size=1,title.size=1.2,position=c("left","top")) + 
  tm_layout(main.title="Orbiter Bus Stops") +
  tm_compass(position=c("right","bottom"), type="rose", size=4) +
  tm_scale_bar(width=0.15, position=c("right","bottom")) +
  tm_credits(text = "Created by A.Prof Malcolm Campbell \n
             Source: Metro, Christchurch, NZ") 
POINTS
# manual SAVE here
tmap_save(tm=POINTS, filename="POINTS.png", width=1800, height=1800)
###############################################################################