src<-"distribution_analysis_all-codes_all-kids.csv"
library(readr)
d1<-read.table(src,col.names = c("feature","kid","count"))
m<-grep("^T",d1$kid)
d1$L1[m]<-"T"
m<-grep("^G",d1$kid)
d1$L1[m]<-"G"

d1$feature<-gsub("c_","",d1$feature)
par(las=3)
boxplot(d1$count~d1$kid)
