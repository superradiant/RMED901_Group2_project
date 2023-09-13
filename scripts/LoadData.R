library(tidyverse)
library(here)
here()
data1 <- read_delim(here("data_original", "exam_data.txt"))
data1 <- distinct(data1) # removes duplicated columns, always check
data2 <- read_delim(here("data_original", "exam_data_join.txt"))
data2 <- distinct(data2)
#antijoined <- anti_join(data1, data2) #no not matchings
merged_data <- left_join(data1, data2)
merged_data2 <- merged_data %>%
  separate(col = preOp_ASA_Mallampati, 
           into = c("ASA", "Mallampati"), 
           sep = "_") %>% # splits column into two
  rename(gender = '1gender',
         bmi = `BMI kg/m2`) # renames column head
merged_data2 <- merged_data2 %>%
  mutate(gender = case_when(gender == "0" ~ "M",
                            gender == "1" ~ "F",
                            TRUE ~"Other")) %>%
  mutate(ASA = as.numeric(ASA),
         Mallampati = as.numeric(Mallampati)) #converts characters into numeric, very useful
         


#summary(merged_data2)
#skimr::skim(merged_data2)
