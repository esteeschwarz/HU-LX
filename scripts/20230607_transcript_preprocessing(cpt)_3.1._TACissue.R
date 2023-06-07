#13407.hu-lx reformatting
#20221007(20.35)
#20221015(18.12) please download the most recent version of the script always
#here: https://github.com/esteeschwarz/HU-LX/blob/main/scripts/
#important: the script as provided in the box (.md instead of .R) will not work in R language
#since all escaped (e.g. "\\.") characters are converted to standard markdown ("\."),
#saying if you want to have the script run in R you have to use the github version.
#NT: script is now in .txt for convenient view
#also all source transcript files are referenced locally and are accessible only via your HU-box.
################
library(R.utils)
library(readtext)
#library(memoise)
library(readr)
library(glue)
library(stringi)
library(clipr)
library(fs)
library(xfun)
library(jsonlite)
# 1. global variables
#setwd("~")
#getwd()
path_home()
# set version:
outputschemes<-c("original","sketchE","sansCodes","inlineCodes","temp")
scheme<-outputschemes[4]
sdelim<-T #wrap SkE lines <s></s>
sketchwrap<-c("<s>","</s>")

datestamp<-"13235"
version<-"v3_4"
sketchversion<-"v3.4.1"
numbered<-T
ske<-F #not change!
codesubstitute<-" "
inlinecodewrap<-c("C_","_") #wrap for inline codes
chatfileextension<-".txt"
#for export in .cha format to import into exmaralda
#dirchat<-paste0(dirchat,"_cha_",version)
#chatfileextension<-".cha"
boxfolderns<-"version without header for SketchEngine upload"
#codesource<-paste0(path_home(),"/Documents/GitHub/DH_essais/sections/HU-LX/codes_cpt4mod.csv")
#######
#mini
#setwd("~/boxHKW/21S/DH/")
#lapsi
#setwd("~/boxHKW/UNI/21S/DH/")
#minirig
setwd("/Volumes/EXT/boxHKW/UNI/21S/DH/")
getwd()
datetime<-Sys.Date()
datetime<-format(Sys.time(),"%Y%m%d(%H.%m)")
codesusedns<-paste0(datetime,"_codes_cpt_used_",version,".csv")
if (scheme==outputschemes[2]){
  ske<-T
  scheme<-outputschemes[4]
}
#dirtext<-paste0(getwd(),"/local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text")
#2nd run with all 32 transcripts formatted from docx > txt
dirtext<-paste0(getwd(),"/local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text/docx-txt")

#codesource<-"/r-temp/codes_cpt3mod.csv"
#codesource<-"gith/DH_essais/sections/HU-LX/codes_cpt4mod.csv"
#codesource<-"gith/HU-LX/data/codes_cpt4mod.csv"
getwd()
codeusedir<-"local/HU-LX/SES"
codesdir<-"gith/HU-LX/data"
codesource<-"gith/HU-LX/data/codes_cpt5.csv"
codesource<-"local/HU-LX/SES/codes_cpt6.csv"
transdbns<-paste0("transdb_",datestamp,".json")
transdbdir<-codeusedir
transdb<-list()
#codesource<-"local/HU-LX/SES/fcodes_cpt_unique_d24.csv"
#codesource<-"local/HU-LX/SES/codes_cpt_usedv2_9.csv"

metatable<-read.csv("local/HU-LX/SES/ruthtable_kidsmeta.csv")
list.files(dirtext)
#dirmod<-paste0(dirtext,"modified/")
dirmod<-dirtext #after manual regex modifying in VSCode
#version<-"v2_8_sketchE_INLINE_C"
if (scheme==outputschemes[1])
  dirchat<-paste("SES_transcripts",version,datestamp,"CHAT",sep  = "_")
if (scheme==outputschemes[3]){
  dirchat<-paste("SES_transcripts",version,datestamp,"clean-without-codes",sep="_")
  codesubstitute<-codesubstitute}
if (scheme==outputschemes[4])
  dirchat<-paste("SES_transcripts",version,datestamp,"InlineCodes",sep="_")
if (numbered==T)
  dirchat<-paste(dirchat,"linenumbers",sep="_")
#dirchat<-paste("SES_CHAT_transcripts",scheme,version,datestamp,sep="/")
#dirchat<-paste0("SES_transcripts_",version)
#dirchat<-paste0("SES_transcripts_",version)

#dirchat<-paste0("CHAT_temp",version)
dir_2ndmod<-"sketchmod"
chatvmodified<-paste(version,"mod",sep="_")
#list.files(paste(dirtext,"SES_CHAT_transcripts_v2_7",sep = "/"))
if (scheme==outputschemes[1])
  transextension<-"_CHAT"

if (scheme==outputschemes[3])
  transextension<-"_sanscodes"
if (scheme=="sketchE")
  transextension<-"_sketchE"
if (scheme==outputschemes[4])
  transextension<-"_InlineCodes"


dirtext
dirmod
#dirout<-paste(dirtext,"out2",sep = "/")
dirout<-paste(dirtext,dirchat,sep = "/")  
dir.create(dirout)
dirtemp<-paste(dirtext,"r-temp",sep="/")
dirtemp
#obsolete, array created from fix .csv table (create code substitution array with search/replace patterns
###wks.
#external codes .csv table
codes_cpt <- read_delim(codesource, 
                        delim = ",", escape_double = T) #numbers: sep = ","
codes_nna<-!is.na(codes_cpt$codes)
#codes_nna<-array(codes_nna)
codes_cpt_nna<-codes_cpt[codes_nna,]
codes_cpt<-codes_cpt_nna
m<-!duplicated(codes_cpt$codes)
codes_cpt<-codes_cpt[m,]
m<-grep("codes",colnames(codes_cpt))
s<-m-2
c2<-codes_cpt[,s:length(codes_cpt)]
mode(c2$scheme)<-"character"
m<-is.na(c2)
m
c2[m]<-""
codes_cpt<-c2
### refine codes
# u3<-unique(codes_cpt$phrase)
# u4<-unique(codes_cpt$feature)
# u2<-unique(codes_cpt$pre3)
# u1<-unique(codes_cpt$pre2)
# u5<-unique(paste0(u1[1],u2))
# u6<-unique(paste0(u1[3],u2))
# u7<-unique(paste0(codes_cpt$pre2,codes_cpt$pre3))
# u8<-unique(paste(codes_cpt$phrase,codes_cpt$feature,sep  = " "))
# codesmod<-codes_cpt
# for (k in codesmod$pre2){
#   if (codesmod$pre2[k]=="N")
#      codesmod$phrase[k]<-"nonstandard"
#   
# }

# 2.
#get source files in top directory
filelist<-list.files(dirtext,pattern="(\\.txt)")
filelist
# chatv1<-grepl("CHAT",filelist)
# #filelist<-filelist[chatv1==F]
# #from here skip with already CHAT transformed transcript to second run
# filelist3<-filelist[chatv1]
#secondrun(filelist[chatv1==T])
#surface changes to transcript
#remove hardcoded linenumbers in some transcripts
#loop correction
trans_mod_array<-list()
#k<-8
#f<-8
#TODO: the following function has must be applied only to the transcript, not to the header section
#try create subscript of transcript containing just the interview section
#maybe apply part of postprocessing routine first to tag discrete coding in header
#precodesfun<-function(set,f){
#f<-8
k<-1
linecor<-function(k,filelist){
  #     
  #   precodes<-subset(codes_cpt,codes_cpt$category==7)
  # # for (f in length(filelist)){
  # #   tbu<-readLines(paste(dirtext,filelist[f],sep = "/"))
  # #   tbu<-gsub(precodes$regex,precodes$repl,tbu)
  # # }
  # #find transcript start
  # #for (f in 1:length(filelist2)){
  #   tbu<-readLines(paste(dirtext,filelist[f],sep = "/"))
  #   
  # mstart<-grep("^\\*",tbu)[1]
  # tbub<-tbu[mstart:length(tbu)]
  # tbusafe<-tbu
  # tbuheader<-tbu[1:mstart-1]
  # tbu<-tbuheader
  # rpall<-precodes
  # #for (k in 1:length(rpall$regex)) {
  #   m<-grep(rpall$regex,tbu)
  #   tbu<-gsub(rpall$regex,rpall$repl,tbu,perl = T)
  #  # ifelse(m!=0,tbu<-insert(tbu,m+1,rpall$subst[k]),m<-"no")
  # #}
  # tburec<-c(tbu,tbub)
  # tburec
  # zzfil<-tempfile("kidschar")
  # #zz<-file(zzfil,"wb")
  # #nc<-nchar(tburec)
  # writeLines(tburec,zzfil,sep="§%#nl#§%")
  #return(zz)
  #}
  #write_clip(tburec)
  #k<-8
  # linecor<-function(k,filelist){
  ###single run
  #  readtext(zz)
  cc<-readtext(paste(dirtext,filelist[k],sep = "/"))
  cc1<-cc$text
  #find obsolete whitespace range 2 to 200 blanks
  regx1<-"[ ]{2,200}"
  repl1<-" "
  cc1<-gsub(regx1,repl1,cc1)
  #find all line breaks
  regx1<-"\n"
  repl1<-"§%#nl#§%"
  cc2<-gsub(regx1,repl1,cc1)
  cc2
  #write_clip(cc2)
  regx1<-'"'
  repl1<-"'"
  cc3<-gsub(regx1,repl1,cc2,perl = T)
  regx1<-'\t'
  repl1<-" "
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  regx1<-"[^A-Za-z0-9.,=;\\-?:ß'+#*!§$%&/() @äöüÄÖÜ_…@]"
  repl1<-""
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  
  regx1<-"(§%#nl#§%)([A-Za-z.,=;\\-?:ß'+#*!§$%&/()äöüÄÖÜ_])" #newline starting with character or special character
  repl1<-" \\2"
  #repl1<-"\\2"
  
    cc3<-gsub(regx1,repl1,cc3,perl = T)
  #13142.
  regx1<-":([A-Za-z#%\\.,;'-\\(\\)])"
  repl1<-": \\1"
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  regx1<-":  ([A-Za-z#%\\.,;'-\\(\\)])"
  repl1<-": \\1"
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  #write_clip(cc3)
  
  
  #only for linenumbered transcripts
  #delete linenumbering & hard breaks within IP
  #regex groups: 1:newline 2:linenumbering 3:phrase
  regx1<-"(?<=(§%#nl#§%))([0-9]{0,3}). " 
  repl1<-""
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  #write_clip(cc3)
  #solve: " '
  regx1<-'"'
  repl<-"'"
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  #write_clip(cc3)
  
  regx1<-"(?<=(\\*[A-Z]{3}))(\\*)" #doubled false * after speaker spec
  repl1<-""
  m<-gregexec(regx1,cc2,perl = T)
  regmatches(cc2,m)
  cc2b<-gsub(regx1,repl1,cc3,perl = T)
  cc3<-cc2b
  
  ###: solve "*TAH: Oh Lachen*INT: Nein is ist gar keine schwere" (source) (not linebreaked IP)
  regx1<-"(?<!(§%#nl#§%))(\\*[A-Z]{3})"
  repl1<-"§%#nl#§%\\2"
  cc3<-gsub(regx1,repl1,cc3,perl = T)
  
  regx1<-"§%#nl#§%(?=(@|[0-9]{1,3}|\\*))"
  repl1<-"\n"
  m<-gregexec(regx1,cc2,perl = T)
  regmatches(cc2,m)
  cc2b<-gsub(regx1,repl1,cc3,perl = T)
  cc3<-cc2b
  
  
  #restore linebreaks
  regx1<-"§%#nl#§%"
  repl1<-"\n"
  cc4<-gsub(regx1,repl1,cc3)
  write_clip(cc4)
  cc5<-cc4
  #wks.
  dir.create(dirout)
  #delete hard line numbering
  # regx1<-"[0-9]{1,3}.[^\n](\\*)"
  # repl1<-"\\1"
  # cc5<-gsub(regx1,repl1,cc4)
  kids<-strsplit(filelist,"\\.")
  #kids[[2]][1]
  corfilename<-paste0(kids[[k]][1],"_cor03.txt")
  # writeLines(cc5,paste(dirout,corfilename,sep = "/"))
  #writeLines(cc5,paste(trans_mod_temp,corfilename,sep = "/"))
  writeLines(cc5,paste(trans_mod_tempdir,corfilename,sep = "/"))
  trans_mod_array[k]<-cc5
  return(cc5)
}
#cc5
#call line correction function over source files array
filelist1<-list.files(dirtext,pattern="(\\.txt)")
filelist1
#temporary directory where output is saved during session and accessed in
#section 3.
#k<-8
#unlink("trans_temp") #not wks deleting tempdir
trans_mod_tempdir<-tempdir("trans_temp")
for (k in 1:length(filelist1)){
  linecor(k,filelist1)
  trans_mod_array[k]<-linecor(k,filelist1)
}
k<-1
filelist
cctemp<-linecor(k,filelist)
cat(cctemp)
trans_mod_array[k]
### end linecorrection
#wks.
#13435.fail newest linecorrection,

