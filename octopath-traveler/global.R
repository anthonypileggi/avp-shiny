library(shiny)
library(shinymaterial)
library(tidyverse)
library(DT)
library(plotly)

# load data
x <- read_csv("octopath-traveler-character-stats.csv", col_types = cols())

# convert from wide-->long format
x <- tidyr::gather(x, stat, value, -name, -level)
