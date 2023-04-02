#13015.HU-LX concordance essai
##############################
library(readr)
library(stringi)
library(R.utils)
getwd()
datadir<-"local/HU-LX/SES" #database
codesdir<-"gith/HU-LX/data"

# now again from base DB
getwd()
list.files(getwd())
#setwd(datadir)
docscheme<-"sesCPT" #Sketchengine doc scheme
filescheme<-"_InlineCodes_SkE.txt" #transcript version extension
#list.files(datadir)
#d1<-read_delim("ses_vert.csv")
d1<-read_table(paste(datadir,"ses_40_v2_9-3.vert",sep = "/"))
#d1<-read_table("ses_40_v2_9.csv")
ruthtable<-paste(datadir,"ruthtable_kidsmeta.csv",sep = "/")
datestamp<-"13124"
datetime<-format(Sys.time(),"%Y%m%d(%H.%m)")
excelns<-paste0(datadir,"/",datetime,"_SES_database_by_tokens.xlsx")
#set<-d2
cleandb<-function(set){
  #set
  # delete <g/>, <s>, </s> rows
  # grep
  regx1<-"(<g/>)"
  regx2<-"(<s>)"
  regx3<-"(</s>)"
  # regx4<-"#|%|:" # NOT! exludes tokens including, e.g. #Ioanina
  m1<-grep(regx1,set$token)
  m2<-grep(regx2,set$token)
  m3<-grep(regx3,set$token)
  # m4<-grep(regx4,set$token)
  # exclude
  ex<-c(m1,m2,m3)
  set$gilt<-T
  set$gilt[ex]<-F
  #exin<-match(ex,set$X.1)
  d2<-subset(set,set$gilt==T)
}

#d3<-cleandb(d2)
#d<-d1
#set<-d1
spk_array<-c("GCA","GCB","GCC","GCD","GCE","GCF","GCG","GDA","GDB","GDC","GDD","GDE","GDF","TAA",
             "TAB","TAD","TAF","TAG","TAH","TAI","TBB","TBC","TBD","TBE","TBF","TBG","TBH","TBI",
             "TBK","TBL","TBM","TBN","TBO","TBP","TBQ","TBR","TBS","TBT","TBU","TBV","INT")

preprocess_temp<-function(set){
  d<-set
  #grep linenumbers
  regx1<-"[0-9]{4}"
  m1<-grep(regx1,d$token,value = T)
  m2<-grep(regx1,d$token)
  
  l2<-as.double(m1)
  l3<-l2-1
  d$token[m2]<-l3 #linenumbers minus 1, TODO: revert with CHAT coded transcripts starting conventionally
  
  ms<-grep("(#[A-Z]{3})",d$token) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  # distinct speakers:
  ms2<-grep("(#[A-Z]{3})",d$token,value = T) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  spk<-unique(ms2)
  # spk_array<-c("GCA","GCB","GCC","GCD","GCE","GCF","GCG","GDA","GDB","GDC","GDD","GDE","GDF","TAA",
  #              "TAB","TAD","TAF","TAG","TAH","TAI","TBB","TBC","TBD","TBE","TBF","TBG","TBH","TBI",
  #              "TBK","TBL","TBM","TBN","TBO","TBP","TBQ","TBR","TBS","TBT","TBU","TBV","INT")
  #spk_array<-c("GCB","GCC","GDA","GDB","GDC","GDD","GDE","GDF","TAD","TAH","TAI","TBD","TBE","TBS","TBT","TBU","TBV","INT")
  spk_array2<-paste0("#",spk_array)
  #spk_grep<-paste0(spk_array2,"|")
  spk_grep2<-paste0(spk_array2,collapse = "|")
  spk_grep3<-paste0("(",spk_grep2,")")
  spk_grep3
  ms3<-grep(spk_grep3,d$token) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  spk
  # try put column with flowing speaker declaration
  sp_d<-array()
  sp_ds<-array()
  sp_sentence_nr<-array()
  sp_sentence<-array()
  sp_sentence_cn<-array()
  sp_s_cn<-array()
  #k<-25
  ms<-ms3
  d$sentence_temp<-"---"
  d$speaker<-"---"
  
  ### output sentence
  for (k in 1:length(ms)){
    sp_sentence_cn<-array()
    
    sp_s<-ms[k]
    sp_p1<-ms[k]
    
    if (k<=length(ms))
      sp_e<-ms[k+1]-1
    if (k==length(ms))
      sp_e<-length(d$token)
    sp_p2<-ms[k+1]-1
    
    sp_ns<-d$token[sp_s]
    sp_s_cn<-paste(d$token[sp_s:sp_e],collapse = " ")
    d$sentence_temp[sp_s:sp_e]<-sp_s_cn
    d$speaker[sp_s:sp_e]<-sp_ns  
  } #end sentence loop
  ################ wks.
  #library(stringi)
  
  #ann<-data.frame(stri_split_fixed(d$cat,".",simplify = T))
  #anns<-c("")
  #ann<-c(rep("-",8))
  d3<-cbind(d,"-","-","-","-","-","-","-","-","-") # 9 empty POS columns
  #d3<-cbind(d2$speaker,d2$token,d2$lemma,d2$X1,d2$X2,d2$X3,d2$X4,d2$X5,d2$X6,d2$X7,d2$sentence,d2$sentence_cn)
  getwd()
  #cleanup
  regx<-("<s>|</s>|<g/>")
  repl<-""
  d4<-d3
  
  d4$sentence<-gsub(regx,repl,d$sentence_temp)
  #d3[10,]
  print(d4[19,])
  print(length(d4[1,]))
  #dns<-c("id","speaker","token","lemma","pos",",pos.check.OK","function","case","num","gender","mode","X","snr","sentence")
  # dns<-c("speaker","token","lemma","pos","cat","p1","p2","p3","p4","p5","sen_temp","sentence")
  d4<-data.frame(d4[,1:12],x8="-",x9="-",d4$sentence)
  dns<-c("token","cat","lemma","sentence_temp","speaker","x1","x2","x3","x4","x5","x6","x7","x8","x9","sentence")
  colnames(d4)<-dns
  #write.csv(d4,"sesDB001.csv")     
  #d4$sentence<-sp_sentence
  #d4$sentence_cn<-sp_sentence_cn
  dim(d3)
  # #grep linenumbers
  # regx1<-"[0-9]{4}"
  # m1<-grep(regx1,d4$token,value = T)
  # m2<-grep(regx1,d4$token)
  # 
  # l2<-as.double(m1)
  # l3<-l2-1
  # d4$token[m2]<-l3 #linenumbers minus 1
  m1<-grep(docscheme,d4$token) #join filedescription columns
  f1<-paste(d4$token[m1],d4$cat[m1],d4$lemma[m1],sep = " ")
  d4$token[m1]<-f1
  return(data.frame(d4))
} # end preprocess
###### wks.
#d3<-data.frame(d2)
#######################
#######################
#######################
d2<-cleandb(d1)
d2<-preprocess_temp(d1)
d3<-cleandb(d2)