############
# 3.
#get modified files from temp dir
filelist2<-list.files(trans_mod_tempdir,pattern="(\\.txt)")
filelist2
#wks.
#here insert 4 & 5
#change codes from table to valid regex formula
# #external codes .csv table
####
# codeset <- read_delim(codesource, delim = ";", escape_double = T)
#subset<-c(1,2,3,4,4)
####
#tail(codes_cpt$regex)
regxcor<-function(codeset,subset){
  #subset codes
  codes_cpt<-subset(codeset,codeset$category==subset[1]|codeset$category==subset[2]|codeset$category==subset[3]|codeset$category==subset[4]|codeset$category==subset[5])
  codelength<-length(codes_cpt$codes)
  # k<-60
  codes_cpt$feature[55:67]
  codes_cpt$codes[55:67]
  
  #regxa<-"(mostly)"
  for (k in 1:codelength){
    regxa<-codes_cpt$codes[k]
    regx1<-"\\?"
    repl1<-"\\\\?"
    regxb<-gsub(regx1,repl1,regxa)
    regx2<-"\\."
    repl2<-"\\\\."
    regxc<-gsub(regx2,repl2,regxb)
    regx3<-'"'
    #codes_cpt$codes[70]
    #minunderstands "wann"?#
    repl3<-"."
    regxd<-gsub(regx3,repl3,regxc)
    regx4<-"\\("
    repl4<-"\\\\("
    regxe<-gsub(regx4,repl4,regxd)
    regx4<-"\\)"
    repl4<-"\\\\)"
    regxf<-gsub(regx4,repl4,regxe)
    regx5<-"\\*"
    repl5<-"\\\\*"
    regxg<-gsub(regx5,repl5,regxf)
    
    codes_cpt[k,"regexcor"]<-regxg
    codes_cpt[k,"version"]<-version
  }
  return(codes_cpt)
}
codes_cpt$regexcor[55:67]
### correct codes with escaped characters, argument c() = categories, 1-4
codes_cpt2<-regxcor(codes_cpt,c(1,2,3,4,3))

