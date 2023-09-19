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
         bmi = `BMI kg/m2`,
         age = preOp_age,
         smoking = preOp_smoking,
         pain = preOp_pain,
         treatment = treat) # renames column head
#gender <- merged_data2 %>%
#  +     group_by(preOp_gender, gender) %>%
#  +     reframe(preOp_gender, gender)
#View(gender) #both gender Columns are the same. One can be deleted
merged_data2 <- merged_data2 %>%
  mutate(gender = case_when(gender == "0" ~ "M",
                            gender == "1" ~ "F",
                            TRUE ~"Other")) %>%
  mutate(asa = as.numeric(ASA),
         mallampati = as.numeric(Mallampati))#converts characters into numeric, very useful


summary(merged_data2)
skimr::skim(merged_data2)



#Task
#Create a set of new columns:
#a column showing whether severity of cough changed from "extubation" to "pod1am"
#a column showing whether severity of throat pain changed from "pacu30min" to "pod1am"



merged_data2 %>% mutate(extubation_cough=as.factor(extubation_cough)) %>% glimpse()

merged_data2 %>% mutate(changeincough = if_else(pod1am_cough == extubation_cough, "No", "Yes")) %>% count(changeincough)


# Task 13.09
# task a column showing whether severity of cough changed from "extubation" to "pod1am"
merged_data2 <- merged_data2 %>% mutate(changeincough = if_else(pod1am_cough == extubation_cough, "No", "Yes"))

# task column showing whether severity of throat pain changed from "pacu30min" to "pod1am"
merged_data2 <- merged_data2 %>% mutate(changeinpain = if_else(pod1am_cough == pacu30min_throatPain, "No", "Yes"))



