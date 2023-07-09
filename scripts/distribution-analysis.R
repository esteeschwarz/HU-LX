getwd()
root<-"local/HU-LX"
src<-paste(root,"SES/distribution_analysis_all-codes_all-kids.csv",sep = "/")
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
#s<-lmer(count~L1+(1|feature),d1)

s1<-summary(s)
coef<-s1$coefficients
coef<-round(coef,3)
#coef[,1:5][order(coef[,5])]

coef
write.csv(coef,paste(root,"eval/distribution_significance-test.csv",sep = "/"))
#plot(s1$residuals)
s1
s1$coefficients[,1][order(s1$coefficients[,5])]
###
#model lmer
d2<-d1
d2$count<-20
d2$count[d2$feature=="NSM"&d2$L1=="T"]<-19
#d2$count[d2$feature=="NSM"&d2$kid=="TBU"]<-30
#d2$count[d2$feature=="NSM"&d2$kid=="TBD"]<-30
#d2$count[d2$feature=="NSM"&d2$kid=="TBQ"]<-30

#d2$count[d2$feature=="NSM"&d2$kid=="GCA"]<-19

s<-lmer(count~feature+(1|L1),d2)
#s<-lmer(count~L1+(1|feature),d2)

s2<-summary(s)
s2
coef<-s2$coefficients
#coef<-round(coef,3)
coef
write.csv(coef,paste(root,"eval/distribution_significance-test_MODEL.csv",sep = "/"))
save(s2,file=paste(root,"eval/distribution_significance-test_MODEL.txt",sep = "/"))
length(s1$coefficients[,1])==length(unique(d2$feature))
