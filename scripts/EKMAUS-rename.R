folder<-"/Users/guhl/Documents/boxMINI/SNC/M8/lade/Kol_ID10-original_wk"
dirs<-list.dirs(folder,full.names = T)
dirs
d<-dirs[2]
setwd(d)
dl<-"."
f<-list.files(dl,full.names = T)
f
chk.s<-lapply(f, function(x){
  file.size(x)
})
chk.s
sum(duplicated(f))
s<-strsplit(f,"_")
s
reen.dep<-function(){
### this wks.
### has to read in files again to apply gsubs
s1<-lapply(s,function(x){
  n<-paste0(x[2:length(x)],collapse = "_")
})
s1
f
dl
sum(duplicated(s1))
file.rename(f,unlist(s1))
f<-list.files(dl)
f
f2<-gsub("_geschw..rzt","",f)
sum(duplicated(f2))
f2<-gsub(" ","",f2)
sum(duplicated(f2))
f2
f2<-gsub("_proofed","",f2)
sum(duplicated(f2))
f2
f2<-gsub("\\(.\\)","",f2)
sum(duplicated(f2))
f
f2
file.rename(f,f2)
}
s
library(abind)
sa<-abind(s)
sdf<-data.frame(matrix(abind(s,along=1),ncol = length(s[[1]]),byrow = T))
write.csv(sdf,"~/Documents/boxMINI/SNC/M8/lade/Kol_ID10-original_wk/temp-rename-audio-tr.csv")
md<-lapply(s, function(x){
  
})
s2<-gsub("geschw..rzt","",s2)
s2<-gsub("geschw..rzt","",s2)
sum(duplicated(s2))
s2
f<-list.files(dl)
f
f
s3<-read.csv(paste0(folder,"/rename-ekmaus-audio-de.csv"))
s3<-s3[,2:length(s3)]
s3
s4<-lapply(seq_along(s3[,1]),function(i){
  paste0(s3[i,1:length(s3)],collapse = "_")
})
s4

getwd()
f
file.rename(f,unlist(s4))
dirs
chk.f<-lapply(list, function)


