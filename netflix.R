# The licence says for the dat says: "The user may not redistribute the data without separate permission."
# 
# To get the data do the following:
# In a browser goto https://www.kaggle.com/netflix-inc/netflix-prize-data
# Click "Download" and place the downloaded file archive.zip in this directory.
# Then (on *nix machines) run 
#
# $ unzip archive.zip
# $ cat combined_data* > all_data.txt
#

library(tidyverse)
library(tidygraph)

file_name = "all_data.txt"
raw_data <- read_lines(file_name) #, n_max = 5000)

df <- tibble(movieID = integer(), reviewerID = integer(), rating = integer(), date = Sys.Date())

currentMovieID = 0

for (row in raw_data)
  if(str_sub(row,-1)==":") {
    currentMovieID = parse_integer(str_sub(row,1,-2))
  } else {
    split_row <- str_split(row,",")
    reviewerID = parse_integer(split_row[[1]][1])
    rating = parse_integer(split_row[[1]][2])
    date = parse_date(split_row[[1]][3])
    df <- add_row(.data=df, movieID=currentMovieID, reviewerID=reviewerID, rating = rating, date = date)
  }

