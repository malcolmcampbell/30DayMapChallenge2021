#Day 4 - Hexagons
# A/Prof Malcolm Campbell
# Copyright July 2022. all rights reserved.
# template for MAPSF package
# source: https://datafinder.stats.govt.nz/layer/95676-territorial-authority-local-board-talb-hexagon-cartogram/
library(sf)
library(mapsf)

# read in a Geopackage from GITHUB
map <- read_sf("https://github.com/malcolmcampbell/30DayMapChallenge2021/raw/main/Data/territorial-authority-local-board-talb-hexagon-cartogram.gpkg")
glimpse(map)
st_crs(map)

# plot it
# set theme see ?mf_theme One of "default", "brutal", "ink", "dark", 
# "agolalight", "candy", "darkula", "iceberg", "green", "nevermind", "jsk", "barcelona".
mf_theme(x="brutal")
# plot municipalities
mf_map(map, col = "dodgerblue2", border = "black")
# plot labels
mf_label(x = map, var = "TALB_Acronym", col = "black", 
  cex = 0.75, font = 2, halo = TRUE, bg = "white",   r = 0.1,   overlap = FALSE, 
  lines = FALSE)
# layout
mf_layout(title = "Territorial Authorities and Local Boards Cartogram Acronyms", 
          credits = "Sources: Stats NZ, Koordinates", arrow = FALSE)
#END