
###4. Day 7: Create plots that would help answer these questions:

  
  
# age and amount of smoking
  #Making a binary variable whether the patient smokes or not. HOWEVER, all patients are smokers
merged_data2<- merged_data2 %>% 
  mutate(smokingYN= ifelse(smoking == 0, "no smoking","smoking" ))
smokingYN

plot_smoking<-ggplot(merged_data2,
                 aes(
                   x=smokingYN,
                   y= age)) +
  geom_jitter(aes(col=smokingYN))
plot_smoking

#easy plot
plot_smoking<-ggplot(merged_data2,
                     aes(
                       x=smoking,
                       y= age)) +
  geom_jitter(aes(col=smoking))
plot_smoking


#a histogram would probably show the data and/or trend better divided by age

plot_smoking2<-ggplot(merged_data2, aes(x=smoking, y=age)) +
                        geom_col(aes(fill = gender), position=position_dodge())
plot_smoking2


#Age distribution and gender
plot_gender_age<-ggplot(merged_data2,
                     aes(
                       x=gender,
                       y= age)) +
  geom_jitter(aes(col=gender))
plot_gender_age

#Boxplot with ages and gender
boxplot_gender_age2<-ggplot(merged_data2,
                        aes(
                          x=gender,
                          y= age)) +
geom_boxplot(aes(col=gender))
boxplot_gender_age2
# The age distribution is quite similar between genders

#Showing the plots side by side
plot_gender_age + boxplot_gender_age2

#  - Does the preoperative pain change with age of the patients?
preoperative_pain_plot<-ggplot(merged_data2,
                               aes(
                                 x=pain,
                                 y= age)) +
  geom_jitter(aes(col=pain))
preoperative_pain_plot


#preoperative pain and age histogram grouped my gender #putting pain as factor to avoid
plot_preoperativepain<- ggplot(merged_data2, 
                               aes(x=as.factor(pain), y=age)) + 
  geom_col(aes(fill = age), position=position_dodge())+
  facet_wrap(facets = vars(gender))+
  xlab("Pain")+
  ylab("Age")+
  labs(title = "Preoperative pain",
       subtitle = "Grouped by gender")
plot_preoperativepain

  
#  - Do BMI and age have a linear relationship? This makes a scatterplot over these two variables
scatterplotBMI_AGE<-ggplot(merged_data2,
                           aes(x=age,
                               y=bmi)) + 
  geom_point()
scatterplotBMI_AGE



merged_data2 %>% glimpse()
merged_data2 %>% count(smoking)

