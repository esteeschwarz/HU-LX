#13266.HU-LX.metadata edit
#20230629(19.22)
################
library(readr)
library(stringi)
library(writexl)
library(clipr)
getwd()
root<-"~/Documents/Github/HU-LX"
root<-"~/boxHKW/21S/DH/local/HU-LX/meta"
#src<-paste(root,"data/metadata_export_collection14_20230629-18_50.csv",sep = "/")
src<-paste(root,"meta/metadata_export_collection14_20230821-11_46.csv",sep = "/")
src<-paste(root,"meta/metadata_export_collection14_20230821-17_45.csv",sep = "/")
src<-paste(root,"meta/metadata_export_collection14_20230904-09_22.csv",sep = "/")
src<-paste(root,"meta/metadata_export_collection14_20230904-11_30.csv",sep = "/")
src<-paste(root,"metadata_export_propertiesfextpdf_titleses_20230930-15_36.csv",sep = "/")
src<-paste(root,"metadata_export_propertiesfextpdf_titleses_20230930-15_57.csv",sep = "/")
src<-paste(root,"metadata_export_collection14_20230930-16_11.csv",sep = "/")


d1<-read.csv(src)
k.u<-unique(d1$Target.child[d1$Ressourcen.Typ=="Transcript"]) #42
g.pdf<-grepl("pdf",d1$Original.filename)
sum(g.pdf)
#14401.status
d1
d11<-d1[!g.pdf,] # only resources not pdf
d11<-d1
k.u.sp<-unique(d11$Target.child[d11$Ressourcen.Typ=="Transcript"]) #32
k.u.au<-unique(d11$Target.child[d11$Ressourcen.Typ=="Audio"]) #32
k.u.pdf<-unique(d11$Target.child[d11$Ressourcen.Typ=="PDF"])
# spk_array<-c("GCA","GCB","GCC","GCD","GCE","GCF","GCG","GDA","GDB","GDC","GDD","GDE","GDF","TAA",
#              "TAB","TAD","TAF","TAG","TAH","TAI","TBB","TBC","TBD","TBE","TBF","TBG","TBH","TBI",
#              "TBK","TBL","TBM","TBN","TBO","TBP","TBQ","TBR","TBS","TBT","TBU","TBV")
sketchdir<-"~/boxHKW/21S/DH/local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text/docx-txt/sketchmode/v3.4.1/version without header for SketchEngine upload"
headerdir<-"~/boxHKW/21S/DH/local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text/docx-txt/SES_transcripts_w_header_v3_4_13302"
#all available transformed and uploaded transcripts:

chkspk<-list.files(sketchdir)
spkns<-stri_split_regex(chkspk,"_",simplify = T)
length(spkns[,2])
spk_array<-c(spkns[,2])
m<-spk_array %in% k.u.sp
spk_array[which(!m)] #which transcript not in berlangdev / GCD: but filename in db false...
chkspk<-list.files(headerdir)

m<-spk_array %in% k.u.au
spk_array[which(!m)] #which audio not in berlangdev 
write_clip(spk_array[which(!m)])


write_clip(k.u)

### create markdown table of DF
m<-c(1,8,7,length(d1))
df.md<-d11[,m]
df.md<-df.md[order(df.md$Target.child),]
#sample md:
"
|column|explanation|example|
|:--|:---|:---|
|p_interview|transcript|GCA|
|p_speaker|speaker|#GCA|
"
df.md.h<-paste0("|",paste(colnames(df.md),collapse = "|"),"|")
df.md.1<-paste0("|",paste(rep(":--",length(df.md)),collapse = "|"),"|")
df.md.x<-array()
k<-1
for(k in 1:length(df.md[,1])){
  print(k)
  df.md.x[k]<-paste0("|",paste(df.md[k,],collapse = "|"),"|")
  
}
library(xfun)
df.status<-data.frame(child=spk_array,CHAT=0,sanscodes=0,pdf=0,audio=0,missing=0)
k<-24
for(k in 1:length(d1$Ressourcen.ID.s.)){
  file.ns<-file_ext(d1$Original.filename[k])
  file.sep<-stri_split_regex(d1$Title[k],"_",simplify = T)
  file.pdf<-grep("pdf",d1$Original.filename[k])
  kid<-d1$Target.child[k]
  pos<-which(df.status$child==kid)
  ifelse ("CHAT" %in% file.sep,
    df.status$CHAT[pos]<-1,df.status$missing[pos]<-paste(df.status$missing[pos],"CHAT",collapse = "/"))
  ifelse ("sanscodes" %in% file.sep,
    df.status$sanscodes[pos]<-1,df.status$missing[pos]<-paste(df.status$missing[pos],"sanscodes",collapse = "/"))
  ifelse ("anon" %in% file.sep,
    df.status$audio[pos]<-1,df.status$missing[pos]<-paste(df.status$missing[pos],"audio",collapse = "/"))
  ifelse (length(file.pdf)>=1,
    df.status$pdf[pos]<-1,df.status$missing[pos]<-paste(df.status$missing[pos],"pdf",collapse = "/"))
}
df.status.c<-df.status[,1:5]
getmd<-function(set){
  
df.md<-set
df.md.h<-paste0("|",paste(colnames(df.md),collapse = "|"),"|")
df.md.1<-paste0("|",paste(rep(":--",length(df.md)),collapse = "|"),"|")
df.md.x<-array()
k<-1
for(k in 1:length(df.md[,1])){
  print(k)
  df.md.x[k]<-paste0("|",paste(df.md[k,],collapse = "|"),"|")
  
}


df.md.x
#df.md.c<-c(df.md.h,df.md.x)
df.md.head<-"## csv to md table
"
return(df.md.c<-c(df.md.head,df.md.h,df.md.1,df.md.x))
}
df.md.c<-getmd(df.status.c)
#df.md.c.o<-df.md.c[order(df.md.c[,2])]

write_clip(df.md.c)
getwd()
writeLines(df.md.c,"ses-status.md")
#src<-paste(root,"meta/metadata_export_collection14_20230705-06_27.csv",sep = "/")
#d1<-read.csv(src)

local<-"~/boxHKW/21S/DH/local/HU-LX"
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