#d2<-d4

#######################
#######################
#######################
#reorder
#print(d3[19,])
colnames(d3)
d4<-data.frame(d3$speaker,d3$token,d3$lemma,d3$sentence,d3$cat,d3$x1,d3$x2,d3$x3,d3$x4,d3$x5,d3$x6,d3$x7,d3$x8,d3$x9,d3$gilt)
dns<-c("speaker","token","lemma","turn","cat","x1","x2","x3","x4","x5","x6","x7","x8","x9","gilt")
colnames(d4)<-dns
colnames(d4)
#### new
#set0<-d4
get_pos<-function(set,set0){
  
  d4<-set
  dns[7:14]
  ann<-data.frame(stri_split_fixed(set0$cat,".",simplify = T))
  ns_g<-list()
  
  ns_g[[1]]<-unique(ann$X1)
  ns_g
  ns_g[[2]]<-unique(ann$X2)
  ns_g[[3]]<-unique(ann$X3)
  ns_g[[4]]<-unique(ann$X4)
  ns_g[[5]]<-unique(ann$X5)
  ns_g[[6]]<-unique(ann$X6)
  ns_g[[7]]<-unique(ann$X7)
  ns_g2<-list()
  ns_g2[["db"]]<-ns_g
  ns_g2[["cor"]][["pos"]]<-ns_g[[1]]
  ns_g2[["cor"]][["cat"]]<-c("Name","Inter","Full","Pers","Pun","Reg","Aux","Dem","Def","Neg","Pos",
                             "Indef","Ans","Paren","Coord","Sup","SubFin","Poss","Rel","Mod","Comp",
                             "Verb","Refl","Zu","Deg","Other","SubInf","Gen","Adj","Noun")
  ns_g2[["cor"]][["funct"]]<-c("Comma","Slash","Hyph","Aster","Subst","Sent","Left","Right","Psp","Attr","XY","Auth")
  ns_g2[["cor"]][["case"]]<-c("Nom","Gen","Dat","Acc")
  ns_g2[["cor"]][["pers"]]<-c(1,2,3)
  ns_g2[["cor"]][["num"]]<-c("Sg","Pl")
  ns_g2[["cor"]][["gender"]]<-c("Neut","Fem","Masc")
  ns_g2[["cor"]][["tense"]]<-c("Pres","Past","Cont")
  ns_g2[["cor"]][["mode"]]<-c("Ind","Subj") #"Subj" == conditional
  return(ns_g2)
  # its 9 fields! not 8
  # TODO: c("zu","Auth","Sent","Psp","Cont")
} # end get_pos

ns_g2<-get_pos(d4,d1)
##################

