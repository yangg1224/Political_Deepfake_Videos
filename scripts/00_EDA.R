#### Preamble ####
# Purpose: This script produce the EDA analysis.
# author: "Yingying Zhou, Yang Wu, Xinyi Xu, Hong Pan"
# Data: 14 March 2021
# Contact: yingying.zhou@utoronto.ca; xiny.xu@mail.utoronto.ca; yangg.wu@mail.urotonto.ca
# License: MIT
# Pre-requisites: 
# - None


#### Workspace setup ####
library(tinytex)
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(kableExtra)

library(here) # locate the file path
data<- load(here::here("inputs/data/deepfake.RData"))
EDA<- dat%>%
  select(treat, response_wave_ID, exp_1_prompt, meta_OS, age_65, educ, PID, crt, gender, age, polknow, internet_usage, ambivalent_sexism, post_favor_Warren,believed_true)

###----------------------------------------
###EDA---treat distribution 
###----------------------------------------
EDA<-EDA%>%
  drop_na(treat)

treat_map <- 
  EDA%>%
  ggplot(aes(x = treat, fill = treat)) +
  geom_bar(width = 0.7,position = "dodge") + 
  coord_polar()+
  scale_fill_manual(values = c("#DB7558", "#FFCF57","#8FCDD4","#F6A6B6", "#ACD8CB","#3E737D"))+
  labs(title = "Treat distribution",x="", y="Count") +
  theme_minimal()
treat_map

###----------------------------------------
###EDA---education level distribution by PID 
###----------------------------------------
edu <- 
  EDA%>%
  ggplot(aes(x = educ,fill=PID, )) +
  geom_bar(position="dodge") +
  labs(title = "Citizens with a high school degree or above are more likely to suppprt democratic and republican party",x= "Educational Level", y="Count")+
  scale_fill_manual(name = "Political Parties",values = c("#DB7558", "#FFCF57","#8FCDD4"))
edu

###----------------------------------------
###EDA---sexism by education level  
###----------------------------------------
EDA<-EDA%>%
  drop_na(ambivalent_sexism)

s1<-
  ggplot(EDA, aes(x = PID, y= ambivalent_sexism)) +
  geom_boxplot(outlier.colour="red", 
               outlier.shape=5,
               outlier.size=4) +
  labs(title="Sexism by partisanship level", x="PID", y="Sexism")+
  theme_economist() + scale_fill_economist() 
s1

###----------------------------------------
###EDA---internet usage frequency by education level
###----------------------------------------
G1<-ggplot(EDA, aes(x=internet_usage, fill=educ)) + 
  geom_area(alpha=0.8 , size=0.2, colour="black", stat = "count")+
  labs(title = "Internet usage frequency by education level ",y="Counts",x="Days")+
  scale_fill_manual(name = "Education level", values = c("#DB7558", "#FFCF57","#8FCDD4","#F6A6B6"))

G2<-ggplot(EDA, aes(x=internet_usage, fill=meta_OS)) + 
  geom_area(alpha=0.8 , size=0.2, colour="black", stat = "count")+
  labs(title = "Internet usage frequency by devices ",y="Counts",x="Days")+
  scale_fill_manual(name = "Devices", values = c("#DB7558", "#FFCF57","#8FCDD4","#F6A6B6"))


G3<-ggplot(EDA, aes(x=internet_usage, fill=age_65)) + 
  geom_area(alpha=0.8 , size=0.2, colour="black", stat = "count")+
  labs(title = "Internet usage frequency by age group ",y="Counts",x="Days")+
  scale_fill_manual(name = "Age group", values = c("#DB7558", "#FFCF57","#8FCDD4","#F6A6B6"))


# combine two diagram in one graph
ggarrange(
  G1, G2, G3, 
  ncol = 3, nrow = 1,
  hjust = -0.5,
  align = "hv"
)

###----------------------------------------
###EDA---post favor by treat
###----------------------------------------

EDA<-EDA%>%
  drop_na(post_favor_Warren)

ggplot(EDA, aes(x = post_favor_Warren,fill=treat)) +
  geom_histogram(bins=15,color="white") +
  facet_grid(treat ~ .)+
  scale_fill_manual(values = c("#DB7558", "#FFCF57","#8FCDD4","#F6A6B6", "#ACD8CB","#3E737D"))+
  xlab("Feelings towards Sanders")+
  ggtitle("Distribution of feelings towards Warren in six different conditions")+
  theme_minimal()

