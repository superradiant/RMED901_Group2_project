library(tidyverse)
library(here)
here()
data1 <- read_delim(here("data_original", "exam_data.txt"))
data1 <- distinct(data1) # removes duplicated columns, always check
data2 <- read_delim(here("data_original", "exam_data_join.txt"))
data2 <- distinct(data2)
#antijoined <- anti_join(data1, data2) #no not matchings
merged_data <- left_join(data1, data2)
merged_data <- subset(merged_data, select = -c(month, year, preOp_gender)) #the columns "1gender" and "preOp_gender" are the same
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
merged_data2 <- merged_data2 %>%
  mutate(gender = case_when(gender == "0" ~ "Male",
                            gender == "1" ~ "Female",
                            TRUE ~"Other")) %>% #gender to "Male" and "Female" instead of "0"/"1"
  mutate(smoking = case_when(smoking == 1 ~ "Current",
                             smoking == 2 ~ "Past",
                             smoking == 3 ~ "Never")) %>%
  mutate(pain = case_when(pain == 0 ~ "No",
                          pain == 1 ~ "Yes")) %>%
  mutate(treatment = case_when(treatment == 0 ~ "No",
                               treatment == 1 ~ "Yes")) %>%
  mutate(asa = as.numeric(asa),
         mallampati = as.numeric(mallampati)) %>% #converts characters into numeric, very useful
  mutate(bmi_4groups= cut(bmi, 4, labels = c("1st quartile", "2nd quartile", "3rd quartile", "4th quartile"))) %>%## a column cutting BMI into quartiles (4 equal parts); HINT: cut() function
  select(patient_id, bmi, age, smoking, gender, everything()) %>% 
  arrange(patient_id) #- Arrange patient_id column of your dataset in order of increasing number or #alphabetically

write_csv(merged_data2, here("data_processed", "data_merged.csv")) #write output so others scripts can use it
  

#summary(merged_data2)
#skimr::skim(merged_data2)
