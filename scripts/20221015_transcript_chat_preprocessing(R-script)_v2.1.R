#13407.hu-lx reformatting
#20221007(20.35)
#20221015(18.12) please download the most recent version of the script always
#here: https://github.com/esteeschwarz/DH_essais/blob/main/sections/HU-LX/20221015_transcript_chat_preprocessing(R-script).R
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
# 1. global variables
#mini
#setwd("~/boxHKW/21S/DH/")
#lapsi, ewa
setwd("~/boxHKW/UNI/21S/DH/")
dirtext<-paste0(getwd(),"/local/HU-LX/000_SES_REFORMATTED_transcripts/Formatted with header info/text")
codesource<-"/r-temp/codes_cpt3mod.csv"
list.files(dirtext)
#dirmod<-paste0(dirtext,"modified/")
dirmod<-dirtext #after manual regex modifying in VSCode
version<-"13441.3"
version<-"v2_3"
dirchat<-paste0("CHAT",version)
#dirchat<-paste0("CHAT_temp",version)

chatfileextension<-".txt"
#for export in .cha format to import into exmaralda
#dirchat<-paste0(dirchat,"_cha_",version)
#chatfileextension<-".cha"

dirtext
dirmod
dirout<-paste(dirtext,"out2",sep = "/")
dirout  
dir.create(dirout)
dirtemp<-paste(dirtext,"r-temp",sep="/")
dirtemp
#obsolete, array created from fix .csv table (create code substitution array with search/replace patterns
###wks.
#######
#external codes .csv table
codes_cpt <- read_delim(paste0(dirtext,codesource), 
                        delim = ";", escape_double = T)

# 2.
#get source files in top directory
filelist<-list.files(dirtext,pattern="(\\.txt)")
filelist
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
#cc<-readtext(zzfil)
 # cc1<-readtext(precodesfun(codes_cpt,f))
  #cc<-precodesfun(codes_cpt,f)
  cc1<-cc$text
  #cc1<-readChar(cc,nchars=nchar(cc))
  #zzfil<-tempfile("kidschar")
  cc1
 #   zz<-file(zzfil,"rb")
#readChar(zz,nc)
  #    cc1<-readChar(zz,nchar(tburec)+8)
#find obsolete whitespace range 2 to 200 blanks
regx1<-"[ ]{2,200}"
repl1<-" "
cc1<-gsub(regx1,repl1,cc1)
#find all line breaks
regx1<-"\n"
repl1<-"§%#nl#§%"
cc2<-gsub(regx1,repl1,cc1)
cc2
write_clip(cc2)

regx1<-"(§%#nl#§%)([A-Za-z#%\\.,;'-\\(\\)])" #newline starting with character or special character
repl1<-" \\2"
cc3<-gsub(regx1,repl1,cc2,perl = T)
write_clip(cc3)


#only for linenumbered transcripts
#delete linenumbering & hard breaks within IP
#regex groups: 1:newline 2:linenumbering 3:phrase
regx1<-"(?<=(§%#nl#§%))([0-9]{0,3}). " 
repl1<-""
cc3<-gsub(regx1,repl1,cc3,perl = T)
write_clip(cc3)
#solve: " '
regx1<-'"'
repl<-"'"
cc3<-gsub(regx1,repl1,cc3,perl = T)
write_clip(cc3)

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
writeLines(cc5,paste(dirout,corfilename,sep = "/"))
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
trans_mod_tempdir<-tempdir("trans_temp")
for (k in 1:length(filelist1)){
linecor(k,filelist1)
 trans_mod_array[k]<-linecor(k,filelist1)
}
#k<-8
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
filelist2[k]
#wks.
#here insert 4 & 5
#change codes from table to valid regex formula
# #external codes .csv table
# codes_cpt <- read_delim(paste0(dirtext,codesource), 
#                         delim = ";", escape_double = T)
#tail(codes_cpt$regex)
regxcor<-function(codeset,subset){
  #subset codes
  codes_cpt<-subset(codeset,codeset$category==subset[1]|codeset$category==subset[2]|codeset$category==subset[3]|codeset$category==subset[4]|codeset$category==subset[5])
  codelength<-length(codes_cpt$codes)
 # k<-60
  codes_cpt$feature[55:67]
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
    
    codes_cpt[k,"regexcor"]<-regxd
    codes_cpt[k,"version"]<-version
  }
  return(codes_cpt)
}
### correct codes with escaped characters
codes_cpt2<-regxcor(codes_cpt,c(1,2,3,3,3))


