# Abstract
With the growing ubiquity of deepfake technology, here comes one more channel for the spread of misinformation. We reproduce Soubhik Barari (2021) paper and identify several additional demographic traits contributing to the persuasion power of deepfake on political defamation through its material effect on feeling manipulation in a RCT field experiment on the 2020 Presidential election. We find little evidence that deepfake videos have a unique ability to shift viewers’ perceptions on politicians. Apart from partisanship, education, and other socioeconomic factors identified by the original paper, we discover that income and internet usage would also significantly impact the candidate’s affective appeal to the news feed viewer. 

# Overview of the Data
The paper intends to replicate the experimental report by Soubhik Barari, Christopher Lucas, and Kevin Munger. We are going to analyze the dataset collected by their experiment. The survey dataset records 5,750 observations with 100 variables. In this case, we focus on the top 20 most important features related to the favorability towards the Democratic politician Elizabeth Warren. 

The description of the variables are as followed:
* Age group: categorical variable with two levels, <65 and 65+.
* Ambivalent Sexism: evaluates negative stereotypes towards women on a scale of 1 to 5.
* PID: shows the party identification of Republican, Independent, or Democrat.
* Polknow: scaled to be within 0 to 1, reflecting respondents’ political knowledge that might influence public attitudes and opinions.
* Treat: one of the six treatment conditions in the experiment: deepfake video, false media in audio, text, skit, campaign attack ad, or control.
* Exp_1_prompt: information about the intervention: received information and received no information on deepfake prior to the newsfeed experiment.
* Internet_usage: information about the frequency of using the internet per week.
* Meta_OS:the platforms of internet access, namely either mobile devices or desktop.
* Educ: four categories by educational level including <High school, High school, College, and Postgraduates.
* HHI: income levels including <$25k, $25k-$49k, $50k-$74k, $75k-$99k, $100k-$150k, and >$150k.
* Post_favor_Warren: ranging from 0 to 100  as the effective response to Warren after subjects receive the news feed treatment.

# File Structure
* Scripts: the folder contains R codes to import and clean data.
* Input: The raw dataset and cleaned dataset are in the "data" subfolder.
* Output: the "paper" subfolder contains pdf, R code and reference list of the paper. The "literature" subfolder contains the original paper written by Soubhik Barari, Christopher Lucas, and Kevin Munger and the literature used in our paper.

