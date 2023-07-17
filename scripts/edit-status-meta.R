#13266.HU-LX.metadata edit
#20230629(19.22)
################
library(readr)
library(stringi)
library(writexl)
getwd()
root<-"~/Documents/Github/HU-LX"
root<-"local/HU-LX"
src<-paste(root,"data/metadata_export_collection14_20230629-18_50.csv",sep = "/")
d1<-read.csv(src)
#src<-paste(root,"meta/metadata_export_collection14_20230705-06_27.csv",sep = "/")
d1<-read.csv(src)

local<-"~/boxHKW/UNI/21S/DH/local/HU-LX"
src2<-paste(local,"meta/20230627(17.29)_SES audio status table.csv",sep = "/")
d2<-read.csv(src2,sep = ";",skip = 1)
src2<-paste(local,"meta/metadata_export_collection14__20230705-06_27.csv",sep = "/")
src2<-paste(local,"meta/metadata_export_collection14_20230717-15_15.csv",sep = "/")
# for some idiot reason sometimes the .csv is exporte with 2, sometimes with one underscore
d3<-read.csv(src2,sep = ",")
"~/boxHKW/UNI/21S/DH/local/HU-LX/meta"
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

src2<-paste(local,"meta/metadata_export_collection14_20230717-15_15.csv",sep = "/")
# for some idiot reason sometimes the .csv is exporte with 2, sometimes with one underscore
d3<-read_csv(src2)
d3$Title<-gsub("_TUR|_ELL","",d3$Title)
d3$`Original filename`<-gsub("_TUR|_ELL","",d3$`Original filename`)


k1<-d3$Title
#k1<-gsub("_TUR|_ELL","",k1)

k2<-stri_split_regex(k1,"_",simplify = T)
k2[,2]
k3<-toupper(k2[,2])
k3
d3$`Target child`<-k3
d3$`Age of target child`<-paste0('"',k2[,4],'"')
d3$project<-"SES"
d3$Country<-"Germany"
d3$`Language of interview`<-"German"
mint<-d3$Interviewer
kids<-unique(d3$`Target child`)
k<-"GCA"
d4<-d3
# for (k in kids){
#   set<-subset(d4,d4$Target.child==k)
#   int<-unique(set$Interviewer)
#   l1<-unique(set$Languages.of.target.child)
#   loc<-unique(set$Location.of.interview)
#   d4$Languages.of.target.child[d4$Target.child==k]<-l1
#   d4$Interviewer[d4$Target.child==k]<-int
#   d4$Location.of.interview[d4$Target.child==k]<-loc
#   
# }
write_csv(d4,paste(local,"meta/20230717(16.07)_SES_meta_edited.csv",sep = "/"))
d5<-read_csv(src2)
#13303.uploaded to berlangdev, wks.