######################
getarray<-function(set,r){
  d5<-set
  #s1<-d5$pos_cpt[r]
  s1<-d4$cat[r]
  #s1<-d4$cat[119]
  
  s1
  #mxcolumns<-grep("x",colnames(d4))
  s2<-stri_split_regex(s1,"\\.",simplify = T)
  a<-c(s2)
  s2<-a
  rstar<-match(s2,"*")
  s2[rstar==T]<-"-"
  print(s2)
  return(s2)
}
#############################
# NEW: ######################
# get codes cpt, grep value of useable values in code, output to useable value standard position
#############################
#d5<-getdata()
d5<-d4
#r<-11
#top<-5
d6<-d5
#ma<-array()
#s2
#d6<-matrix(nrow = length(d5$id),ncol = 8)
#top<-1
#l<-2
##########################
# this is a 5 minute loop!
mxcolumns<-grep("x",colnames(d4))

for (r in 1:length(d5$cat)){
  #s2<- d5$pos_cpt[r]
  s2<-getarray(d4,r)
  for (top in 1:length(ns_g2$cor)){
    for (l in 1:length(ns_g2$cor[[top]])){
      m1<-match(ns_g2$cor[[top]][[l]],s2)
      #s2[m1]
      
      pos<-mxcolumns[1]-1+top
      ifelse (m1!=0,d6[r,pos]<-s2[m1],d6[r,pos]<-"-")
      #cat("check token: [",r,"], tag = ",d6[r,],"\n")
      #print(d6[r,])
      print(r)
    }
  }
  #d6[pos,1:8]<-ma
} # end POS position correction
###############################
head(d6)

d6safe<-d6
getwd()
### DEFINITELY SAFE AFTER RUN! ####
dbname<-paste0("sesDB013_d6safe_",datestamp,".csv")
write.csv(d6,dbname)
###### finalise
colnames(d6)

dns_x<-c("pos","category","funct","case","pers","num","gender","tense","mode")
mxcolumns<-grep("x",colnames(d6))
dns_o<-colnames(d6)
pos_ok<-"PoS_ok"
dns_n<-c(dns_o[1:5],pos_ok,dns_x,dns_o[length(dns_o)])
dns_o
dns_n
############################################################### !!!!!!!#######
d6[,pos_ok]<-1
dim(d6)
d7<-data.frame(d6$speaker,d6$token,d6$lemma,d6$turn,d6$cat,d6$PoS_ok,d6$x1,d6$x2,d6$x3,d6$x4,d6$x5,d6$x6,d6$x7,d6$x8,d6$x9,d6$gilt)
head(d7)
# dns_n<-c(1:length(dns_o))
# dns_n[1:mxcolumns[1]-1]<-dns_o[1:mxcolumns[1]-1]
# dns_n[mxcolumns[1]:mxcolumns[length(mxcolumns)]]<-dns_x
# dns_n[mxcolumns[length(mxcolumns)]+1]<-
#   dns_o[mxcolumns[length(mxcolumns)]+1:length(dns_o)]
# dns_n[mxcolumns[1]:mxcolumns[length(mxcolumns)]]<-dns_x
#d7<-d6
dns_n
colnames(d7)<-dns_n
#### post processing ##########################
# reread DB
#d7
#13101.new 32 transcript db
### paste docscheme here
regx1<-paste0("</",docscheme)
m1<-grep(docscheme,d7$token)
d7$token[m1[3]]
m4<-grep(regx1,d7$token) #transcript end
# d7$token[m2[1]]
regx2<-paste0("<",docscheme," id")
m3<-grep(regx2,d7$token) #transcripts start
regx3<-paste0("(SES_.*)(",filescheme,")")
m5<-grep(regx3,d7$token,value = T)
#m5<-grepl("(SES_.*)(sketchE)",d7$token)
regx4<-paste0(".*(SES_.*)(",filescheme,").*")
m6<-gsub(regx4,"\\1",m5) #kids
head(m6)
#here stepback
d8<-d7

# m6
k<-1
r<-1
l<-1
# first define 0 values to columns!
d8$interview<-0
d8$part_L1<-0
d8$part_sex<-0
d8$part_age<-0

for (l in 1:length(m6)){
  li<-array()
  #repl<-0
  for (k in 1:length(m3)){
    li<-m3[k]:m4[k] # define array of interview according to match start/end
    repl<-m6[k] # transcript name in array
    print(repl)
    typeof(repl)
    length(repl)
    ### 4. add participant metadata for analysis
    m1<-stri_split_fixed(repl,"_",simplify = T)
    d8$interview[li]<-m1[2]
    m2<-stri_split_boundaries(m1[,2],type="character",simplify = T)
    d8$part_L1[li]<-m2[1]
    d8$part_sex[li]<-m1[3]
    d8$part_age[li]<-m1[4]
    #}
  }
  
}
# wks., check:
d8$interview[3650:4800]
##############
# delete transcript references obsolete entries
m<-grepl(docscheme,d8$token)
sum(m)
repl1<-"---"
m2<-grepl("token",colnames(d8))
m3<-m2==F
d8[m,m3]<-repl1
# d8$speaker[m]<-"---"
# d8$lemma[m]<-"---"
# d8$sentence[m]<-"---"
# d8$cat[m]<-"---"
# d8$PoS_ok[m]<-"---"
# d8$pos[m]<-"---"
# d8$category[m]<-"---"
# d8$funct[m]<-"---"
# d8$case[m]<-"---"
# d8$pers[m]<-"---"
# d8$num[m]<-"---"
# d8$gender[m]<-"---"
# d8$tense[m]<-"---"
# d8$mode[m]<-"---"
# d8$gilt[m]<-"---"
#m_end_c[r]<-m  
tail(d8)
### clean lemma entry
lemma_a<-stri_split_boundaries(d8$lemma,type="word")
ll<-list()
x<-lapply(lemma_a,unlist)
for (k in 1:length(d8$lemma)){
  ll[k]<-x[[k]][1]
}
lemmalist<-unlist(ll)
m<-grep("[^A-Za-züöäß]",lemmalist)
lemmalist[m]<-""
#lemma_c<-gsub("[^A-Za-z]","",d8$lemma)
#length(lemmalist)
#lemmalist[7]
d8$lemma_c<-lemmalist

