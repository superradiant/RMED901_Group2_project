library(tidyverse)
library(here)
here()
library(tidyverse)
library(skimr)
library(here)


## a column cutting BMI into quartiles (4 equal parts); HINT: cut() function
merged_data2<- merged_data2 %>%
  mutate(bmi_4groups= cut(bmi, 4, labels = c("1st quartile", "2nd quartile", "3rd quartile", "4th quartile")))

#- a column coding gender to "Male" and "Female" instead of "0"/"1"
merged_data2 <-
  merged_data2 %>% 
  mutate(gender = if_else(gender == "F", "Female", "Male"))

View(merged_data2)

#- Set the order of columns as: `patient_id, BMI, age, smoking, gender` and #other columns
merged_data2<- merged_data2 %>% 
  select(patient_id, bmi, age, smoking, gender, everything()) 

#- Arrange patient_id column of your dataset in order of increasing number or #alphabetically.
merged_data2<- merged_data%>%
  arrange(patient_id)

#- Connect above steps with pipe Ingvilds steps
merged_data2<- merged_data2 %>% 
  mutate(gender = if_else(gender == "F", "Female", "Male")) %>% 
  mutate(bmi_4groups= cut(bmi, 4, labels = c("1st quartile", "2nd quartile", "3rd quartile", "4th quartile"))) %>% 
  select(patient_id, bmi, age, smoking, gender, everything()) %>% 
  arrange(patient_id)

