#13266.HU-LX.metadata edit
#20230629(19.22)
################
library(readr)
library(stringi)
library(writexl)

root<-"~/Documents/GIT/HU-LX"
src<-paste(root,"data/metadata_export_collection14_20230629-18_50.csv",sep = "/")
d1<-read.csv(src)
local<-"~/boxHKW/UNI/21S/DH/local/HU-LX"
src2<-paste(local,"meta/20230627(17.29)_SES audio status table.csv",sep = "/")
d2<-read.csv(src2,sep = ";",skip = 1)
kids<-unique(d2$Child.code)
kids<-kids[kids!=""]
audio.raw<-data.frame(child=kids)
for(k in kids){
  m<-d2$Child.code==k
  m2<-audio.raw$child==k
  audio.raw$tape[m2]<-paste(d2$Cas..[m],d2$Side.A.B[m],collapse = ",")
}

targetchild<-stri_extract_all_regex(d1$Title,"[A-Za-z]{3}",simplify = T)
targetchild[,2]<-toupper(targetchild[,2])
d1$childcode<-targetchild[,2]
for (k in kids){
m<-d1$childcode==k
m2<-audio.raw$child==k
d1$audio.raw[m]<-audio.raw$tape[m2]
}
for (k in kids){
  m<-d1$childcode==k
  m2<-d2$Child.code==k
  d1$combined.in.hu.box[m]<-d2$cut.renamed.in.BOX[m2]
  d1$anon.in.berlangedev[m]<-d2$anonymised.in.BERLANGDEV[m2]
}
write_xlsx(d1,paste(local,"meta/20230629(20.23)_SES_status-table_v1.0.xlsx",sep = "/"))



kids