# write.csv(d8,"20230111(14.15)_SES_database_by_tokens+PoS_check_column.csv")
# write.csv(d8,"sesDB008.csv")
#wks.

#tail(d8$interview)
##############################
############## TODO:
# add coded feature columns
ms2<-grep("(#[A-Z]{3})",d8$turn,value = T) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
spk<-unique(ms2)
#spk_array<-c("GCA","GCB","GCC","GCD","GCE","GCG","GDA","GDB","GDC","GDD","GDE","GDF","TAA","TAB","TAD","TAF","TAG","TAH","TAI","TBD","TBE","TBH","TBI","TBK","TBL","TBM","TBQ","TBR","TBS","TBT","TBU","TBV","INT")
spk_array2<-paste0("#",spk_array)
#spk_grep<-paste0(spk_array2,"|")
spk_grep2<-paste0(spk_array2,collapse = "|")
spk_grep3<-paste0("(",spk_grep2,")")
spk_grep3
#ms3<-grep(spk_grep3,d$token) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
#spk
# grep codes
grepc<-paste0("(")
ms4<-grep("(#[A-Z]{3})",d8$turn,value = T)
# simple: delete speaker codes in sentence to grep only coded features
sent1<-gsub(spk_grep3,"%000%",d8$turn)
d8$turn[3000]
sent1[3000]
ms5<-grep("(#[A-Z]{3,3}|0[A-Z]{1,2})",sent1)
ms6<-head(unique(ms5))
ms6
# x<-ms6
# codec<-function(x){x+10}
# l<-c(1,2,3,4,5)   
# lapply(l,codec)
codef<-function(x) stri_extract_all_regex(x,"(#[A-Z]{3})")
#ms7<-lapply(ms6, codef)
ms7<-lapply(sent1, codef)
# unlist(head(ms7[ms5][]))
#ms7<-lapply(sent1, codef)
ms8<-unique(unlist(ms7)) #unique coded features
ms8<-ms8[!is.na(ms8)]

##########################
# d8[,22:34]<-"---"
tend<-length(d8)
tcodeend<-tend+length(ms8)
tcodestart<-tend+1
codecolumns<-tcodestart:tcodeend

