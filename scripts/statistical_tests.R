#Does the treatment depend on the patient's gender
Test_gender_vs_patient <- merged_data2 %>%
  mutate(treatment=ifelse(treatment=="Yes", 1, 0), 
          gender=ifelse(gender=="Male", 0, 1)) %>% 
  t.test( treatment~gender, data = .)
broom::tidy(Test_gender_vs_patient)

#Does the treatment depend on the preoperative smoking
Test_treatment_vs_smoking <- merged_data2 %>%
  mutate(treatment=ifelse(treatment=="Yes", 1, 0),
         smoking=ifelse(smoking=="Never", 0, 1)) %>% 
  t.test(treatment~smoking, data = .) %>%
  broom::tidy(Test_treatment_vs_smoking)

#Does the treatment depend on the preoperative pain
Test_treatment_vs_pain <- merged_data2 %>%
  mutate(treatment=ifelse(treatment=="Yes", 1, 0), 
         pain=ifelse(pain=="Yes", 1, 0)) %>% 
  t.test(treatment~pain, data = .)
broom::tidy(Test_treatment_vs_pain)
