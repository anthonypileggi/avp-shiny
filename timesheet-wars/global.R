library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

# load sample event data
events <- readr::read_csv("events.csv", col_types = cols())