#codecolumns<-grep("V",colnames(d8))
d8[,codecolumns]<-"---"
########################## NOT CHECKED!
#codem<-matrix(ms7[ms5])
r<-115
repl<-unlist(ms7[[r]])
for (r in 1:length(sent1)){
  repl<-unlist(ms7[[r]])
  l<-length(repl)
  #codecolumns<-mxcolumns
  codestart<-codecolumns[1]
  le<-codestart+l-1
  print(r)
  d8[r,codestart:le]<-repl
}#TODO: put codes in unique column each code one column
#ms8<-grep("([A-Z]{3,3})",sent1,value=T)
#ms8<-grepl("([A-Z]{3,3})",sent1)
#   head(ms7[ms5][][])
#   unique(sent1[ms8])
#   sent1[95]
# 13024.
mna<-is.na(d8[]) #global NA remove
d8[mna]<-"---"
#codecolumns<-grep("V",colnames(d8))
#lns<-length(d8[1,])-22
dns_code<-paste0("C",codecolumns)
colnames(d8)[codecolumns]<-dns_code
# TODO: sort columns priority
# sentence preceding interviewer line
# transcript lines references column, thus numbering lines in transkript
###
dbname<-paste0("sesDB013_d8safe_",datestamp,".csv")
write.csv(d8,dbname)
#################
# preceding line:
###
#d<-d8
postprocess_precede<-function(set){
  d<-set
  ms<-grep("(#[A-Z]{3})",d$token) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  # distinct speakers:
  ms2<-grep("(#[A-Z]{3})",d$token,value = T) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  spk<-unique(ms2)
  #  spk_array<-c("GCB","GCC","GDA","GDB","GDC","GDD","GDE","GDF","TAD","TAH","TAI","TBD","TBE","TBS","TBT","TBU","TBV","INT")
  spk_array2<-paste0("#",spk_array)
  #spk_grep<-paste0(spk_array2,"|")
  spk_grep2<-paste0(spk_array2,collapse = "|")
  spk_grep3<-paste0("(",spk_grep2,")")
  spk_grep3
  ms3<-grep(spk_grep3,d$token) #speaker lines #"(#[A-Z]{3})" = 4942 matches in raw data
  #spk
  # try put column with flowing speaker declaration
  sp_d<-array()
  sp_ds<-array()
  sp_sentence_nr<-array()
  sp_sentence<-array()
  sp_sentence_cn<-array()
  sp_s_cn<-array()
  line_precede<-""
  #k<-25
  ms<-ms3
  #d$sentence_temp<-"---"
  #d$speaker<-"---"
  d$turn_precede<-line_precede
  k<-2
  ### output sentence
  for (k in 1:length(ms)){
    # sp_sentence_cn<-array()
    sp_precede<-array()
    sp_s<-ms[k]
    sp_p1<-ms[k]
    
    if (k<=length(ms))
      sp_e<-ms[k+1]-1
    if (k==length(ms))
      sp_e<-length(d$token)
    sp_p2<-ms[k+1]-1
    spk_c<-d$speaker[sp_s]
    if (spk_c!="#INT"){
      line_precede<-d$turn[sp_s-1]
    }
    d$turn_precede[sp_s:sp_e]<-line_precede
    #sp_s_cn<-paste(d$token[sp_s:sp_e],collapse = " ")
    #d$sentence_temp[sp_s:sp_e]<-sp_s_cn
    #d$speaker[sp_s:sp_e]<-sp_ns  
    print(k)
  } #end sentence loop
  ################ wks.
  #library(stringi)
  d$turn_precede[d$speaker=="#INT"]<-""
  
  return(d)
} # end preprocess_precede
#check column
#d$checkline<-d$sentence
#apply:
d9<-postprocess_precede(d8)
#d8$lemma_c<-""
#sort DB
coldb<-colnames(d9)
colcodes<-grep("C",colnames(d9))
# d9b<-data.frame(interview=d9$interview,speaker=d9$speaker,token=d9$token,lemma=d9$lemma,lemma_c=d9$lemma_c,turn=d9$turn,turn_precede=d9$turn_precede,cat=d9$cat,PoS_ok=d9$PoS_ok,pos=d9$pos,category=d9$category,funct=d9$funct,case=d9$case,pers=d9$pers,num=d9$num,gender=d9$gender,tense=d9$tense,mode=d9$mode,part_L1=d9$part_L1,part_sex=d9$part_sex,part_age=d9$part_age,part_reside=d9$part_reside,part_family_language=d9$part_family_language,codes=d9[,colcodes],gilt=d9$gilt)
d9b<-data.frame(p_interview=d9$interview,p_speaker=d9$speaker,p_token=d9$token,p_lemma_SkE=d9$lemma,
                p_lemma=d9$lemma_c,p_turn=d9$turn,p_turn_preceding=d9$turn_precede,t_tag_SkE=d9$cat,
                t_PoS_ok=d9$PoS_ok,t_PoS=d9$pos,t_category=d9$category,t_funct=d9$funct,t_case=d9$case,
                t_pers=d9$pers,t_num=d9$num,t_gender=d9$gender,t_tense=d9$tense,t_mode=d9$mode,
                part_L1=d9$part_L1,part_sex=d9$part_sex,part_age=d9$part_age,codes=d9[,colcodes],m_feature_eval=FALSE,m_free_col=0)

#write.csv(d9b,"20230305(09.26)_SES_database_by_tokens.csv")
#write.csv(d9b,"sesDB012_d9b.csv")
#typeof(lemmalist)
#################################
#add ruth metadata:
dns<-colnames(d9b)
dns
# dns[4]<-"p_lemma_SkE"
# dns[5]<-"p_lemma"
# dns[7]<-"p_turn_preceding"
# dns[8]<-"t_tag_SkE"
# dns[10]<-"t_PoS"
# dns[42]<-"m_feature_eval"
colnames(d9b)<-dns
dns
### nice feature from correction issue: add column with transcript line numbers
lineextract<-function(x) stri_extract(x,regex="[0-9]{1,3}$")
ln<-lapply(d9b$p_turn, lineextract)
ln<-unlist(ln)
ln[1661]
d9b$p_transcriptLine<-ln
#d9c<-insert(d9b,d9b[,19],ln)
getwd()
meta<-read.csv(ruthtable)
mns<-colnames(meta)
m<-grep(NA,meta)
m<-is.na(meta)
meta[m]<-"N.A."
sum(m)
mns
d8<-d9b
#write_clip(spk_array)
for (k in meta$participant){
  #  k<-1
  sum(d8$token[d8$p_interview==k])
  d8$part_CoB[d8$p_interview==k]<-meta$CoB[meta$participant==k]
  d8$part_YiG[d8$p_interview==k]<-meta$YiG[meta$participant==k]
  d8$part_YoSH[d8$p_interview==k]<-meta$YoSH[meta$participant==k]
  d8$part_LPM[d8$p_interview==k]<-meta$LPM[meta$participant==k]
  d8$part_LPF[d8$p_interview==k]<-meta$LPF[meta$participant==k]
  d8$part_LUM[d8$p_interview==k]<-meta$LUM[meta$participant==k]
  d8$part_LUF[d8$p_interview==k]<-meta$LUF[meta$participant==k]
  d8$part_LUS[d8$p_interview==k]<-meta$LUS[meta$participant==k]
  d8$part_LUFR[d8$p_interview==k]<-meta$LUFR[meta$participant==k]
  
  
  
  
}
#chk
#d8$part_YiG[d8$p_interview=="TBV"]
#sum(d8$p_interview=="TBV")
d8ns<-colnames(d8)
colnames(d8)
d8ns
#rearrange columns
# d91<-d8[,1:5]
# d92<-d8[,43]
# d93<-d8[,6:21]
# d96<-d8[,22:41]
# d94<-d8[,44:51]
# d95<-d8[,42]

