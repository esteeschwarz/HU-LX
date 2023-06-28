getwd()
root<-"local/HU-LX/SES"
src<-paste(root,"distribution_analysis_all-codes_all-kids.csv",sep = "/")
library(readr)
library(lme4)
library(lmerTest)
d1<-read.table(src,col.names = c("feature","kid","count"))
m<-grep("^T",d1$kid)
d1$L1[m]<-"T"
m<-grep("^G",d1$kid)
d1$L1[m]<-"G"

d1$feature<-gsub("c_","",d1$feature)
par(las=3)
boxplot(d1$count~d1$kid,main="coded feature sums over targetchilds")
boxplot(d1$count~d1$feature, main="coded features over corpus")

s<-lmer(count~feature+(1|L1),d1)
s<-lmer(count~L1+(1|feature),d1)

s1<-summary(s)
#plot(s1$residuals)
s1
