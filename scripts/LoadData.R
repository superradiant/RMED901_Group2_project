library(tidyverse)
library(here)
here()
data1 <- read_delim(here("data_original", "exam_data.txt"))
data1 <- distinct(data1) # removes duplicated columns, always check
data2 <- read_delim(here("data_original", "exam_data_join.txt"))
data2 <- distinct(data2)
merged_data <- merge.data.frame(data1, data2)
merged_data2 <- merged_data %>%
  separate(col = preOp_ASA_Mallampati, 
           into = c("ASA", "Mallampati"), 
           sep = "_") %>% # splits column into two
  rename(gender = '1gender',
         bmi = `BMI kg/m2`) # renames column head
summary(merged_data2)
library(skimr)
skim(merged_data2)
