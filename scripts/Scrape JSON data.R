library(jsonlite)
library (plyr)
library(tidyverse)


url <- "https://petition.parliament.uk/petitions.json?state=open"

all_pets_raw <- fromJSON(url)

all_pets <- all_pets_raw$data$attributes

all_pets_new <- select(all_pets, action:rejection)