d91<-grep("p_",colnames(d8))
d91<-d8[,d91] #primary columns 8 = transcript line
d92<-grep("m_",colnames(d8))
d92<-d8[,d92]

d93<-grep("t_",colnames(d8))
d93<-d8[,d93]

d94<-grep("part_",colnames(d8))
d94<-d8[,d94]

d95<-grep("codes",colnames(d8))
d95<-d8[,d95]

#d95<-d8[,42]

#d8b<-c(d91,d92,d93)
d8b<-data.frame()
l2<-length(d91)
d8b[1:length(d91$p_interview),1:l2]<-d91
l1<-length(d8b)+1
l2<-l1+length(d92)-1
d8b[1:length(d91$p_interview),l1:l2]<-d92
l1<-length(d8b)+1
l2<-l1+length(d93)-1
d8b[1:length(d91$p_interview),l1:l2]<-d93
#l1<-length(d8b)+1
#l2<-l1+length(d94)-1
#d8b[1:length(d91$p_interview),l1:l2]<-d94 #skip for double occurence grep t_ & part_ above 
l1<-length(d8b)+1
l2<-l1+length(d95)-1
d8b[1:length(d91$p_interview),l1:l2]<-d95
# l1<-length(d8b)+1
# l2<-l1+length(d96)-1
# d8b[1:length(d91$interview),l1:l2]<-d96
dns<-colnames(d8b)
dns
#dns[6]<-"transcript_line"
#dns[31]<-"feature_eval"
#colnames(d8b)<-dns
#rearrange from .csv read (extra 1st column)
# d91<-d8[,2:19]
# d92<-d8[,25:41]
# d93<-d8[,42:50]
# d8b<-c(d91,d92,d93)
# d8b<-data.frame()
# l2<-length(d91)
# d8b[1:length(d91$interview),1:l2]<-d91
# l1<-length(d8b)+1
# l2<-l1+length(d93)-1
# d8b[1:length(d91$interview),l1:l2]<-d93
# l1<-length(d8b)+1
# l2<-l1+length(d92)-1
# d8b[1:length(d91$interview),l1:l2]<-d92

library(writexl)
getwd()
dbname<-paste0(datadir,"/sesDB013_",datestamp,".csv")
write.csv(d8b,dbname)
write_xlsx(d8b,excelns)

