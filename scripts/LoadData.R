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
           into = c("asa", "mallampati"), 
           sep = "_") %>% # splits column into two
  rename(gender = '1gender',
         bmi = `BMI kg/m2`,
         age = preOp_age,
         smoking = preOp_smoking,
         pain = preOp_pain,
         treatment = treat
         ) # renames column head
#gender <- merged_data2 %>%
#  +     group_by(preOp_gender, gender) %>%
#  +     reframe(preOp_gender, gender)
#View(gender) #both gender Columns are the same. One can be deleted
merged_data2 <- merged_data2 %>%
  mutate(gender = case_when(gender == "0" ~ "M",
                            gender == "1" ~ "F",
                            TRUE ~"Other")) %>%
  mutate(smoking = case_when(smoking == 1 ~ "Current",
                             smoking == 2 ~ "Past",
                             smoking == 3 ~ "Never")) %>%
  mutate(pain = case_when(pain == 0 ~ "No",
                          pain == 1 ~ "Yes")) %>%
  mutate(treatment = case_when(treatment == 0 ~ "No",
                               treatment == 1 ~ "Yes")) %>%
  mutate(asa = as.numeric(asa),
         mallampati = as.numeric(mallampati))#converts characters into numeric, very useful
write_csv(merged_data2, here("data_processed", "data_merged.csv")) #write output so others scripts can use it
#summary(merged_data2)
#skimr::skim(merged_data2)
