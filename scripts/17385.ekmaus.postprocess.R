f<-paste0(Sys.getenv("GIT_TOP"),"/local/ocr/run/ekmaus/gemini_transcription-t")
dirs<-list.dirs(f,full.names=T)
dirs<-dirs[2:length(dirs)]
### combine
df<-data.frame(id=1:length(dirs),code=NA,text=NA)
conc<-function(folder){
ns<-basename(folder)
nu<-unlist(strsplit(ns,"_"))
files<-list.files(folder,full.names=T)
  t<-lapply(seq_along(files),function(i){
    t<-readLines(files[i])
    t<-c(t,paste0('<pb n="',i,'"/>'))
    

  })
  tu<-unlist(t)
  sg<-unlist(strsplit(nu[3],""))
  rlist<-list(list(code=nu[1],ps=nu[2],sex=sg[1],age=sg[2],lang=nu[4],t=tu))
  names(rlist)<-nu[1]
  return(rlist)
}
basename(dirs[1])
c1<-conc(dirs[1])
head(c1)
basedf<-lapply(dirs,function(x){
  l<-conc(x)
})
save(basedf,file=paste0(Sys.getenv("HKW_TOP"),"/HU-LX/EKMAUS/2026/ekmaus.basedf.RData"))
#### wks.
#########
## remove codes
basemod<-basedf
basemod[[1]]
pdir<-paste0(Sys.getenv("GIT_TOP"),"/local/ocr/run/ekmaus/transcripts-p")
dir.create(pdir)
sdir<-paste0(Sys.getenv("HKW_TOP"),"/HU-LX/EKMAUS/2026/transcripts_sanscodes_anon")
dir.create(sdir)
x<-basemod[[1]]
bm<-lapply(basemod,function(x){
t<-x[[1]]$t
print(head(t))
t<-gsub("#.+?#","",t)
t<-paste(t,collapse="\n")
ns<-paste0(c(x[[1]]$code,x[[1]]$ps,x[[1]]$sex,x[[1]]$age,x[[1]]$lang),collapse="_")
ns<-toupper(ns)
ns<-paste0(ns,"_sanscodes_anon.txt")
ns<-paste0(sdir,"/",ns)
writeLines(t,ns)  
df<-data.frame(code=x[[1]]$code,ps=x[[1]]$ps,sex=x[[1]]$sex,age=x[[1]]$age,lang=x[[1]]$lang,text=t)
})
head(bm[[1]])
length(bm)
library(abind)
mdf<-data.frame(abind(bm,along=1))
save(mdf,file=paste0(Sys.getenv("HKW_TOP"),"/HU-LX/EKMAUS/2026/ekmaus.mdf.RData"))
#### wks.
#########
## writetext

paste0(letters,collapse="_")