regxmean<-function(set){
  #get regex gefräszigkeit, sort array by
  #loop
  #k<-15
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
      
    }
    #regxmatrix[,nfiles+1]<-lapply(regxmatrix,mean)
    codes_cpt$regxmean<-regxmatrix[,nfiles+1]
  }
  return(codes_cpt)
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


#codesarray<-getcodes(codes_cpt2,regexcor)
codesarray<-getcodescpt(codes_cpt2,regexcor)
#157 cpt
#codesarray[50,1]
#
ar<-unique(codesarray$V2)
codes_cpt2["ar"]<-match(codes_cpt2$subst,ar)

#for (k in 1:length(codes_cpt$regexcor)){
# m<-codes_cpt$ar
codes_cpt2["regex"]<-codesarray$V1
codes_cpt4<-regxmean(codes_cpt2)
#save codes table
write_csv2(codes_cpt4,paste0(dirtemp,"/codes_cpt4",version,".csv"))
ii<-order(-codes_cpt4$regxmean)
codes_cpt4$regexcor[ii]
rpall<-as.data.frame(codes_cpt4$regex[ii])
#rpall[,1]
rpall["subst"]<-codes_cpt4$subst[ii]
rpall["category"]<-codes_cpt4$category[ii]
rpall["repl"]<-codes_cpt4$repl[ii]

###


