library(shiny)
library(shinymaterial)
library(tidyverse)
library(DT)

# load data
x <- read_csv("octopath-traveler-character-stats.csv")

# convert from wide-->long format
x <- tidyr::gather(x, stat, value, -name, -level)
