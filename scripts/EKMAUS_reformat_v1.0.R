#13177.HU-LX.EKMAUS.reformat transcripts
#20230428(18.29)
################
library(readtext)
library(quanteda)
library(stringi)
getwd()
#setwd("local/HU-LX/EKMAUS")
files1<-list.files("expo")
#setwd("expo")
tra<-5
t1<-readLines(paste("expo",files1[tra],sep="/"))
#t1
m1<-grep("<M 1>",t1)
m2<-grep("<M A",t1)
m3<-grep("<M 2",t1)
m4<-grep("<M",t1) #AS204: 1411
s1<-c(m1,m2,m3) #1405 dif 6 lines
e1<-unique(t1[m4])
e1
m5<-grep("<M",t1, invert = T)
int1<-"<M 1>"
int2<-"<M 2>"
ch1<-"<M A S2 " #FALSE kid OCR, has to be AS204
m6<-grep(int1,t1)
m7<-grep(int2,t1)

int2true<-sum(m7)==0
  
m8<-grep(ch1,t1)
e2<-c(m6,m7,m8) #length: 1387, dif: 54
#1441-1387
#########
#t2<-data.frame(id=1:length(t1),edit1=0,edit2=0)
#k<-9
#T: loop array of speakerlines, check for next speakerline and paste all lines til that into one
# for(k in 1:length(m6)){
#   tstart<-m6[k]
#   tnext<-m6[k]+1
#   n<-0
#   tproof<-grepl("<M",t1[tnext:tnext+n])
#   for (n in 0:20){
#   ttx1<-t1[tstart+n]
#   tproof<-function(x) grepl("<M",x)
# tpx<-tproof(t1[tstart+n])
#     if(!tpx){
#     t2$edit1[tstart]<-paste(t1[tstart],t1[tnext],sep = "#%space%#")
#    tpx<- tproof(t1[tstart+n])
#   }
#   }
# }
tl<-length(t1)
#####
# set<-m6
# for(k in 1:length(set)){
#   tstart<-set[k]
#   tnext<-set[k+1]
#   tlast<-grep("<M",t1[tstart:tnext])[2]-2+tstart
#   tnext-tstart
#   tstart1<-tstart+1
#   tsp<-t1[set[k]]
#   t2$edit1[tstart]<-paste0("#",tsp,"#",paste(t1[tstart1:tlast],collapse  = " "))
# }  
# set<-m7
# for(k in 1:length(set)){
#   tstart<-set[k]
#   tnext<-set[k+1]
#   tlast<-grep("<M",t1[tstart:tnext])[2]-2+tstart
#   tnext-tstart
#   tstart1<-tstart+1
#   tsp<-t1[set[k]]
#   t2$edit1[tstart]<-paste0("#",tsp,"#",paste(t1[tstart1:tlast],collapse  = " "))
# }  
# 
# set<-m8
# for(k in 1:length(set)){
#   tstart<-set[k]
#   tnext<-set[k+1]
#   tlast<-grep("<M",t1[tstart:tnext])[2]-2+tstart
#   tnext-tstart
#   tstart1<-tstart+1
#   tsp<-t1[set[k]]
#   t2$edit1[tstart]<-paste0("#",tsp,"#",paste(t1[tstart1:tlast],collapse  = " "))
# }  
 set<-m6
# k<-581
# k<-336
# k<-484
 tabm<-2
# length(m6)
getlines<-function(t1,t2,m,tabm){
set<-m
# tabsep<-"\t"
# tabm<-2
# tabsepcom<-stri_join(rep(tabsep,tabm),collapse = "")

for(k in 1:length(set)){
  tstart<-set[k]
  ifelse(k<length(set),
#  ifelse(set[k]<tl,
    tnext<-set[k+1],tnext<-tl)
  tlast<-grep("<M",t1[tstart:tnext])[2]-2+tstart
  # if(is.na(tlast))
  #   tlast<-grep("<END",t1[tstart:tnext])[2]-2+tstart
  tnext-tstart
  tstart1<-tstart+1
  if(is.na(tlast))
    tlast<-grep("<END",t1[tstart1:tnext])+tstart-1
  tsp<-t1[set[k]]
  tabsep<-"\t"
#  tabm<-2
  tabsepcom<-stri_join(rep(tabsep,tabm),collapse = "")
  t2$edit1[tstart]<-paste0("*",tsp,":",tabsepcom,paste(t1[tstart1:tlast],collapse  = " "))
  
}
#m<-t2$edit1!=0
#t3<-as.data.frame(t2$edit1[m])
#t3
return(t2)
}
t2<-data.frame(id=1:length(t1),edit1=0,edit2=0)
t3<-getlines(t1,t2,m6,2)
t4<-t3
if(!int2true)
   t4<-getlines(t1,t3,m7,2)

t5<-getlines(t1,t4,m8,1)
m<-t5$edit1!=0
t6<-t5$edit1[m]
#t6
tns<-files1[tra]
writeLines(t6,paste("reformatted",tns,sep = "/"))
dir.create("EKMAUS_CHAT_reformatted")
writeLines(t6,paste("EKMAUS_CHAT_reformatted",tns,sep = "/"))

getwd()
# for(k in 1:length(m8)){
#   tstart<-m8[k]
#   tnext<-m8[k+1]
#   tlast<-grep("<M",t1[tstart:tnext])[2]-2+tstart
#   tnext-tstart
#   t2$edit1[tstart]<-paste(t1[tstart:tlast],collapse  = "#%space%#")
# }  

  #n<-0
  #tproof<-grepl("<M",t1[tnext:tnext+n])
  # for (n in 0:20){
  #   ttx1<-t1[tstart+n]
  #   tproof<-function(x) grepl("<M",x)
  #   tpx<-tproof(t1[tstart+n])
  #   if(!tpx){
  #     t2$edit1[tstart]<-paste(t1[tstart],t1[tnext],sep = "#%space%#")
  #     tpx<- tproof(t1[tstart+n])
  #   }
  # }
#}
# for(k in 1:length(m8)){
#   tstart<-m8[k]
#   tnext<-m8[k]+1
#   n<-0
#   tproof<-grepl("<M",t1[tnext:tnext+n])
#   for (n in 0:20){
#     ttx1<-t1[tstart+n]
#     tproof<-function(x) grepl("<M",x)
#     tpx<-tproof(t1[tstart+n])
#     if(!tpx){
#       t2$edit1[tstart]<-paste(t1[tstart],t1[tnext],sep = "#%space%#")
#       tpx<- tproof(t1[tstart+n+1])
#       if(!tpx){
#         t2$edit2[tstart]<-paste(t2$edit1[tstart],t1[tstart+n+1],sep = "#%space%#")
#         tpx<- tproof(t1[tstart+n])
#       }
#     }
#   }
# }
# 