#here insert getcode()
tempfun0<-function(zer){
  ###wks.
  # general find #codes#
  # writes global # and 9 codes in the transcripts to table
  tempfun<-function(){ # wird nicht ausgeführt
    regx1<-"#.+?#"
    tbx<-trans_mod_array[[16]]
    m<-gregexec(regx1,tbx)
    #reg
    regmatches(tbx,m)
    f<-17
    #codelist<-data.frame()
    #for (f in 1:length(filelist2)){
    tbu<-readLines(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
    regx1<-"#.+?#"
    m<-gregexec(regx1,tbu)
    p<-regmatches(tbu,m)
    p2<-unique(unlist(p))
    p3<-as.data.frame(p2)
    p1<-rbind(p1,p3)
    
    p4<-p1
    colnames(p1)<-"codes"
    #codelist[]<-p1
    #write.table(p1,paste0(dirtemp,"#codes.csv"),append = T)
    #grep(regx1,tbu,value = T)
    #(p[1:32][1])
    
    
    filelist2
    tbu
    p1
    codelist[1]<-p1
    getwd()
    dirtemp<-"~/boxHKW/21S/DH/gith/DH_essais/sections/HU-LX/temp/"
    p1<-unique(unlist(p))
    length(unique(p1[,1]))
    p5<-as.data.frame(unique(p1[,1]))
    colnames(p5)<-"codes"
    write.csv2(p5,paste0(dirtemp,"#codes.csv"))
    p6<-as.data.frame(unique(p5[,1]))
    colnames(p6)<-"codes"
    write.csv2(p6,paste0(dirtemp,"#codes_unique.csv"))
    
    as.data.frame(p)
    unlist(p)
  }
  
  # import code .csv to create substitution array
  getwd()
  #read.csv2(paste0(dirtext,"/r-temp/codes_cpt.csv")
  codes_cpt <- read_delim(paste0(dirtext,codesource), 
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)
  #rncpt2<-codes_cpt$codes         
  #rpcpt2<-paste0(codes_cpt$pre1,codes_cpt$pre2,codes_cpt$pre3)          
  #rp3<-subset(codes_cpt$codes,codes_cpt$pre3=="AG")          
  #rpformAG<-glue_collapse(rp3,sep = ")|(")          
  #rpformAG<-paste0('"(',rpformA,')"')
  #rpformAG
  #codes_cpt<-codes_cpt2
  pre3<-unique(codes_cpt$pre3)
  chna<-!is.na(pre3)
  chna
  pre3<-pre3[chna]
  pre2<-unique(codes_cpt$pre2)
  chna<-!is.na(pre2)
  chna
  pre2<-pre2[chna]
  prephrase<-unique(codes_cpt$phrase)
  chna<-!is.na(prephrase)
  chna
  prephrase<-prephrase[chna]
  postphrase<-unique(codes_cpt$feature)
  chna<-!is.na(postphrase)
  chna
  postphrase<-postphrase[chna]
  ### w/o com fields
  rpform<-data.frame()
  #subwocom<-subset(codes_cpt,set$category!=3)
  #set<-subwocom
  #set<-codes_cpt
  ###
  # #codesarray<-getcodes(subwocom)
  # codesarray<-getcodes(codes_cpt2,regexcor)
  # codesarray[24,1]
  ###well.
  ### run after 4 codesarray
  feat_array<-data.frame()
  #set<-subwocom
  set<-codes_cpt2
  length(set[[1]])
  for (k in 1:length(set[[1]])){
    feat_array[k,1]<-paste0(set$pre1[k],set$pre2[k],
                            set$pre3[k],": ",set$phrase[k]," ",set$feature[k])
    
  }
  #subwocom["subst"]<-feat_array[,1]
  codes_cpt["subst"]<-feat_array[,1]
  getwd()
  #write regex to codescpt
  # for (k in 1:length(codes_cpt$ar)){
  #   m<-codes_cpt$ar
  #   codes_cpt2["regex"]<-codesarray$V1[m]
  #   codes_cpt2["regexcor"]<-codesarray$V1[m]
  #   
  # }
  ar<-unique(codesarray$V2)
  codes_cpt2["ar"]<-match(codes_cpt2$subst,ar)
  
  #for (k in 1:length(codes_cpt$regexcor)){
   # m<-codes_cpt$ar
    codes_cpt2["regex"]<-codesarray$V1
#    codes_cpt2["regexcor"]<-codesarray$V1[m]
    
 # }
  #codes_cpt2["ar"]<-match(codes_cpt$subst,codesarray$V2)
  
  write.csv2(codesarray,paste0(dirtext,"/r-temp/codesarray_m03.csv"))
  write.csv2(codes_cpt2,paste0(dirtext,"/r-temp/codes_cpt3.csv"))
  
} #end temp function

##################################
#from here substitute #coding#
### THIS complete replacement loop
#f<-8
for (f in 1:length(filelist2)){
  tbu<-readLines(paste(trans_mod_tempdir,filelist2[f],sep = "/"))
  p1<-grep(".ctivities",tbu)
  tbu[p1[1]]
  tbu<-insert(tbu,p1[1]+1,"@Elicitation files: box.FU folder:00_SES Documents (to revise) for BERLANGDEV")
  p2<-grep("@.oding",tbu)
  tbu[p2[1]]
    tbu<-insert(tbu,p2[1]+1,"@TIER descriptions:")
    p3<-grep("@.roofer:",tbu)
    ifelse(!is.na(tbu[p3[1]]),tbu[p3[1]]<-"@Annotation checked:",
           tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
    tbu[p1[1]+2]
    #delete evtl. second obsolete @Begin tag
    p3<-grep("@.egin",tbu)
    
    if (length(p3)>=1){tbu[p3[2:3]]<-""}
#           tbu<-insert(tbu,p2[1]+1,"@Annotation checked:"))
      #get unique alphabetically sorted tier description
    rp3<-paste0("@",rpall$subst)
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
    tbu<-append(tbu,rp5,after = p2[1]+1)
    #tbu
    #####################################
    ### this section main replacement ###
    ##### wks.
    #find transcript start
    mstart<-grep("^\\*",tbu)[1]
    tbub<-tbu[mstart:length(tbu)]
    tbusafe<-tbu
    tbuheader<-tbu[1:mstart-1]
    tbu<-tbub
    for (k in 1:length(rpall[,1])) {
            m<-grep(rpall[k,1],tbu)
            tbu<-gsub(rpall[k,1],rpall[k,"repl"],tbu)
            ifelse(m!=0,tbu<-insert(tbu,m+1,rpall$subst[k]),m<-"no")
    }
    #tbu[105:130]
  #####################################
    kids<-strsplit(filelist2,"\\.")
  #kids[[f]][1]
  dirtext
  dir.create(paste(dirtext,dirchat,sep = "/"))

  #nameschemeing the files
  #write_clip(filelist2)
  regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
  repl1<-"\\1\\2"
  kids1<-gsub(regx1,repl1,filelist2)
  regx2<-".+(ELL|TUR)_([A-Za-z]{3}).+"
  repl2<-"\\2"
  kids2<-gsub(regx2,repl2,kids1)
  kids3<-toupper(kids2)
  # k<-1
  kids4<-array()
  for (k in 1:length(filelist2)){
    # regx1<-"(.+_[0-9]{1,2}).+(\\.txt)"
    # repl1<-"\\1\\2"
    # filelist_ren<-gsub(regx1,repl1,filelist2[k])
    regx3<-"(?<=(ELL|TUR)_)([A-Za-z]{3})"
    # repl2<-"\\2"
    # filekids<-gsub(regx2,repl2,filelist_ren)
    kids4[k]<-gsub(regx3,kids3[k],kids1[k],perl = T)
  }
    kids4<-strsplit(kids4,"\\.")

  #filelist2<-kids4
  ################
  
    chatfilename<-paste0(kids4[[f]][1],"_CHAT",chatfileextension)
  chatfilename
  #delete hardcoded linenumbers
  tbu_cpt<-c(tbuheader,tbu)
  tbu<-tbu_cpt
  rn25<-"([0-9]{1,3}\\. )(?=\\*|@)"
  tbum<-gsub(rn25,"",tbu,perl = T)
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
  postcodes<-subset(set,set$category==4|set$category==5|set$category==6)
  transcodes<-subset(postcodes,postcodes$category==4|postcodes$category==5)
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
  tbub<-tbu[mstart:length(tbu)]
  tbusafe<-tbu
  tbuheader<-tbu[1:mstart-1]
  tbu_e<-tbub
  #transcript post
  for (l in 1:length(regx)) {
    tbu_e<-gsub(regx[l],repl[l],tbu_e)
  }
  tbu_e[1:50]
  postcodes<-subset(set,set$category==4|set$category==5|set$category==6)
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
  repl
  tbuheader
    for (l in 1:length(regx)) {
    tbuheader<-gsub(regx[l],repl[l],tbuheader)
  }
  #tbu_e[1:50]
    tbu_cpt<-c(tbuheader,tbu_e)
  tbu_e<-tbu_cpt
  
  #tbu_e[52]
  #tbu_e[148]
  writeLines(tbu_e,paste(dirtext,dirchat,chatfilename,sep = "/"))
  #  }
  #  postprocess(codes_cpt,tbum)
    
    }
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
datestamp<-format(Sys.time(), "%Y%m%d(%H.%M)")
translistname<-paste0("CHAT_transcripts_list_",datestamp,".txt")
writeLines(translist,paste(dirtemp,translistname,sep = "/"))
