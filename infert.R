#set library location
lib.loc <- "~/R/win-library/3.5"

#load packages
library("readxl", lib.loc="~/R/win-library/3.5")
library("tidyverse", lib.loc="~/R/win-library/3.5")
library("meta", lib.loc="~/R/win-library/3.5")
library("here", lib.loc="~/R/win-library/3.5")
library("janitor", lib.loc="~/R/win-library/3.5")

#load and view data
infert_data <- read_excel("infert_data.xlsx")
View(infert_data)

#clean off last two rows and view
infertb<- infert_data[-c(9,10),]
View(infertb)

#clean names
infertc<-clean_names(infertb)

# select study, year, and 4 key colums
infertd<-select(infertc,"study","year","uc_infertile","uc_fertile","ipaa_infertile","ipaa_fertile")

#generate meta1
meta1<-metabin(event.e=ipaa_infertile,
              n.e=ipaa_infertile+ipaa_fertile,
              event.c=uc_infertile,
              n.c=uc_infertile+uc_fertile, 
              sm="RR",
              data=infertd,
              method="I", 
              studlab=paste0(study,","," ", "(",year,")"))

#make forest plot
forest(meta1,col.square="black",col.diamond="black",print.I2 = TRUE)

#make funnel plot
funnel(meta1)

#make trim and fill variant of funnel plot
tf1<-trimfill(meta1)
funnel(tf1)