####
regxmean<-function(set){
  #get regex gefräszigkeit, sort array by
  #loop
  #k<-15
  f<-1
  codes_cpt<-codes_cptu
  codes_cpt<-set
  regxout<-array()
  nfiles<-length(filelist2)
  regxmatrix<-matrix(nrow = length(codes_cpt$codes),ncol = nfiles+1)
  for (f in 1:length(filelist2)){
    tbu<-readtext(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
    for (k in 1:length(codes_cpt$codes)){
      regx1<-codes_cpt$regexcor[k]
      regxout<-stri_extract_all(tbu$text,regex=regx1)
      regxmatrix[k,f]<-mean(stri_count_boundaries(regxout[[1]],"character"),na.rm = T)
      regxmatrix[k,nfiles+1]<-mean(regxmatrix[k,],na.rm = T)
      # regxmatrix[is.na(regxmatrix)]<-0
    }
    #regxmatrix[,nfiles+1]<-lapply(regxmatrix,mean)
    codes_cpt$regxmean<-regxmatrix[,nfiles+1]
  }
  m<-!is.na(codes_cpt$regxmean)
  
  sum(m)
  # return(codes_cpt)
  return(codes_cpt[m,])
}
set<-codes_cpt2
####
regxmean2<-function(set){
  #get regex gefräszigkeit, sort array by
  #loop
  #k<-15
  f<-1
  #codes_cpt<-codes_cptu
  
  #set<-set
  regxout<-array()
  nfiles<-length(filelist2)
  regxmatrix<-matrix(nrow = length(set$codes),ncol = nfiles+1)
  for (f in 1:length(filelist2)){
    tbu<-readtext(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
    k<-319
    for (k in 1:length(set$codes)){
      regx1<-set$regexcor[k]
      regxout<-stri_extract_all(tbu$text,regex=regx1)
      #m<-grep(regx1,tbu$text)
      m<-length(regxout)
      #sm<-sum(m)
      #sm1<-sm+set$regexnr[k]
      #+treffer = -pos
      nchar<-stri_count_boundaries(regxout[[1]])
      nchar<-stri_count_boundaries(regxout)
    #  regxmatrix[k,f]<-mean(stri_count_boundaries(regxout[[1]],"character"),na.rm = T)
      regxmatrix[k,f]<-sum(nchar,na.rm = T)
      
      #regxmatrix[k,f]<-(sum(stri_count_boundaries(regxout[[1]],"character"))+1)/m
     # if(sm>0)
     #    regxmatrix[k,f]<-sum(stri_count_boundaries(regxout[[1]],"character"))/sm
     #  
         regxmatrix[k,f]<-sum(stri_count_boundaries(regxout[[1]],"character"),na.rm = T)/m/set$regexnr[k]+set$regexnr[k] #/sm
      rna<-!is.na(regxmatrix[k,])
      #rs<-sample(0.01:0.02,2)
      rna<-regxmatrix[k,]>0
      rnas<-sum(rna,na.rm = T)+1
      #rnas<-sm+1
        # regxmatrix[k,nfiles+1]<-mean(regxmatrix[k,],na.rm = T)
        # rna<-!is.na(regxmatrix[k,])
         #rnas<-sum(rna)
        # regxmatrix[k,nfiles+1]<-mean(regxmatrix[k,],na.rm = T)/rnas
         regxmatrix[k,nfiles+1]<-sum(regxmatrix[k,],na.rm = T)/rnas
#         regxmatrix[k,nfiles+1]<-rnas/sum(regxmatrix[k,],na.rm = T)
         
      # regxmatrix[is.na(regxmatrix)]<-0
    }
    #regxmatrix[,nfiles+1]<-lapply(regxmatrix,mean)
    set$regxmean<-regxmatrix[,nfiles+1]
  }
  m<-!is.na(set$regxmean)
  
  sum(m)
  # return(set)
  return(set[m,])
}
set<-codes_cpt2
######
k<-set$codes=="9nst"
regxmean3<-function(set){
  #get regex gefräszigkeit, sort array by
  #loop
  #k<-15
  f<-1
  #codes_cpt<-codes_cptu
  
  #set<-set
  regxout<-array()
  nfiles<-length(filelist2)
  regxmatrix<-matrix(nrow = length(set$codes),ncol = nfiles+1)
  for (f in 1:length(filelist2)){
    tbu<-readtext(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
#    k<-40 #9nst
    for (k in 1:length(set$codes)){
      regx1<-set$regexcor[k]
      regxout<-stri_extract_all(tbu$text,regex=regx1)
      #m<-grep(regx1,tbu$text)
      m<-length(regxout[[1]])
      #sm<-sum(m)
      #sm1<-sm+set$regexnr[k]
      #+treffer = -pos
      nchar<-stri_count_boundaries(regxout[[1]])
      nchar<-stri_count_boundaries(regxout)
      #  regxmatrix[k,f]<-mean(stri_count_boundaries(regxout[[1]],"character"),na.rm = T)
      regxmatrix[k,f]<-sum(nchar,na.rm = T)
      
      #regxmatrix[k,f]<-(sum(stri_count_boundaries(regxout[[1]],"character"))+1)/m
      # if(sm>0)
      #    regxmatrix[k,f]<-sum(stri_count_boundaries(regxout[[1]],"character"))/sm
      #  
      regxmatrix[k,f]<-sum(stri_count_boundaries(regxout[[1]],"character"),na.rm = T)/m/set$regexnr[k]+set$regexnr[k] #/sm
      rna<-!is.na(regxmatrix[k,])
      #rs<-sample(0.01:0.02,2)
      rna<-regxmatrix[k,]>0
      rnas<-sum(rna,na.rm = T)+1
      #rnas<-sm+1
      # regxmatrix[k,nfiles+1]<-mean(regxmatrix[k,],na.rm = T)
      # rna<-!is.na(regxmatrix[k,])
      #rnas<-sum(rna)
      # regxmatrix[k,nfiles+1]<-mean(regxmatrix[k,],na.rm = T)/rnas
      regxmatrix[k,nfiles+1]<-sum(regxmatrix[k,],na.rm = T)/rnas
      #         regxmatrix[k,nfiles+1]<-rnas/sum(regxmatrix[k,],na.rm = T)
      
      # regxmatrix[is.na(regxmatrix)]<-0
    }
    #regxmatrix[,nfiles+1]<-lapply(regxmatrix,mean)
    set$regxmean<-regxmatrix[,nfiles+1]
  }
  m<-!is.na(set$regxmean)
  
  sum(m)
  # return(set)
  return(set[m,])
}




#wks.
#
#then create neues regex combined array from escape corrected codes
getcodescpt<-function(set,codes){
  pre3<-paste0(set$pre2,set$pre3)
  chna<-!is.na(pre3)
  chna
  pre3<-pre3[chna]
  pre2<-set$pre2
  chna<-!is.na(pre2)
  chna
  pre2<-pre2[chna]
  prephrase<-set$phrase
  chna<-!is.na(prephrase)
  chna
  prephrase<-prephrase[chna]
  postphrase<-set$subst
  chna<-!is.na(postphrase)
  chna
  postphrase<-postphrase[chna]
  rpform<-data.frame()
  
  for(k in 1:length(postphrase)){
    ####wks.rp4<-subset(set$codes,set$subst==postphrase[k])          
    rp4<-subset(set$regexcor,set$subst==postphrase[k])          
    
    rpformX<-glue_collapse(rp4,sep = ")|(")          
    rpformXA<-paste0('(',rpformX,')')
    rpform[k,1]<-rpformXA
    #rpform[k,2]<-set$pre3[k]
    rpform[k,2]<-postphrase[k]
    #rpform[k,2]<-
  }
  return(rpform) #codesarray
}
#get feature array
getfeature<-function(set){
  feat_array<-data.frame()
  #set<-subwocom
  #set<-codes_cpt2
  length(set[[1]])
  for (k in 1:length(set[[1]])){
    feat_array[k,1]<-paste0(set$pre1[k],set$pre2[k],
                            set$pre3[k],": ",set$phrase[k]," ",set$feature[k])
    
  }
  return(feat_array)
}
#subwocom["subst"]<-feat_array[,1]
feat_array<-getfeature(codes_cpt2)
codes_cpt2["subst"]<-feat_array[,1]

length(unique(codes_cpt$codes))
#codesarray<-getcodes(codes_cpt2,regexcor)
codesarray<-getcodescpt(codes_cpt2,regexcor)
#157 cpt
length(codesarray)
codesarray[50,1]
#
ar<-unique(codesarray$V2)
codes_cpt2["ar"]<-match(codes_cpt2$subst,ar)
codes_cpt2["regexnr"]<-stri_count_boundaries(codes_cpt2$codes,"character")

#for (k in 1:length(codes_cpt$regexcor)){
# m<-codes_cpt$ar
codes_cpt2["regex"]<-codesarray$V1
#13113.flaw
m<-!duplicated(codes_cpt2$codes)
codes_cptu<-codes_cpt2[m,]
#codes_cpt4<-regxmean2(codes_cpt2) #cpt2
codes_cpt4<-regxmean3(codes_cpt2) #cpt2
#codes_cpt5<-!duplicated(codes_cpt$codes)

#save codes table
getwd()
# codedir<-"local/HU-LX/SES"
write_csv2(codes_cpt4,paste(codeusedir,codesusedns,sep = "/"))

#write_csv2(codes_cpt4,paste0(dirtemp,"/codes_cpt4",version,".csv"))
m<-codes_cpt4$codes=="9nst"
#codes_cpt4$regxmean[m]<-0
m<-codes_cpt4$codes=="#9nst"
#codes_cpt4$regxmean[m]<-0

ii<-order(-codes_cpt4$regxmean)
regxcodes<-regxmean(codes_cpt2)
regxcodes2<-regxmean3(codes_cpt2)
i2<-order(-regxcodes2$regxmean)
regxcodes3<-regxcodes2[i2,]
#regxcodes<-codes_cpt4[ii,]
###GPT essai
set<-codes_cpt2
gpt<-function(set,st){
  it<-st
  regxcodesranked<-regxmean2(set)
  ii<-order(regxcodesranked$regxmean)
  ms<-array()
  ms<-matrix(nrow = length(ii),ncol = 40)
  f<-21
  for (f in 1:length(filelist2)){
    tbu<-readtext(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
    #k<-319
    t1<-tbu$text
    proof<-function(its){
      regx1<-regxcodesranked$regexcor[its]
      regx1<-"9"
      m<-unlist(stri_extract_all_regex(t1,regx1))
      ms<-length(m)
    }
    for (k in 1:length(regxcodesranked$codes)){
      regx2<-regxcodesranked$regexcor[k]
#      regxout<-stri_extract_all(tbu$text,regex=regx1)
      m<-grep(regx2,t1)
      t1<-gsub(regx2,"DUMMY",t1)
      ms[k,f]<-proof(k)    
    }
    
  }
  return(ms)
  
 # return(sum(ms,na.rm = T))
}
filelist2[21]
#ms<-gpt(codes_cpt2,1)
#sum(ms[length(ms[,1]),])


#sum(ms[354,])
###13161.
#rpall<-as.data.frame(codes_cpt4$regex[ii])
rpall<-as.data.frame(codes_cpt4$regexcor[ii])
########
#rpall[,1]
rpall["subst"]<-codes_cpt4$subst[ii]
rpall["category"]<-codes_cpt4$category[ii]
rpall["repl"]<-codes_cpt4$repl[ii]
#rpall["shortcode"]<-paste0(codes_cpt4$pre1[ii],codes_cpt4$pre2[ii],codes_cpt4$pre3[ii])
rpall["shortcode"]<-paste0("#",codes_cpt4$pre2[ii],codes_cpt4$pre3[ii],"#")
rpall["headpre"]<-paste0("#",codes_cpt4$pre2[ii],codes_cpt4$pre3[ii],"# ",codes_cpt4$phrase[ii]," ",codes_cpt4$feature[ii]," n = : ")


###


#here insert getcode()

##################################
#from here substitute #coding#
### section D
### THIS complete replacement loop
filelist2
f<-1
###13052.get common transcript start:
transtart<-array()
for (f in 1:length(filelist2)){
  tbu<-readLines(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
  # p1<-grep(".ctivities",tbu)
  # tbu[p1[1]]
  # tbu<-insert(tbu,p1[1]+1,"@Elicitation files: box.FU folder:00_SES Documents (to revise) for BERLANGDEV")
  # p2<-grep("@.oding",tbu)
  # tbu[p2[1]]
  # tbu<-insert(tbu,p2[1]+1,"@TIER descriptions:")
  # p3<-grep("@.roofer:",tbu)
  # ifelse(!is.na(tbu[p3[1]]),tbu[p3[1]]<-"@Annotation checked:",
  #        tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
  # tbu[p1[1]+1]
  # #delete evtl. second obsolete @Begin tag
  p3<-grep("^\\*",tbu)[1]
  p3
  transtart[f]<-p3  
}
f<-6
# metatable<-read.csv("local/HU-LX/SES/ruthtable_kidsmeta.csv")
mns<-colnames(metatable)
headermeta<-c("Country of Birth","Years in Germany","Years of school heritage country","Language Proficiency Mother",
              "Language Proficiency Father","Language Use Mother","Language Use Father","Language Use Siblings","Language Use Friends")
#transtart<-max(transtart)
transfail<-list()
codens<-unique(rpall$shortcode)
codens<-codens[order(codens)]
codecount<-matrix(nrow=length(codens),ncol=length(filelist2))
codecount<-data.frame(codecount,row.names = codens)
for (f in 1:length(filelist2)){
  tbu<-readLines(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
  #kidname<-stri_extract(filelist2[k],regex="(?<=SES_..._)(.+?)(?<=(_))")
  kidname<-stri_split(filelist2[f],regex="_")
  kidname<-toupper(unlist(kidname)[3])
  #13083.header modification
  p1<-grep("@.anguage",tbu)
  head1<-array()
  k<-1
  for (k in 1:length(metatable)-1){
    head0<-metatable[metatable$participant==kidname,k+1]
    head1[k]<-paste0("@",headermeta[k],": ",head0)
  }
  head1
  tbu<-insert(tbu,p1[1]+1,head1)
  p1<-grep(".ctivities",tbu)
  tbu[p1[1]]
  tbu<-insert(tbu,p1[1]+1,"@Elicitation files: box.FU folder:00_SES Documents (to revise) for BERLANGDEV")
  p2<-grep("@.oding",tbu)
  tbu[p2[1]]
  tbu<-insert(tbu,p2[1]+1,"@TIER descriptions:")
  p3<-grep("@.roofer:",tbu)
  ifelse(!is.na(tbu[p3[1]]),tbu[p3[1]]<-"@Annotation checked:",
         tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
  tbu[p1[1]+1]
  #delete evtl. second obsolete @Begin tag
  p3<-grep("@.egin",tbu)
  p3
  if (length(p3)>=1){tbu[p3[2:3]]<-""}
  #           tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
  #get unique alphabetically sorted tier description
  rp3<-paste0("@",rpall$headpre)
  rpall["headex"]<-rp3
  #rp4
  is<-order(rp3)
  rp3<-rpall$subst[is]
  rp3
  #add @ to tier explanations
  rpcom<-rpall$category!=3
  rp5<-unique(rpall$headex[rpcom])
  is<-order(rp5)
  rp5<-rp5[is]
  rp5
  lcodesmax<-length(unique(rpall$`codes_cpt4$regex[ii]`))
  ######### comment in for complete transcript with tier codes #########
  ### > add codes decription in header: ################################
  if (scheme=="original"|scheme=="inlineCodes"){
    tbu<-append(tbu,rp5,after = p2[1]+1) #removed for codeless transcripts
  }
  if (scheme=="sansCodes"){
    tbu[p2[1]+1]<-"@TIER descriptions: removed for unannotated transcript"
    tbu[p2[1]+2]<-paste0(tbu[p2[1]+2]," feature coding/annotation removed")
  }
  scheme
  #scheme<-"original"
  ######################################################################
  tbu
  rptiers<-subset(rpall,rpall$category==1|rpall$category==2|rpall$category==3|rpall$category==4) #WATCH
  #rptiers$
  #####################################
  ### this section main replacement ###
  ##### wks.
  #find transcript start
  mstart<-grep("^\\*",tbu)[1]
  tbu<-insert(tbu,mstart,"@header end")
  tbub<-tbu[mstart:length(tbu)] #transcript section
  tbusafe<-tbu
  tbuheader<-tbu[1:mstart-1] #header section
  tbu<-tbub
  #xcodes<-unique(rpall)
  #xcodes<-unique(rpall$`codes_cpt4$regex[ii]`)
  #rpall<-xcodes
  #  for (k in 1:length(xcodes)) {
  
    for (k in 1:length(rpall[,1])) {
    flag<-1
    m<-grep(rpall[k,1],tbu)
    tier<-rpall$category[k]
    #########################################################################################################
    ### main: 13485 outcommented to remove codes. comment in / decomment commands to remove / restore codes #
    if (scheme=="original"){
      tbu<-gsub(rpall[k,1],rpall[k,"repl"],tbu) ### >> decomment 1. original CHAT replace ####################
      ifelse(m!=0&tier!=4,tbu<-insert(tbu,m+1,rpall$subst[k]),flag<-0) # >> decomment 3. add annotation tier #
    }
    if (scheme=="inlineCodes"){
      tbu<-gsub(rpall[k,1],rpall[k,"shortcode"],tbu) ### >> decomment 2. just #0AR# shortcode #################
    }
    ################################################## >>>>>>>>> for ouput just shortcodes INLINE codes #####
    ### try remove all codes instead of replacing formerly: #################################################
    if (scheme=="sansCodes"){
      tbu<-gsub(rpall[k,1],codesubstitute,tbu) ### >> comment in for trans without coding ##############
    }
    ### IMPORTANT: this adds the annotation tier after the code instance
    #if (scheme=="original")
    # ifelse(m!=0&tier!=4,tbu<-insert(tbu,m+1,rpall$subst[k]),flag<-0) # >> decomment 3. add annotation tier #
    
    ### 13485################################################################################################
    ###extra, essai: note number of instances/code in header
    mh<-grep(rpall$subst[k],tbuheader) #grep headercodedescription line
    tier<-rpall$category[k]
    #    tbu<-gsub(rpall[k,1],rpall[k,"repl"],tbu)
    #  ifelse(m!=0&tier!=4,tbuheader<-
    ### this adds number of occurences of code to header description of code, has to be formatted
    # ifelse (length(m)!=0,tbuheader<-gsub(rpall$headex[k],
    #                                      #                       paste0(rpall$headex[k]," n = : ",length(m)),tbuheader),flag<-0)
    #                                      paste0(rpall$headex[k],length(m)),tbuheader),flag<-0)
    # 
    #  tbuheader<- gsub(" #: 0","#todeletespace#",tbuheader)
    #  tbuheader<- gsub("#todeletespace#","",tbuheader)
    rphead<-grep("headex",colnames(rpall))
    rpall[k,rphead+f]<-length(m)
    codeact<-rpall$shortcode[k]
    codeit<-codecount[codeact,f]
    if(is.na(codeit)){codeit<-0}
    codeit<-length(m)+codeit
    codecount[codeact,f]<-codeit
    ### this adds number of occurences of code to header description of code, has to be formatted
  #  k<-1
    #for (k in 1:length(codecount[,1])){
    # m3<-grep(codeact,tbuheader)
    # f
    # tbuheader[m3]<-paste0(tbuheader[m3],codecount[codeact,f])
    # 
    #}
  
      #rpall$instance[k]<-c(f,length(m))
  } #replace coding with replacement + add extra tier with code below speakerline
  tbu
  for (k in 1:length(codecount[,1])){
    codeact<-rownames(codecount)[k]
  m3<-grep(codeact,tbuheader)
  f
  tbuheader[m3]<-paste0(tbuheader[m3],codecount[codeact,f])
  }
  #### end replacement loop
  #TODO: create table of code instances in transcript:
  #scheme<-"sansCodes"
  scheme
  tbu[]
  #####################################
  kids<-strsplit(filelist2,"\\.")
  kids[[1]][1]
  dirtext
  dir.create(paste(dirtext,dirchat,sep = "/"))
  
  #nameschemeing the files
  #write_clip(filelist2)
  regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
  repl1<-"\\1\\2"
  
  kids1<-gsub(regx1,repl1,filelist2)
  kids1
  regx2<-".+(ELL|TUR)_([A-Za-z]{3}).+"
  repl2<-"\\2"
  kids2<-gsub(regx2,repl2,kids1)
  kids2
  kids3<-toupper(kids2)
  #length(rpall)
  # colnames(rpall)<-c("regex","subst","category","repl","headex",kids3)
  # k<-1
  kids4<-array()
  for (k in 1:length(filelist2)){
    # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
    # repl1<-"\\1\\2"
    # filelist_ren<-gsub(regx1,repl1,filelist2[k])
    #  regx3<-"(?<=(ELL|TUR)_)([A-Za-z]{3})"
    regx3<-"(ELL|TUR)_([A-Za-z]{3})"
    
    # repl2<-"\\2"
    # filekids<-gsub(regx2,repl2,filelist_ren)
    kids4[k]<-gsub(regx3,kids3[k],kids1[k],perl = T)
  }
  kids4<-strsplit(kids4,"\\.")
  # codestable<-rpall[5:length(rpall)]
  #  sum(codestable[1,6:length(codestable)]) #check for instance in line
  # for (k in 1:length(codestable$headex) ){
  # if (sum(codestable[k,6:length(codestable)])!=0){
  #   codest2<-rbind (codestable[k,6:length(codestable)]
  # 
  #   write.csv(codestable,paste0(dirtext,"/r-temp/kidscodestable.csv"))
  # getwd()
  #filelist2<-kids4
  ################
  
  chatfilename<-paste0(kids4[[f]][1],transextension,chatfileextension)
  kidns<-kids4[[f]][1]
  chatfilename
  #delete hardcoded linenumbers
  me<-grepl("([^@].*)",tbuheader)
  tbuheader<-tbuheader[me]
  me<-grepl("([^@].*)",tbu)
  tbu<-tbu[me]
  lhead<-length(tbuheader)
  length(tbu)
  difhead<-100-lhead
  vakat<-rep("@vakat",difhead)
  # lt<-length(tbu)
  #gsub("(\\d{1,3})","x",1:15)
  #gsub("(\\d*)$","1\\1",1:15)
  
  
  #remove empty lines
  #me<-grepl("([^@].*)",tbu_cpt)
  #tbu_cpt<-tbu_cpt[me]
  #tbu<-tbu_cpt
  rn25<-"([0-9]{1,3}\\. )(?=\\*|@)"
  tbu<-gsub(rn25,"",tbu,perl = T)
  # if (numbered==T){
  #   num<-sprintf("%04s", as.character(1:lt))
  #   tbu<-paste(num,tbu,sep = "\t")}
  tbu_cpt<-c(tbuheader,tbu)
  
  #tbu_cpt<-c(tbuheader,vakat,tbu)
  #tstart<-length(c(tbuheader,vakat))+1
  #mstart<-grep("^\\*",tbu)[1]
  tbum<-tbu_cpt
  tail(tbum)
  codesarray$V1[61]
  #################################
  #post processing substitutes
  #this routine data TODO fetch from external array
  set<-codes_cpt
  (codes_cpt$regex[codes_cpt$category==4])
  #   postprocess<-function(set,tbum,mstart){
  depr<-function(){
    rnb01<-"STATIC(a|b|c|d|e|f)"
    rpb01<-"STATIC-\\1"
    rnb02<-"(but the some of the interviewer’s utterances)"
    rpb02<-"but the interviewer’s utterances"
    rnb03<-"(\\(mostly\\))"
    rpb03<-"roughly"
    rnb04<-"(\\(family_language-with_parents-with\\))"
    rpb04<-"(family_language-with_parents-with_siblings)"
    rnb05<-"\\., see the Elicitation documentation files\\."
    rpb05<-"; see reference @Elicitation files."
    rnb06<-"\\.\\.\\.@" #inline pauses
    #rpb06<-rpall[24,2] # global pause replacement, set up in getms()
    rnbcpt<-c(rnb01,rnb02,rnb03,rnb04,rnb05)
    rpbcpt<-c(rpb01,rpb02,rpb03,rpb04,rpb05)
    rpball<-cbind(rnbcpt,rpbcpt)
    for (l in 1:length(rpball[,"rnbcpt"])) {
      tbu_e<-gsub(rpball[l,"rnbcpt"],rpball[l,"rpbcpt"],tbu_cpt)
    }
  }#edn depr
  #only transcript 
  postcodes<-subset(set,set$category==5|set$category==5|set$category==6)
  transcodes<-subset(postcodes,postcodes$category==5|postcodes$category==5)
  postcodes<-transcodes
  #postcodes$regex<-stri_unescape_unicode(postcodes$regex)
  typeof(postcodes)
  #rm(codes)
  ii<-!is.na(postcodes$regex)
  postcodes<-subset(postcodes,ii)
  postcodes$regex
  regx<-stri_unescape_unicode(postcodes$regex)
  repl<-stri_unescape_unicode(postcodes$repl)
  repl
  regx
  #postcodescor$regexcor
  #postcodescor<-regxcor(postcodes,c(4,5,5,5,5))
  tbu_e<-tbum
  tbu<-tbu_e
  mstart<-grep("^\\*",tbu)[1]
  tbub<-tbu[mstart:length(tbu)]
  tbusafe<-tbu
  tbuheader<-tbu[1:mstart-1]
  tail(tbuheader)
  tbu_e<-tbub
  #transcript post
  regx<-stri_unescape_unicode(transcodes$regex)
  repl<-stri_unescape_unicode(transcodes$repl)
  regx
  repl
  for (l in 1:length(regx)) {
    tbu_e<-gsub(regx[l],repl[l],tbu_e)
  }
  tbub
  tbu_e[1:50]
  tbu_e
  tbum
  postcodes<-subset(set,set$category==5|set$category==5|set$category==6)
  headcodes<-subset(postcodes,postcodes$category==6)
  
  postcodes<-headcodes
  #postcodes$regex<-stri_unescape_unicode(postcodes$regex)
  typeof(postcodes)
  #rm(codes)
  ii<-!is.na(postcodes$regex)
  postcodes<-subset(postcodes,ii)
  postcodes$repl
  regx<-stri_unescape_unicode(postcodes$regex)
  repl<-stri_unescape_unicode(postcodes$repl)
  regx
  repl
  tbuheader
  for (l in 1:length(regx)) {
    tbuheader<-gsub(regx[l],repl[l],tbuheader)
  }
  #  regx<-stri_unescape_unicode(transcodes$regex)
  #  repl<-stri_unescape_unicode(transcodes$repl)
  # for (l in 1:length(regx)) {
  #  tbub<-gsub(regx[l],repl[l],tbub)
  #  }
  
  #tbu_e[1:50]
  
  #mstart<-grep("@header end")
  #tbu_cpt<-c(tbuheader,tbu_e)
  tbu_cpt<-c(tbuheader,tbu_e)
  #  mnew<-grep("@header end",tbu_cpt)[1]+1
  mnew<-grep("^\\*",tbu)[1]
  #####13141.
  transcpt<-mnew:length(tbu_cpt)
  transcpt<-tbu_e
  tail(tbu_cpt)
  
  mend<-grep("@(E|end)",transcpt)
  mend<-mend-1
  #mend<-length(tbu_cpt)
  transtxt<-tbu_e[1:mend]
  transtxt
  # transfail<-list()
  #####
  if (numbered==T){
    #sp1<-stri_split_fixed(tbu_cpt[transcpt],pattern = "(*|%...:)",simplify = T)
    sp2<-stri_split_regex(transtxt,pattern  = "[*%](0[A-Z]{2}:|[A-Z]{3}:)",simplify = T)
    dim(sp2)
    sp1<-stri_extract_all_regex(transtxt,pattern  = "[*%](0[A-Z]{2}:|[A-Z]{3}:)",simplify = T)
    
    dim(sp1)
    sp3<-stri_split_regex(transtxt,pattern  = "[*%]...:")
    #  transfail[[f]]<-sp3
    sp2
    spna<-!is.na(sp1[,1])
    spna
    spna2<-!is.na(sp2[,2])
    spna2
    lt1<-sum(spna==spna2)
    sp1<-sp1[spna,1]
    sp1<-gsub("\t","",sp1)
    sp2<-sp2[spna2,2]
    sp2<-gsub("\t","",sp2)
    
    tail(sp1)
    #    transfail[f]<-sp2[1]
    # transdb<-matrix(ncol = 80,nrow = 500)
    lt<-length(transtxt)
    lt<-length(sp1)
    lt<-lt1
    num<-sprintf("%04s", as.character(1:lt))
    tail(num)
    tail(transfail$SES_GDC_m_8$num)
    tail(transfail$SES_GDC_m_8$sp2)
    tail(transfail$SES_GDC_m_8$sp1)
    tail(transfail$SES_TAF_f_13$num)
    
    head(transfail$SES_GDC_m_8$sp2)
    unique(transfail$SES_GDC_m_8$sp1)
    dim(sp2)
    dim(transcpt)
    tbu_enumb<-paste(sp1,num,sp2,sep = "\t")
    tbu_js<-list(sp1=sp1,num=num,sp2=sp2)
    #  transdb<-transfail
    #    transdb<-as.data.frame(transdb,check.names =F)
    transfail[[kidns]]<-tbu_js
    transdb[[kidns]]<-tbu_enumb
    #transdb[,f+2]<-sp2
    tbu_cpt<-c(tbuheader,tbu_enumb)} #false end
  tbu_e<-tbu_cpt
  tail(tbu_e)
  head(tbu_e)
  
  tbu_e[52:60]
  #tbu_e[148]
  ### final write transformed transcript according to scheme:
  writeLines(tbu_e,paste(dirtext,dirchat,chatfilename,sep = "/"))
  ##########################################################
  #  }
  #  postprocess(codes_cpt,tbum)
  
}
getwd()
write_json(transfail,paste("local/HU-LX/SES","transdb001.json",sep = "/"))
write_json(transdb,paste(dirtext,"transcript_database_by_turns_001.json",sep = "/"))

write_json(transdb,paste(transdbdir,transdbns,sep = "/"))
#write_csv(transdb,paste(dirtext,"transdb001.csv",sep = "/"))
### END replacement loop #########

# tail(codes_cpt["repl"])
# #call replacement loop with last tbum(transcript) and set(codeset) as arguments
# ######
#nameschemeing the files
#write_clip(filelist2)
# regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
# repl1<-"\\1\\2"
# kids1<-gsub(regx1,repl1,filelist2)
# regx2<-".+(ELL|TUR)_([A-Za-z]{3}).+"
# repl2<-"\\2"
# kids2<-gsub(regx2,repl2,kids1)
# kids3<-toupper(kids2)
# k<-1
# kids4<-array()
# for (k in 1:length(filelist2)){
#   # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
#   # repl1<-"\\1\\2"
#   # filelist_ren<-gsub(regx1,repl1,filelist2[k])
#   regx3<-"(?<=(ELL|TUR)_)([A-Za-z]{3})"
#   # repl2<-"\\2"
#   # filekids<-gsub(regx2,repl2,filelist_ren)
#   kids4[k]<-gsub(regx3,kids3[k],kids1[k],perl = T)
# }
# kids4
# filelist2<-kids4
#complete filelist of all converted files:
dirchat
translist<-list.files(paste(dirtext,dirchat,sep="/"),pattern="(\\.txt)")
#write_clip(filelist)
#date()
#format(Sys.time(), "%a %b %e %H:%M:%S %Y")
datetime<-format(Sys.time(), "%Y%m%d(%H.%M)")
#translistname<-paste0("CHAT_transcripts_list_",datestamp,".txt")
#writeLines(translist,paste(dirtemp,translistname,sep = "/"))
##########
##### ----
#second run
#13475.
chatv1<-grepl("CHAT",filelist)
#filelist<-filelist[chatv1==F]
##############################
##############################
######################################################################
#from here skip with already CHAT transformed transcript to second run
#function not called!#########
postchatcoding<-function(){
  ##############################
  filelist3<-filelist[chatv1]
  
#f<-1  
  for (f in 1:length(filelist3)){
    tbu<-readLines(paste(dirtext,filelist3[f],sep = "/"))
    # p1<-grep(".ctivities",tbu)
    # tbu[p1[1]]
    # tbu<-insert(tbu,p1[1]+1,"@Elicitation files: box.FU folder:00_SES Documents (to revise) for BERLANGDEV")
    # p2<-grep("@.oding",tbu)
    # tbu[p2[1]]
    # tbu<-insert(tbu,p2[1]+1,"@TIER descriptions:")
    # p3<-grep("@.roofer:",tbu)
    # ifelse(!is.na(tbu[p3[1]]),tbu[p3[1]]<-"@Annotation checked:",
    #        tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
    # tbu[p1[1]+2]
    #delete evtl. second obsolete @Begin tag
    p3<-grep("@.egin",tbu)
    
    if (length(p3)>=1){tbu[p3[2:3]]<-""}
    #           tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
    #get unique alphabetically sorted tier description
    # rp3<-paste0("@",rpall$subst)
    # rpall["headex"]<-rp3
    # #rp4
    # is<-order(rp3)
    # rp3<-rpall$subst[is]
    # rp3
    # #add @ to tier explanations
    # rpcom<-rpall$category!=3
    # rp5<-unique(rpall$headex[rpcom])
    # is<-order(rp5)
    # rp5<-rp5[is]
    # rp5
    # tbu<-append(tbu,rp5,after = p2[1]+1)
    # #tbu
    rptiers<-subset(rpall,rpall$category==1|rpall$category==2|rpall$category==3)
    #####################################
    ### this section main replacement ###
    ##### wks.
    #find transcript start
    mstart<-grep("^\\*",tbu)[1]
    tbub<-tbu[mstart:length(tbu)] #transcript section
    tbusafe<-tbu
    tbuheader<-tbu[1:mstart-1] #header section
    tbu<-tbub
    for (k in 1:length(rpall[,1])) {
      flag<-1
      m<-grep(rpall[k,1],tbu)
      tier<-rpall$category[k]
      tbu<-gsub(rpall[k,1],rpall[k,"repl"],tbu)
      ifelse(m!=0&tier!=4,tbu<-insert(tbu,m+1,rpall$subst[k]),flag<-0)#if out 0 findings & category==4
    }
    tbuheader
    k<-79
    rpall$shortcode[k]
    ###extra, essai: note number of instances/code in header
    # regx1<-paste0(codes_cpt4$pre1[k],codes_cpt4$pre2[k],codes_cpt4$pre3[k]) #codesshortcode
    regx1<-rpall$shortcode[k]
    mh<-grep(regx1,tbuheader) #position of tierdescription
    tbuheader[mh]
    #tier<-rpall$category[k]
    m<-grep(regx1,tbu)
    #sum(m)
    tbu[m]
    ifelse (length(m)!=0,tbuheader[mh]<-paste0(rpall$headex[k]," n = ",length(m)),flag<-0)
    tbuheader
    #   mh<-grep(rpall$subst[k],tbuheader) #grep headercodedescription line
    # tier<-rpall$category[k]
    # ### this adds number of occurences of code to header description of code, has to be formatted
    # ifelse (length(m)!=0,tbuheader<-gsub(rpall$headex[k],
    # paste0(rpall$headex[k]," n = ",length(m)),tbuheader),flag<-0)
    #  tbuheader<- gsub(" #: 0","#todeletespace#",tbuheader)
    #  tbuheader<- gsub("#todeletespace#","",tbuheader)
    rpall[k,5+f]<-length(m) # writes instances into array
    #rpall$instance[k]<-c(f,length(m))
  } #replace coding with replacement + add extra tier with code below speakerline
  #TODO: create table of code instances in transcript:
  
  
  #tbu[105:130]
  #####################################
  kids<-strsplit(filelist3,"\\.")
  kids[[1]][1]
  dirtext
  dir.create(paste(dirtext,chatvmodified,sep = "/"))
  
  #nameschemeing the files
  #write_clip(filelist2)
  regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
  repl1<-"\\1\\2"
  
  kids1<-gsub(regx1,repl1,filelist3)
  kids1
  regx2<-".+(ELL|TUR)_([A-Za-z]{3}).+"
  repl2<-"\\2"
  kids2<-gsub(regx2,repl2,kids1)
  kids2
  kids3<-toupper(kids2)
  #length(rpall)
  # colnames(rpall)<-c("regex","subst","category","repl","headex",kids3)
  # k<-1
  kids4<-array()
  for (k in 1:length(filelist3)){
    # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
    # repl1<-"\\1\\2"
    # filelist_ren<-gsub(regx1,repl1,filelist2[k])
    #  regx3<-"(?<=(ELL|TUR)_)([A-Za-z]{3})"
    regx3<-"(ELL|TUR)_([A-Za-z]{3})"
    
    # repl2<-"\\2"
    # filekids<-gsub(regx2,repl2,filelist_ren)
    kids4[k]<-gsub(regx3,kids3[k],kids1[k],perl = T)
  }
  kids4<-strsplit(kids4,"\\.")
  # codestable<-rpall[5:length(rpall)]
  #  sum(codestable[1,6:length(codestable)]) #check for instance in line
  # for (k in 1:length(codestable$headex) ){
  # if (sum(codestable[k,6:length(codestable)])!=0){
  #   codest2<-rbind (codestable[k,6:length(codestable)]
  # 
  #   write.csv(codestable,paste0(dirtext,"/r-temp/kidscodestable.csv"))
  # getwd()
  #filelist2<-kids4
  ################
  
  chatfilename<-paste0(kids4[[f]][1],"_CHAT_2nd",chatfileextension)
  chatfilename
  #delete hardcoded linenumbers
  tbu_cpt<-c(tbuheader,tbu)
  tbu<-tbu_cpt
  # rn25<-"([0-9]{1,3}\\. )(?=\\*|@)"
  # tbum<-gsub(rn25,"",tbu,perl = T)
  # tail(tbum)
  # codesarray$V1[61]
  # #################################
  # #post processing substitutes
  # #this routine data TODO fetch from external array
  # set<-codes_cpt
  # (codes_cpt$regex[codes_cpt$category==4])
  # #   postprocess<-function(set,tbum,mstart){
  # depr<-function(){
  #   rnb01<-"STATIC(a|b|c|d|e|f)"
  #   rpb01<-"STATIC-\\1"
  #   rnb02<-"(but the some of the interviewer’s utterances)"
  #   rpb02<-"but the interviewer’s utterances"
  #   rnb03<-"(\\(mostly\\))"
  #   rpb03<-"roughly"
  #   rnb04<-"(\\(family_language-with_parents-with\\))"
  #   rpb04<-"(family_language-with_parents-with_siblings)"
  #   rnb05<-"\\., see the Elicitation documentation files\\."
  #   rpb05<-"; see reference @Elicitation files."
  #   rnb06<-"\\.\\.\\.@" #inline pauses
  #   #rpb06<-rpall[24,2] # global pause replacement, set up in getms()
  #   rnbcpt<-c(rnb01,rnb02,rnb03,rnb04,rnb05)
  #   rpbcpt<-c(rpb01,rpb02,rpb03,rpb04,rpb05)
  #   rpball<-cbind(rnbcpt,rpbcpt)
  #   for (l in 1:length(rpball[,"rnbcpt"])) {
  #     tbu_e<-gsub(rpball[l,"rnbcpt"],rpball[l,"rpbcpt"],tbu_cpt)
  #   }
  # }#edn depr
  # #only transcript 
  # postcodes<-subset(set,set$category==4|set$category==5|set$category==6)
  # transcodes<-subset(postcodes,postcodes$category==4|postcodes$category==5)
  # postcodes<-transcodes
  # #postcodes$regex<-stri_unescape_unicode(postcodes$regex)
  # typeof(postcodes)
  # #rm(codes)
  # ii<-!is.na(postcodes$regex)
  # postcodes<-subset(postcodes,ii)
  # postcodes$regex
  # regx<-stri_unescape_unicode(postcodes$regex)
  # repl<-stri_unescape_unicode(postcodes$repl)
  # repl
  # regx
  # #postcodescor$regexcor
  # #postcodescor<-regxcor(postcodes,c(4,5,5,5,5))
  # tbu_e<-tbum
  # tbu<-tbu_e
  # tbub<-tbu[mstart:length(tbu)]
  # tbusafe<-tbu
  # tbuheader<-tbu[1:mstart-1]
  # tbu_e<-tbub
  # #transcript post
  # for (l in 1:length(regx)) {
  #   tbu_e<-gsub(regx[l],repl[l],tbu_e)
  # }
  # tbu_e[1:50]
  # postcodes<-subset(set,set$category==4|set$category==5|set$category==6)
  # headcodes<-subset(postcodes,postcodes$category==6)
  # postcodes<-headcodes
  # #postcodes$regex<-stri_unescape_unicode(postcodes$regex)
  # typeof(postcodes)
  # #rm(codes)
  # ii<-!is.na(postcodes$regex)
  # postcodes<-subset(postcodes,ii)
  # postcodes$repl
  # regx<-stri_unescape_unicode(postcodes$regex)
  # repl<-stri_unescape_unicode(postcodes$repl)
  # repl
  # tbuheader
  # for (l in 1:length(regx)) {
  #   tbuheader<-gsub(regx[l],repl[l],tbuheader)
  # }
  # #tbu_e[1:50]
  # tbu_cpt<-c(tbuheader,tbu_e)
  # tbu_e<-tbu_cpt
  
  #tbu_e[52]
  #tbu_e[148]
  tbu_e<-tbu
  writeLines(tbu_e,paste(dirtext,chatvmodified,chatfilename,sep = "/"))
  #  }
  #  postprocess(codes_cpt,tbum)
  
}
#end postchatcoding temp function, not called
### END replacement loop #########

### function for sketchEngine output ############
#function not called!#########
sketchcoding<-function(){
  ##############################
  ### >>> run this on preprocessed last version transcript to modify for sketch #####
  chatlastoutdir<-paste(dirtext,dirchat,sep="/")
  chatlastoutdir
  filelist3<-list.files(chatlastoutdir)
  filelist3
  f<-4
  inlinecodewrap<-c("c_","") #wrap for inline codes
  sketchwrap<-c("<s>","</s>")
  textdf<-data.frame()
  for (f in 1:length(filelist3)){
    tbu<-readLines(paste(chatlastoutdir,filelist3[f],sep = "/"))
    p3<-grep("@.egin",tbu)
    #####################################
    ### this section main replacement ###
    ##### wks.
    #find transcript start
    mstart<-grep("\\*[A-Z]{3}",tbu)[1]
    #mstart<-grep("^\\*",tbu)[1]
    tbub<-tbu[mstart:length(tbu)] #transcript section
    tbusafe<-tbu
    tbuheader<-tbu[1:mstart-1] #header section
    #tbu<-tbub
    regx1<-"(\\*INT:)"
    mint<-grep(regx1,tbub) # *INT: lines
    mkid<-grep(regx1,tbub,invert = T) # *CHILD: lines    
    regx2<-"(.*)" # sentences
    sent<-grep(regx2,tbub)
    regx3<-"\\*([A-Z]{3}:)" #speakerlines
    repl3<-"#\\1"
    tbub<-gsub(regx3,repl3,tbub[sent])
    tbub[sent]
    #### 13146.
    # regx4<-"(?<=(#[A-Z]{3}:))(.*)(#([A-Z]{3})#)"
    # regx4<-"(?=(#([A-Z]{3}:)))(.*)(#([A-Z]{3})#)"
    # repl4<-paste0("\\3",inlinecodewrap[1],"\\5",inlinecodewrap[2])
    # #split text
    textdf<-as.data.frame(stri_split_regex(tbub,"\t[0-9]{4}\t",simplify = T))
    regx4<-"#([A-Z]{3}|0[A-Z]{2})#"
    m<-grep(regx4,textdf$V2)
    
    repl4<-paste0(inlinecodewrap[1],"\\1",inlinecodewrap[2])
    textdf$sub<-gsub(regx4,repl4,textdf[,2],perl = T)
    #regx4<-"c_(([A-Z]{3})|(0[A-Z]{2}))"
    regx4<-"(c_([A-Z]{3}|0[A-Z]{2}))([^ ].)"
    repl4<-"\\1 \\3"
    m<-grep(regx4,textdf$sub)
    textdf$sub[m]
    textdf$sub<-gsub(regx4,repl4,textdf$sub,perl = T)
    #textdf$cpt<-paste()
    lt<-length(textdf$V1)
    num<-sprintf("%04s", as.character(1:lt))
    textdf$cpt<-paste0(sketchwrap[1],textdf$V1,"\t",num,"\t",textdf$sub,sketchwrap[2]) # wrap with all sentences
    tbuwrap<-textdf$cpt
    #  tbub2<-gsub(regx4,repl4,tbub2[sent],perl = T)
    # tbuwrap<-tbub[sent]
    # if (sdelim==T)
    #    tbuwrap<-gsub(regx2,"<s>\\1</s>",tbub[sent]) # wrap with all sentences
    #   #tbuwrap<-gsub(regx2,"<s>\\1</s>",tbub[mkid]) # wrap only with child sentences
    #   tbuheader
    #   k<-79
    #####################################
    # kids<-strsplit(filelist3,"\\.")
    # kids[[1]][1]
    # dirtext
    # dir.create(paste(dirtext,chatvmodified,sep = "/"))
    # 
    # #nameschemeing the files
    # #write_clip(filelist2)
    # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
    # repl1<-"\\1\\2"
    # 
    # kids1<-gsub(regx1,repl1,filelist3)
    # kids1
    # regx2<-".+(ELL|TUR)_([A-Za-z]{3}).+"
    # repl2<-"\\2"
    # kids2<-gsub(regx2,repl2,kids1)
    # kids2
    # kids3<-toupper(kids2)
    # kids4<-array()
    # for (k in 1:length(filelist3)){
    #   regx3<-"(ELL|TUR)_([A-Za-z]{3})"
    #   kids4[k]<-gsub(regx3,kids3[k],kids1[k],perl = T)
    # }
    # kids4<-strsplit(kids4,"\\.")
    # ################
    ns<-sans_ext(filelist3[f])
    ext<-file_ext(filelist3[f])
    chatfilename<-paste0(ns,"_SkE.",ext)
    #version<-"2.8a"
    dir_2ndmod<-paste0("sketchmode")
    chat2ndoutdir<-paste(dirtext,dir_2ndmod,sketchversion,sep = "/")
    chat2ndoutdir
    dir.create(chat2ndoutdir)
    #  chat2ndoutdir<-boxfolderns
    dir.create(paste(chat2ndoutdir,boxfolderns,sep = "/"))
    
    #dir.create(paste(chat2ndoutdir,sketchversion,sep = "/"))
    #tbu_cpt<-c(tbuheader,tbu)
    #tbu<-tbu_cpt
    tbu_out<-tbuwrap
    writeLines(tbu_out,paste(chat2ndoutdir,boxfolderns,chatfilename,sep = "/"))
  }
  ### END replacement loop #########
  ### outputs transcript version: without header, with inline codes, lines <s>wrapped</s>
}
#end postchatcoding temp function, not called
#call ske version:
if(ske==T) #declared in head of script
  sketchcoding()

######################################
### header construct new, header database
getwd()
chat2ndoutdir<-paste(dirtext,dir_2ndmod,sketchversion,sep = "/")
translist<-list.files(paste(dirtext,dirchat,sep="/"),pattern="(\\.txt)")
trans_dfl<-list()

headercoding<-function(){
  ##############################
  chatlastoutdir<-paste(dirtext,dirchat,sep="/")
  chatlastoutdir
  filelist3<-list.files(chatlastoutdir)
  filelist3
  f<-1
  f<-16
  f
  #tbu
  hdb<-read.csv("local/HU-LX/SES/db_header.csv")
  for (f in 1:length(filelist3)){
    tbu<-readLines(paste(chatlastoutdir,filelist3[f],sep = "/"))
    p3<-grep("@.egin",tbu)
    #####################################
    #find transcript start
    mstart<-grep("\\*[A-Z]{3}",tbu)[1]
    #mstart<-grep("^\\*",tbu)[1]
    tbub<-tbu[mstart:length(tbu)] #transcript section
    kidsdf<-stri_split_regex(filelist3,"_",simplify = T)
    kid<-kidsdf[f,2]
    #hdb[,kid]<-h2$d1
    # k<-1
    # for (k in rownames(h2)){
    #   hdb[k,kid]<-h2[k,"d1"]
    # }
    # trans_dfl[[kid]]<-tbub
    
    tbusafe<-tbu
    tbuheader<-tbu[1:mstart-1] #header section
    headerlines<-tbuheader[2:length(tbuheader)]
    headeritems<-stri_split_regex(headerlines,":",simplify = T)
    headeritems<-unique(headeritems)
    m<-grep("Duration",headeritems)
    headeritems[m]<-"@Duration"
    m<-grep("Cassette",headeritems)
    headeritems[m]<-"@Cassette Location"
    m<-grep("Comment",headeritems)
    headeritems[m]<-"@Comments"
    m<-grep(".enamed audio",headeritems)
    headeritems[m]<-"@cut and renamed audio file"
    m<-grep("digitized audio",headeritems)
    headeritems[m]<-"@digitized audio file"
    m<-grep("War.?ning",headeritems)
    headeritems[m]<-"@Warning"
    # m<-grep("Duration",headeritems)
    # headeritems[m]<-"@Duration"
    header_df<-data.frame(headeritems,row.names = headeritems[,1])
    #header_df<-data.frame(headeritems,row.names = hdb$X[1:76])
    h1<-header_df
    h1$content<-paste(h1$X2,h1$X3,h1$X4)
    h1["@Comment","content"]
    regx1<-"\t"
    repl1<-" "
    h1$content<-gsub(regx1,repl1,h1$content)
    regx1<-"   "
    repl1<-" "
    h1$content<-gsub(regx1,repl1,h1$content)
    h1<-data.frame(d1=h1$content,row.names = rownames(h1))
    h2<-h1
    #h3<-list(h1)
    #    rns<-h2$d1[!is.na(h2$d1)]
    #rownames(hdb)<-hdb[,1]
    library(purrr)
    
    h2["@Duration",]<-h2["@Duration",]%>%stri_extract_all_regex("[0-9]{1,2}")%>%unlist()%>%paste(collapse=":")
    #if (h2["Duration",])
    #h2["@Duration",]<-h2["@Duration",]%>%stri_extract_all_regex("[0-9]{1,2}")%>%unlist()%>%paste(collapse=":")
    #kid<-"GDB"
    # kidsdf<-stri_split_regex(filelist3,"_",simplify = T)
    # kid<-kidsdf[f,2]
    # #hdb[,kid]<-h2$d1
    # k<-1
    for (k in rownames(h2)){
      hdb[k,kid]<-h2[k,"d1"]
    }
    #  trans_dfl[[kid]]<-tbub
    
  }
  m<-grep("@Participants",rownames(hdb))
  
  m2<-grep("@Coding",rownames(hdb))
  m3<-grep("@TIER",rownames(hdb))
  m4<-grep("@#PAU",rownames(hdb))
  m5<-m4+1
  #  m6<-grep()
  hdb2<-rbind(hdb[m:m2,],hdb[m5:length(hdb[,1]),],hdb[m3:m4,])
  #critical:
#  hdb2<-hdb2[,3:length(hdb2)]
  #hdb2<-data.frame(hdb2[,3],row.names = rownames(hdb2))
  #colnames(hdb2)<-kid
  #m11<-grep("@")
  m1<-grep("@Participants",rownames(hdb2))
  m2<-grep("@Duration",rownames(hdb2))
  m3<-grep("@cut",rownames(hdb2))
  m4<-grep("@header end",rownames(hdb2))
  m5<-m2+1
  m6<-grep("@TIER",rownames(hdb2))
  m7<-grep("@Comments",rownames(hdb2))
  hdb3<-rbind(hdb2[m1:m2,],hdb2[m3,],hdb2[m5:m7,],hdb2[m6:length(hdb2[,1]),],hdb2[m4,])
  # for (k in 1:length(hdb2)){
  # if (is.na(hdb2[m1[2],k]))
  #   hdb2[m1[2],k]<-hdb2[m1[1],k]
  # }
  #hdb2<-hdb[m:length(hdb$X),3:length(hdb)]
  # write.csv(hdb3,"local/HU-LX/SES/db_headertable.csv")
  ########
  
  
  return(hdb3)
  
}

#TAC issue:
dbtac<-headercoding() #output db seems okay with metadata for kids

cleandb<-function(set){
  h2<-as.data.frame(h2)
  
  m<-grep("#|Age|Year",colnames(h2))
  colnames(h2)[m]
  m
  for (k in 1:length(m)){
    mode(h2[,m[k]])<-"double"
  }
  k
  #h3<-t(h1)
  h2$`@Year`<-1978
  h2$`@Language of Interview`<-"german"
  h2$`@Elicitation files`<-"HU-BOX/!WS2022-23_SES/SES_documentation"
  h2$`@Participants`<-paste0(rownames(h2),"_target child, INT_interviewer")
  idkid<-stri_split_regex(h2$`@ID`,"_",simplify = T)
  idkid[,2]<-rownames(h2)
  idage<-stri_extract_all_regex(idkid[,3],"[0-9]{2}",simplify = T)
  idgnd<-stri_extract_all_regex(idkid[,3],"[A-Za-z]{1}",simplify = T)
  idkid[,3]<-idgnd
  m<-!is.na(idage)
  m
  idkid[m,4]<-idage[m]
  idkid2<-paste(idkid[,1],idkid[,2],idkid[,3],idkid[,4],sep  = "_")
  h2$`@ID`<-idkid2
  h2$`@Family Language(s)`<-gsub("ELL","greek",h2$`@Family Language(s)`)
  h2$`@Family Language(s)`<-gsub("TUR","turkish",h2$`@Family Language(s)`)
  h2$`@Family Language(s)`<-gsub("DEU","german",h2$`@Family Language(s)`)
  h2$`@Family Language(s)`<-gsub("ARB","arabic",h2$`@Family Language(s)`)
  h2$`@Family Language(s)`<-tolower(h2$`@Family Language(s)`)
  h2["TAH",4]<-"female"
  sc<-c(2,4,5,7,8,13,14,15,16,18) #rm space in columns
  for (k in 1:length(h2$`@ID`)){
    h2[k,sc]<-gsub(" ","",h2[k,s])
  }
  
  for (k in 1:length(h2)){
    r1<-"^ "
    m<-grep(r1,h2[,k])
    repl<-""
    h2[m,k]<-gsub(r1,repl,h2[m,k])
  }
  
  return(h2)
}
#############################
# headertable<-headercoding()
# h1<-headertable
# h2<-t(h1)
#h3<-cleandb(h2)
#h5<-rbind(AAglobal=colnames(h3),h3[,0:length(h3)])
#write.csv(h5,"local/HU-LX/SES/db_headertable_002t3x.csv")
# writexl::write_xlsx(h5,"local/HU-LX/SES/db_headertable_20230321(18.55).xlsx")
#############################
#h6 <- read_delim("local/HU-LX/SES/db_headertable_002t2x_m.csv",skip = 1)
# h6 <- read_csv("local/HU-LX/SES/db_headertable_002t2x_m.csv",skip = 1)
#writexl::write_xlsx(h6,"local/HU-LX/SES/20230321(18.55)_SES_headertable.xlsx")

#write_clip(s)
#write.csv(h3,"local/HU-LX/SES/db_headertable_002.csv",row.names = rownames(h3),col.names = colnames(h3))
#typeof(h2[,9])
#sum(h2$`@#0AR# zero article n = `)
### transpose rows/columns

#combine header of df and transcript
k<-1
f<-1
f<-16
#set<-h6
transcombine<-function(set){
  h4<-set
  #mode(h4$`@Duration`)<-"character"
  chatlastoutdir<-paste(dirtext,dirchat,sep="/")
  chatlastoutdir
  filelist3<-list.files(chatlastoutdir)
  filelist3
  for (f in 1:length(filelist3)){
    tbu<-readLines(paste(chatlastoutdir,filelist3[f],sep = "/"))
    #p3<-grep("@.egin",tbu)
    #p3
    #####################################
    #find transcript start
    mstart<-grep("\\*[A-Z]{3}",tbu)[1]
    #mstart<-grep("^\\*",tbu)[1]
    tbub<-tbu[mstart:length(tbu)] #transcript section
    #kidsdf<-stri_split_regex(filelist3,"_",simplify = T)
    kid<-filelist3[f]
    
    #  tbu_h2<-paste(rownames(headertable),headertable[,k],sep  = ":")
    #r<-f+1
    r<-f
    h4[r,21]
    m<-grep("@TIER.*?",colnames(set))
    m<-m-1
    headerentries<-colnames(set)
    headerentries<-headerentries[2:m]
    tbu_h2<-paste0(headerentries,": ",h4[r,2:m])
    #tbu_h2<-tbu_h2[2:length(tbu_h2)]
    tbu_t<-tbub
    m2<-grep("@#.*?",tbu)
    m3<-grep("@TIER.*?",tbu)
    m3<-c(m3,m2)
    ifelse (numbered==F,
            tbu_cpt<-c("@begin",tbu_h2,tbu[m3],"@header end",tbu[mstart:length(tbu)]),
            tbu_cpt<-c("@begin",tbu_h2,tbu[m3],"@header end",h7[[f]],"@end")
    )
    tbu_cpt
    #tbu_cpt<-c(tbu_h2,tbu_t)
    #writeLines(tbu_cpt,paste(chatlastoutdir,kid,sep = "/"))
    #dir.create("local/HU-LX/SES/temp/tr")
  #  version<-"v3_1"
    chatoutparent<-"local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text/docx-txt/"
    chatoutdir<-paste0(chatoutparent,"SES_transcripts_w_header_",version,"_",datestamp)
    dir.create(chatoutdir)
    writeLines(tbu_cpt,paste(chatoutdir,kid,sep = "/"))  
  }
}
#tbu_h2
#chatlastoutdir

#################
h6 <- read_csv("local/HU-LX/SES/db_headertable_002t2x_m.csv",  col_types = cols(`@Duration` = col_character()), 
               skip = 1)
h7<-transdb
#h7$SES_GCA_f_8
#htest<-c(h6["GCA",],"@header end",h7$SES_GCA_f_8,"@end")
#unlist(htest)
#mode(h6$`@Duration`)
transcombine(h6)
#################


getwd()
#source("local/R/askchatgpt.R")
notrun<-function(){
  f
  k<-2
  #rownames(h2)==rownames(hdb)
  hdb[k,"d1"]
  #tbu<-tbub
  tbub
  turns<-stri_split_regex(tbub,":",simplify = T)
  turns<-data.frame(turns)
  ### chatgpt request:
  turn<-turns$X2[10]
  turn<-gsub("\t","",turn)
  
  #prompt<-paste0('find all missing articles in the following sentence and tag them like #0AR <article>#: ',turn)
  prompt
  #q<- paste0('{"model": "text-davinci-003", "prompt": "',prompt,'", "temperature": 0, "max_tokens": 600}')
  #q
  #k<-1
  #k
  tna<-!is.na(turns$X2)
  sum(tna)
  t2<-turns$X1
  m<-grepl("INT",t2)
  m<-(m+1-2)*-1
  m<-m==1 #inverted INT lines
  #m2<-grep("%",turns$X1,invert = T)
  mna<-!is.na(turns$X2)
  sum(mna)
  m2<-mna*m
  sum(m2)
  m2<-m2==1
  tn1<-turns$X2[m]
  mna<-!is.na(tn1)
  tna<-tn1[m2]
  for (k in 1:length(t2)){
    #c<-stri_extract_all_boundaries()
    if (m2[k]!=F){
      turn<-turns$X2[k]
      turn<-gsub("\t","",turn)
      c<-unlist(stri_extract_all_words(turn))
      if (length(c)>=5)
        print(turn)
      #      prompt<-paste0('find all missing articles in the following sentence and tag them like #0AR <article>#: ',turn)
      #      prompt<-paste0('finde fehlende definite Artikel in der Phrase [',turn,'] und zeichne sie mit #0AR <Artikel># aus: ')
      prompt<-paste0('find missing definite articles in the phrase [',turn,'] and tag them #0AR <article>#')
      prompt<-paste0('define any eventually missing definite articles in the phrase [',turn,'] and tag the corresponding noun <0AR>')
      #
      #prompt
      q<- paste0('{"model": "text-davinci-003", "prompt": "',prompt,'", "temperature": 0, "max_tokens": 600}')
      answer<-3
      #q
      #      answer<-askgpt(q)
      turns[k,"tag"]<-answer
      #    }
    }
  }
  turns$tag
}
##########
### fetch codes in original transcript
fcodes<-function(){
  filelist
  ### corpus
  library(quanteda)
  dirtext
  tcfiles<-paste(dirtext,filelist,sep = "/")
  dta <- readtext(tcfiles)
  #dta
  # Create a corpus object
  dta_cor <- corpus(dta)
  #tc<-corpus(paste(dirtext,filelist,sep = "/"))
  summary(dta_cor)
  tc_tokens <- tokens(dta_cor)
  
  # 4.1 Keywords in Context (KWIC)
  # https://tutorials.quanteda.io/basic-operations/tokens/kwic/
  # head() prints the first six results returned by the kwic() function
  cc9<-kwic(tc_tokens, pattern="9", window = 3, case_insensitive = TRUE,valuetype = "regex")
  cc90<-kwic(tc_tokens, pattern="90", window = 3, case_insensitive = TRUE,valuetype = "regex")
  ccnst<-kwic(tc_tokens, pattern="nst", window = 3, case_insensitive = TRUE,valuetype = "regex")
  ccr<-kwic(tc_tokens, pattern="#.*#", window = 3, case_insensitive = TRUE,valuetype = "regex")
  ex<-kwic(tc_tokens, pattern="9nst agmnt", window = 3, case_insensitive = TRUE)
  ex
  #intersections:
  c1<-cc9$from%in%cc90$from
  sum(c1)
  ccpt<-rbind(cc9,cc90,ccnst,ccr)
  m<-!duplicated(ccpt$from)
  sum(m)
  ccpt<-ccpt[m,]
  u1<-unique(paste(ccpt$keyword,ccpt$post,sep = "%"))
  write.csv(u1,"fcodes_cpt.csv")
  d<-read.csv("local/HU-LX/SES/fcodes_cpt_m.csv")
  d1<-unique(d$x)
  regx1<-"%$"
  m<-grep(regx1,d1)
  d1[m]
  d1<-gsub(regx1,"",d1)
  regx1<-"%"
  m<-grep(regx1,d1)
  d1[m]
  d1<-gsub(regx1," ",d1)
  m<-!is.na(d1)
  sum(m)
  d1<-d1[2:length(d1)]
  d2<-read.csv(codesource)
  m<-!duplicated(d2$codes)
  sum(m)
  length(unique(d2$codes))
  d21<-d2[m,]
  #d21
  m<-d1%in%d21$codes
  sum(!m)
  #sum(d1[!m,])
  codes<-d1[m==F]
  codes
  library(dplyr)
  d22<-bind_rows(d21,tibble(codes))
  d22$codes[6]==d22$codes[7]
  d23<-d22[!duplicated(d22$codes),]
  #codes
  write.csv(d24,"local/HU-LX/SES/fcodes_cpt_unique_d24.csv")
  d24<-read.csv("local/HU-LX/SES/fcodes_cpt_unique_d24.csv")
  d24$pre3
  d24$phrase #228
  m<-d24$pre2!="C"&!is.na(d24$pre2)&!is.na(d24$feature)
  m[190]
  sum(m)
  #m<-d24$pre2[!is.na]
  p1<-unique(d24$pre3[m])
  #m<-!is.na(d24$feature)
  p11<-unique(d24$feature[m])
  p12<-unique(d24$phrase[m])
  p12<-c("zero","nonstandard")
  p13<-unique(d24$pre2[m])
  
  p1
  p11
  p12
  d24$phrase[d24$pre2=="0"]<-"zero"
  d24$phrase[d24$pre2=="N"]<-"nonstandard"
  d24$phrase[d24$pre2=="C"]<-"cmnt"
  m<-d24$pre2=="P"
  d24$pre2[m]<-"PAU"
  d24$pre3[m]<-""
  d24$repl[m]<-" ((...)) "
  d24$feature[d24$pre3=="CJ"]<-"conjunction"
  
  k<-4
  for (k in 1:length(p1)){
    m<-d24$pre3==p1[k]
    m2<-m!=T|is.na(m)
    m2<-m2==F
    m2
    d24$feature[m2]<-p11[k]
  }
  
  sum(m)
  d24$feature[190]
  p3<-unique(d24$pre2)
  p2<-unique(d24$phrase)
  
  u<-unique(d22$codes)
  l1<-length(codes_cpt$codes)+1
  l2<-l1+length(ccr$keyword)
  l3<-length(codes_cpt)
  nsc1<-colnames(codes_cpt)
  #cd2<-
  cda<-rbind(codes_cpt["codes"],ccr$keyword,l1)
  library(dplyr)
  codes<-unique(ccr$keyword)
  #cd3<-bind_rows(codes_cpt,tibble(codes))
  #u1<-unique(cd3$codes)
  #cda1<-unique(codes_cpt$codes)
  u2<-codes%in%codes_cpt$codes
  u2
  m<-(u2+1-2)*-1
  m<-m==1 #inverted INT lines
  m
  u2<-codes[m]
  codes<-u2
  cd3<-bind_rows(codes_cpt,tibble(codes))
  ###wks.
  #######
  codes<-unique(paste0(cc90$pre,cc90$keyword,cc90$post))
  cd3<-bind_rows(cd3,tibble(codes))
  codes<-paste0(ccnst$pre,ccnst$keyword,ccnst$post)
  cd3<-bind_rows(cd3,tibble(codes))
  write.csv(cd3,"gith/HU-LX/data/codes_cptmissing.csv")
}
ftagging<-function(){
  ##############13143.
  library(koRpus)
  install.koRpus.lang("de")
  library(koRpus.lang.de)
  
  getwd()
  dirtext
  tagdir<-"local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text/docx-txt/sketchmode/v3.1/version without header for SketchEngine upload"
  cha<-list.files(tagdir)
  cha<-cha[grep("cha",cha)]
  tagdf<-list()
  kids4<-array()
  for (k in 1:length(cha)){
    # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
    # repl1<-"\\1\\2"
    # filelist_ren<-gsub(regx1,repl1,filelist2[k])
    #  regx3<-"(?<=(ELL|TUR)_)([A-Za-z]{3})"
    regx3<-"SES_([A-Za-z]{3}).*"
    repl2<-"\\1"
    # filekids<-gsub(regx2,repl2,filelist_ren)
    kids4[k]<-gsub(regx3,repl2,cha[k],perl = T)
  }
  kids4<-unique(kids4)
  #k<-1
  for (k in 1:length(cha)){
    x<-treetag(paste(tagdir,cha[k],sep = "/"),treetagger = "manual",lang="de",
               TT.options = list(path=file.path("~/pro/treetagger"),preset="de"),format = "file")
    
    # xf<-tempfile(fileext = ".txt")
    # treetag(paste(dirout,cha[1],sep = "/"),treetagger = "manual",lang="de",
    #         TT.options = list(path=file.path("~/pro/treetagger"),preset="de"),format = "file")
    y<-taggedText(x)
    summary(x)
    #  plot(x)
    codesdir
    codeusedir
    tagoutdir<-"local/HU-LX/pepper/treeout2"
    dir.create(tagoutdir)
    y2<-y[,2:4]
    colnames(y2)<-c("tok","tag","lemma")
    y2$lemma<-gsub("<unknown>","N.A.",y2$lemma)
    
    #  y2$lem<-gsub("<unknown>","N.A.",y2$lem)
    tagfilens<-paste0(kids4[k],".xlsx")
    
    writexl::write_xlsx(y2,paste(tagoutdir,tagfilens,sep="/"))
    #  write_delim(y2,paste(codeusedir,"GCAtokens.tt",sep = "/"),delim = "\t",)
  }
}


