library(tidyverse)
library(here)
here()
library(skimr)
library(patchwork)
library(devtools)
library(ggplot2)
library(usethis)


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


#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
### We have used age as continuous variable

###gender and age (min, max, mean and sd)
merged_data2 %>% 
  group_by(gender) %>% #stratified by gender
  summarise(max(age, na.rm = T), min(age, na.rm = T), mean(age, na.rm = T), sd(age, na.rm=T))

#create a variable telling if BMI is above BMI25
merged_data2<-merged_data2 %>% 
  mutate(BMI_above25= if_else(bmi>25, "BMI above 25", "BMI under 25"))
View(merged_data2)

#  Only for persons with BMI <25
merged_data2 %>% 
  filter(BMI_above25=="BMI under 25") %>% 
  summarise(max(age, na.rm = T), 
            min(age, na.rm = T), 
            mean(age, na.rm = T), 
            sd(age, na.rm=T))


#Only females,  min, max, mean and sd for AGE
merged_data2 %>% 
  filter(gender== "Female") %>% #only women
  summarise(max(age, na.rm = T), min(age, na.rm = T), mean(age, na.rm = T), sd(age, na.rm=T))

#- Only for persons older than 50 years of age
# age in patients above 50 years
merged_data2 %>% 
  filter(age> 50) %>% 
  summarise(max(age, na.rm = T), 
            min(age, na.rm = T), 
            mean(age, na.rm = T), 
            sd(age, na.rm=T)) 


#- Only for persons who had experienced coughing at extubation
merged_data2 %>% 
  filter(extubation_cough>0) %>% #patient had cough 
  summarise(max(age, na.rm = T), 
            min(age, na.rm = T), 
            mean(age, na.rm = T), 
            sd(age, na.rm=T)) 



