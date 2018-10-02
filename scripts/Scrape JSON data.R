library(jsonlite)
library (plyr)
library(tidyverse)


url <- "https://petition.parliament.uk/petitions.json?state=open"

all_pets_raw <- fromJSON(url, factor='integer')

all_pets_flat1<- flatten(all_pets_raw)

all_pets_flat2 <- flatten(all_pets_flat1)

all_pets_flat3 <- flatten(all_pets_flat2)


df <- ldply (all_pets_flat3, data.frame)
