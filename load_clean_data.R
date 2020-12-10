#script to load/clean data and save as a .csv for easier loading in the future

#data file needs to have header line of the format:  
# ReviewerID, Rating, Date

library(readr)
library(tidyverse)

data <- read_csv("data1.csv")

col1 <- data$ReviewerID

breaks <- c()
for (i in 1:3){
  breaks <- c(breaks, grep(paste(i, ":", sep=""), col1))
}
breaks <- c(breaks, length(col1))

clean_data <- tibble(movieID=c(), ReviewerID=c(), Rating=c(), Date=c())

for (i in 1:(length(breaks)-1)){
  tmp_df <- data[(breaks[i]+1):(breaks[i+1]-1),]
  movieID_df <- tibble(movieID = rep(i, dim(tmp_df)[1]))
  tmp_df <- bind_cols(movieID_df, tmp_df)
  clean_data <- bind_rows(clean_data, tmp_df)
}

write_csv(clean_data, "clean_data.csv")



