library(tidyverse)
library(here)
here()
library(skimr)
install.packages("patchwork")
library(patchwork)
library(devtools)
library(ggplot2)
library(usethis)

#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
#We have used age as continuous variable

#gender and age (min, max, mean and sd)
Age_by_gender <- merged_data2 %>% 
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