##############################################################################
# DB created above, read DB from .csv to make queries and concordances
# 
##############################################################################
# queries ######################
temprun<-function(){
  #d8<-read.csv("sesDB007.csv")
  #sampleq$id[k]
  #query[1,1]
  #k<-1
  query<-q3
  query$token
  k<-2
  set<-d9
  d9$lemma[k]
  m2
  q_sub<-function(set,k,query){
    #m1<-set
    #set<-d7
    m1<-set
    
    # colnames(m1)
    # m1<-subset(set,grepl(query$id[k],set[,1]))
    m2<-subset(m1,grepl(query$speaker[k],m1$speaker)) ### NOT with logical but grep, match etc.
    ifelse(query$token[k]==""|is.na(query$token[k]),
           m3<-m2,#subset(m2,grepl(query$token[k],m2$token)),
           m3<-subset(m2,query$token[k]==m2$token))
    m4<-subset(m3,grepl(query$lemma[k],m3$lemma))
    m4<-subset(m4,grepl(query$lemma_c[k],m4$lemma_c))
    m5<-subset(m4,grepl(query$pos[k],m4$pos))
    #m6<-subset(m5,grepl(query$pos.check.OK[k],m5[,6]))
    m7<-subset(m5,grepl(query$funct[k],m5$funct))
    m8<-subset(m7,grepl(query$case[k],m7$case))
    m9<-subset(m8,grepl(query$num[k],m8$num))
    m10<-subset(m9,grepl(query$gender[k],m9$gender))
    m11<-subset(m10,grepl(query$mode[k],m10$mode))
    m12<-subset(m11,grepl(query$regex[k],m11$turn))
    m13<-subset(m12,grepl(query$tense[k],m12$tense))
    m14<-subset(m13,grepl(query$pers[k],m13$pers))
    m15<-subset(m14,grepl(query$category[k],m14$category))
    m16<-subset(m15,grepl(query$part_L1[k],m15$part_L1))
    m17<-subset(m16,grepl(query$part_sex[k],m16$part_sex))
    m18<-subset(m17,grepl(query$part_age[k],m17$part_age))
    m19<-subset(m18,grepl(query$regex_turn_precede[k],m18$turn_precede))
    # sampleframe<-m19%in%m1
  }
  # RUN: #############
  #query declaration:
  tempfun_query<-function(){
    sampleq<-data.frame(speaker=0,token=0,lemma=0,category=0,pos=0,funct=0,case=0,pers=0,num=0,gender=0,tense=0,mode=0,regex=0,lemma_c=0,part_age=0,part_sex=0,part_L1=0,regex_turn_precede=0)
    #sampleq$id<-          ".*"
    sampleq$speaker<-     ".*"
    sampleq$token<-       ""    # has to be empty or exact match, not ".*" for empty
    sampleq$lemma<-       ".*"
    sampleq$lemma_c<-     ".*"
    sampleq$category<-    ".*"
    sampleq$pos<-         ".*"
    #sampleq$pos.check.OK<-".*"
    sampleq$funct<-       ".*"
    sampleq$case<-        ".*"
    sampleq$num<-         ".*"
    sampleq$pers<-        ".*"
    sampleq$gender<-      ".*"
    sampleq$tense<-        ".*"
    sampleq$mode<-        ".*"
    sampleq$part_L1<-     ".*"
    sampleq$part_age<-    ".*"
    sampleq$part_sex<-    ".*"
    sampleq$regex<-       ".*" # is searched for in $turn
    sampleq$regex_turn_precede<- "since"
    return(sampleq)
  }
  ####################
  querydf<-tempfun_query()
  write.csv(querydf,"sesDB_queryDF.csv")
  # for queries import DF and change values, use k=dataframe[k,] in subset function
  #query<-sampleq
  querydf[2:20,]<-querydf[1,]
  q3<-read.csv("sesDB_queryDF.csv",sep = ";")
  m2<-q_sub(d9,1,querydf)
  m3<-q_sub(d9,4,q3)
  unique(m3$turn)
  #set$sentence[m2]
  ####################
  # OUTPUT:
  #write.csv(unique(m2$turn),"sesDB009_exract_howLongInGermany.csv")
  write.csv(unique(m3$turn),"sesDB009_exract_familyLanguage.csv")
  
  m2$token
  m2
  ##### 1st query for how-long-in-germany-since
  #add metadata columns to DB #################
  d9$part_reside[d9$interview=="GCB"]<-8 #age 11 safe
  d9$part_reside[d9$interview=="GDA"]<-2 #age 11 safe
  d9$part_reside[d9$interview=="GDB"]<-3 #8 safe
  d9$part_reside[d9$interview=="GDD"]<-4 #9 safe
  d9$part_reside[d9$interview=="GDE"]<-10 #10 safe
  d9$part_reside[d9$interview=="GDF"]<-10 #11 u.V.
  d9$part_reside[d9$interview=="TAD"]<-5 #14
  d9$part_reside[d9$interview=="TBE"]<-6 #13 
  d9$part_reside[d9$interview=="TBS"]<-9 #12
  d9$part_reside[d9$interview=="TBT"]<-1970 #13
  d9$part_reside[d9$interview=="TBU"]<-11 #13
  d9$part_reside[d9$interview=="TBV"]<-12 #14
  
  d9$part_family_language[d9$interview=="GCB"]<-"G" #age 11 safe
  d9$part_family_language[d9$interview=="GDA"]<-"D/G" #age 11 safe
  d9$part_family_language[d9$interview=="GCC"]<-"G" #age 11 safe
  d9$part_family_language[d9$interview=="GDB"]<-"G" #8 safe
  d9$part_family_language[d9$interview=="GDD"]<-"G" #9 safe
  d9$part_family_language[d9$interview=="GDE"]<-"G" #10 safe
  d9$part_family_language[d9$interview=="GDF"]<-"D/G" #11 u.V.
  d9$part_family_language[d9$interview=="TAD"]<-"T" #14
  d9$part_family_language[d9$interview=="TBE"]<-"T" #13 
  d9$part_family_language[d9$interview=="TBS"]<-"T" #12
  d9$part_family_language[d9$interview=="TBT"]<-"T" #13
  d9$part_family_language[d9$interview=="TBU"]<-"D/T" #13
  d9$part_family_language[d9$interview=="TBV"]<-"D/T" #14
  
  #############################################################
  #write_csv(d9,"sesDB010")
  ##### other method subscript
  #}
  ##############################################################################
  # now concordances for kids:
  # 
  d8<-read.csv("local/HU-LX/SES/sesDB010.csv")
  d9<-d8
  
  temp_analyse<-function(){
    # unique tokens subsets after kids
    subc_int<-function(set,kid){
      d9<-set
      m1<-subset(d9,d9$interview==kid&gilt==T)
    }
    subc_kids<-function(set,kid){
      d9<-set
      m1<-subset(d9,d9$speaker==kid&gilt==T)
    }
    
    #GCB<-unique(subkids(d8,"#GCB")$token)
    tchk<-length(subkids(d8,"#GCB")$token)
    GCB<-subc_kids(d8,"GCB")
    GCB_i<-subc_int(d8,"GCB")
    library(quanteda)
    cgcb<-corpus(unique(GCB$sentence))
    #summary(c1)
    c1_tokens <- tokens(cgcb)
    kwic(c1_tokens, pattern = "der")
    162-23
    q1$from[1]
    q1$pattern[1]
    q1
    print(c1_tokens[121])
    # crosscheck with db
    #d1<-read_delim("ses_vert.csv")
    ### sample great concordance list for GCB
    GCB<-subc_kids(d8,"GCB")
    GCB_i<-subc_int(d8,"GCB")
    c1 <- tokens(cgcb)
    to<-unique(GCB$token)
    to
    length(GCB$token)
    t<-3
    kidc1<-function(set,to){
      kw<-list()
      for(t in 1:length(to)){
        c1<-corpus(unique(GCB$sentence))
        c2 <- tokens(c1)
        tns<-to[t]
        kw[[tns]][[t]]<-list(kwic(c2, pattern = to[t]))
      }
      return(kw)
      
    }
    GCB_c<-kidc1(GCB,t1)
    ####################
    #significance testing
    lm1<-grepl(q3$regex[5],d9$turn) #0AR
    lm1LG<-grepl("G",d9$part_L1)
    lm1LFG<-grepl("G",d9$part_family_language)
    lm1LT<-grepl("T",d9$part_L1)
    lm1LFT<-grepl("T",d9$part_family_language)
    
    library(lme4)
    lm1[lm1==T]<-1
    lm1[lm1!=T]<-0
    lm1LG[lm1LG==T]<-2
    lm1LFG[lm1LFG!=T]<-0
    lm1LFG[lm1LFG==T]<-2
    lm1LG[lm1LG!=T]<-0
    
    lme1<-lmer(lm1~part_reside+(1|part_L1)+(1|part_family_language),d9)
    x<-summary(lm1)
    x
    sum(lm1)
    library(lmerTest)
    library(stats)
    le1<-lm(lm1~part_family_language-1,d9)
    le1<-lm(lm1~part_L1-1,d9)
    le1<-lm(lm1~part_reside-1,d9)
    
    summary(le1)
    #anova(le1)
    plot(le1)
    # x<-gl(3,3,201,labels = c("eins","zwei","drei"))
    # x
  }
  #####################################
  ### from here to continue db progress
  ### postprocess finalize DB
  d8<-read.csv("local/HU-LX/SES/sesDB010b.csv")
  # dns<-colnames(d8)
  # dns
  # dns[5]<-"lemma_SkE"
  # dns[6]<-"lemma"
  # dns[8]<-"turn_preceding"
  # dns[9]<-"tag_SkE"
  # dns[11]<-"PoS"
  # colnames(d8)<-dns
  # d9<-d8[3:length(d8)]
  # write.csv(d9,"local/HU-LX/SES/sesDB010b.csv")
  
  # integrate kids meta
  meta<-read.csv("local/HU-LX/SES/ruthtable_kidsmeta.csv")
  mns<-colnames(meta)
  mns
  for (k in meta$participant){
    d8$part_CoB[d8$interview==k]<-meta$CoB[meta$participant==k]
    d8$part_YiG[d8$interview==k]<-meta$YiG[meta$participant==k]
    d8$part_YoSH[d8$interview==k]<-meta$YoSH[meta$participant==k]
    d8$part_LPM[d8$interview==k]<-meta$LPM[meta$participant==k]
    d8$part_LPF[d8$interview==k]<-meta$LPF[meta$participant==k]
    d8$part_LUM[d8$interview==k]<-meta$LUM[meta$participant==k]
    d8$part_LUF[d8$interview==k]<-meta$LUF[meta$participant==k]
    d8$part_LUS[d8$interview==k]<-meta$LUS[meta$participant==k]
    d8$part_LUFR[d8$interview==k]<-meta$LUFR[meta$participant==k]
    
    
    
    
  }
  #chk
  #d8$YiG[d8$interview=="TBU"]
  d8ns<-colnames(d8)
  d8ns
  #rearrange columns
  d91<-d8[,2:19]
  d92<-d8[,25:41]
  d93<-d8[,42:50]
  d8b<-c(d91,d92,d93)
  d8b<-data.frame()
  l2<-length(d91)
  d8b[1:length(d91$interview),1:l2]<-d91
  l1<-length(d8b)+1
  l2<-l1+length(d93)-1
  d8b[1:length(d91$interview),l1:l2]<-d93
  l1<-length(d8b)+1
  l2<-l1+length(d92)-1
  d8b[1:length(d91$interview),l1:l2]<-d92
  
  library(writexl)
  write.csv(d8b,"local/HU-LX/SES/sesDB010c.csv")
  write_xlsx(d8b,"local/HU-LX/SES/20230321(19.18)_SES_database_by_tokens.xlsx")
}

