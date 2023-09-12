library(tidyverse)
library(here)
here()
data1 <- read_delim(here("data_original", "exam_data.txt"))
data1 <- distinct(data1) # removes duplicated columns, always check
data2 <- read_delim(here("data_original", "exam_data_join.txt"))
data2 <- distinct(data2)
merged_data <- merge.data.frame(data1, data2)
merged_data2 <- merged_data %>%
  rename(gender = '1gender',
         BMI = `BMI kg/m2`) # renames column head
