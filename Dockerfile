FROM rocker/shiny
MAINTAINER Anthony Pileggi (apileggi20@gmail.com)

# install cron and R package dependencies
RUN apt-get update && apt-get install -y \
    cron \
    git \
    ## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
    tidyverse \
    shinyjs \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
## Start cron
RUN sudo service cron start

# clone repo with Shiny apps
#RUN git clone git@github.com:anthonypileggi/avp-shiny.git

# copy shiny files to the server (assume they are in build folder)
#COPY shiny/test /srv/shiny-server/test
COPY ./matching-game /srv/shiny-server/matching-game
