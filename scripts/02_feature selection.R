#### Preamble ####
# Purpose: This script produce the Feature selection.
# author: "Yingying Zhou, Yang Wu, Xinyi Xu, Hong Pan"
# Data: 14 March 2021
# Contact: yingying.zhou@utoronto.ca; xiny.xu@mail.utoronto.ca; yangg.wu@mail.urotonto.ca
# License: MIT
# Pre-requisites: 
# - None


#### Workspace setup ####
library(tinytex)
library(tidyverse)
library(palmerpenguins)
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(hrbrthemes)
library(kableExtra)
library(broom)
library(randomForest)
library(plyr)

####Clean the data 

# delete the columns we dont need
FS<- dat%>%
  select(-c(PID_presurvey,comments,PID_leaners,script,quality_pretreat_duration_tooquick,quality_pretreat_duration_tooslow,ambivalent_sexism_1,ambivalent_sexism_2,ambivalent_sexism_3,ambivalent_sexism_4,ambivalent_sexism_5,believed1_true,believed_attackad_true,believed1_attackad_true,believed_offensive,believed_offensive1,believed_funny,believed_funny1,believed_informative,believed_informative1,exp_1_prompt_control,exp_1_prompt_info,exp_2_prompt_control,exp_2_prompt_accuracy,post_favor_Klobuchar,post_favor_Sanders,post_favor_Biden,post_favor_Bloomberg,,exp_2_pct_correct,exp_2_pct_false_fake,exp_2_pct_false_real,post_media_trust1,post_media_trust2,post_media_trust3,post_media_trust,post_dig_lit_1,post_dig_lit_2,post_dig_lit_3,post_dig_lit_4,post_dig_lit_5,post_dig_lit_6,post_dig_lit_7,PID_main,crt1,crt2,crt3,agegroup,treat_control,treat_attackad,treat_fake_text,treat_fake_video,treat_fake_audio,treat_skit,polknow_speaker,polknow_boris,polknow_house,polknow_senate,polknow_veto,polknow_warren,polknow_medicare,quality_demographic_mismatch,quality_failed_backend_attncheck,duration_secs,age,meta_screenres,StartDate,EndDate,meta_resolution,exp_2_hifake,exp_2_lofake,exp_2_nofake,exp_2,exp_2_prompt_accuracy,exp_2_after_debrief,exp_2_prompt,Zip,believed_true))%>% na.omit()

# build feature selection model

set.seed(123)

FS_tree<-randomForest(post_favor_Warren~., data=FS, ntree=500, importance=TRUE,proximity=TRUE) ## variable importance

FS_tree<-as.data.frame(FS_tree$importanceSD) # transform to dataframe

FS_tree<- FS_tree[order(-FS_tree[,]),,drop=FALSE] # sort importance by descending order

FS_tree<- cbind(Variable_name = rownames(FS_tree), FS_tree)

rownames(FS_tree) <- 1:nrow(FS_tree)

FS_tree<- as.data.frame(FS_tree)

# create a slip plot for feature importance 
FS_tree%>%
  mutate(name = fct_reorder(FS_tree$Variable_name,FS_tree$`FS_tree$importanceSD`))%>%
  ggplot(aes(x=FS_tree$Variable_name, y=FS_tree$`FS_tree$importanceSD`)) +
  geom_segment( aes(x=FS_tree$Variable_name,xend=FS_tree$Variable_name, y=0, yend=FS_tree$`FS_tree$importanceSD`), color="grey") +
  geom_point( color="orange", size=4) +
  theme_light() +
  coord_flip()+
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("Importance value")+
  ggtitle("Variable importance plot")%>%
  ggsave(device = "png",
         width = 8,
         height = 6,
         dpi = 300,
         path =  'outputs/paper/')

## remove low importance feature 
FS<- FS%>%select(-c(script_loans,quality,Hispanic))