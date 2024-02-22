#20231206(16.15)
#HU-LX batch file rename
########################
f<-list.files()
library(stringi)
ns<-stri_split_regex(f,"-")
ns[[1]][1]
ns.m
repl<-function(x)paste0(ns[[1]][1],"-",ns[[1]][2],"_",ns[[1]][4],"_",toupper(ns[[1]][5]),"_",toupper(ns[[1]][6]),collapse = "")
repl<-function(x)paste0(x[[1]][1],"-",x[[1]][2],"_",x[[1]][4],"_",toupper(x[[1]][5]),"_",toupper(x[[1]][6]),collapse = "")
lapply(ns,repl(ns) )
ns.m<-array()
for (k in 1:length(ns)){
ns.m[k]<-paste0(ns[[k]][1],"-",ns[[k]][2],"_",ns[[k]][4],"_",toupper(ns[[k]][5]),"_",toupper(ns[[k]][6]),".exb",collapse = "")

}
ns.m
ns.2<-stri_split_regex(f[16:39],"_")
ns.2[[1]]
stri_split_regex(ns.2[[1]][5],"m")[[1]][1]
ns.2.m<-array()
for (k in 1:length(ns.2)){
  ns.2.m[k]<-paste0(ns.2[[k]][4],"-",stri_split_regex(ns.2[[k]][5],"m")[[1]][1],"_",ns.2[[k]][1],"_",toupper(ns.2[[k]][2]),"_",toupper(ns.2[[k]][3]),".exb",collapse = "")
  
}
ns.2.m

ns
ns.new<-array()
ns.new[1:15]<-ns.m
ns.new[16:39]<-ns.2.m
ns.new
for(k in f){
  file.rename(f[k],ns.new[k])
}
file.rename(f,ns.new)
f
ns.new
length(f)
length(ns.new)

### LLDM rename boxfiles
f<-list.files()
f
library(tools)
f.ext<-file_ext(f)
e1<-c("exb","cha","txt")
m<-f.ext%in%e1
f.rn<-f[m]
f.rn
load("~/boxHU/work/particip.df.cpt_all-p-onecolumn.RData")
####
#14085.rename LLDM
library(stringi)
library(tools)

kids<-unique(p.df.c$participant)
projects<-c("SESB","OSZ","RKO")
years<-c("10","12")
types<-c("ON","OE","WN","WE","on","oe","we","wn")
langs<-c("DE","EN","de","en")
filetemp<-data.frame(file=p.df.c$file,renamed=NA,project=NA,year=NA,participant=NA,lang=NA,type=NA,info=NA,ext=NA,out=NA)
k<-102
k<-108
for(k in 1:length(filetemp$file)){
  file=filetemp$file[k]
  ext<-file_ext(file)
p<-7
  kids
  for (p in 1:length(kids)){
  kid<-kids[p]
  m1<-stri_extract_all_regex(file,kid,simplify = T)
  if (!is.na(m1))
    {filetemp$participant[k]<-m1
  #filetemp$out[k]<-m1
  #filetemp$info[k]<-gsub(m1,"",filetemp$file[k])
  out<-stri_split_regex(file,m1,simplify = T)
  out<-paste0(out,collapse  = "#")
  #out<-stri_split_regex(file,m1,simplify = T)
  filetemp$info[k]<-out
  
    }
  }
  out
  m1
#  y<-1
  file
  for (y in 1:length(years)){
    year<-years[y]
    yregx<-paste0("([OSZRKEB_-]",year,"[-_.m ])")
    yregx
    m1<-stri_extract_all_regex(file,yregx,simplify = T)
    if (sum(!is.na(m1))>0)
      {filetemp$year[k]<-unique(m1)  
    filetemp$out[k]<-paste(filetemp$out[k],m1,sep  = "|")
    out<-stri_split_regex(file,m1,simplify = T)
    filetemp$info[k]<-paste(filetemp$info[k],out,sep = "#")
    }}
  m1
  
#  for (l in 1:length(langs)){
    #lang<-langs[l]
    lregx<-paste0("([-_ ](",langs[1],"|",langs[2],"|",langs[3],"|",langs[4],")[ -_.])")
    m1<-stri_extract_all_regex(file,lregx,simplify = T)
    if (sum(!is.na(m1))==1)
    {  filetemp$lang[k]<-m1  
    filetemp$out[k]<-paste(filetemp$out[k],m1,sep  = "|")
    out<-stri_split_regex(file,m1,simplify = T)
    out
    filetemp$info[k]<-paste(filetemp$info[k],out,sep = "#")
    
    }
    #}

  t<-3
  types
  file
  for (t in 1:length(types)){
    type<-types[t]
    tregx<-paste0("([-_]",type,"[-_.])")
    m1<-stri_extract_all_regex(file,tregx,simplify = T)
    m1
    if (!is.na(m1))
      {filetemp$type[k]<-m1
    filetemp$out[k]<-paste(filetemp$out[k],m1,sep  = "|")
    out<-stri_split_regex(file,m1,simplify = T)
    filetemp$info[k]<-paste(filetemp$info[k],out,sep = "#")
    
       }
  }
  for (pr in 1:length(projects)){
    project<-projects[pr]
    prregx<-paste0("([-_]",project,"[-_])")
    prregx<-project
    m1<-stri_extract_all_regex(file,prregx,simplify = T)
    if (!is.na(m1))
     { filetemp$project[k]<-m1 
    filetemp$out[k]<-paste(filetemp$out[k],m1,sep  = "|")
    out<-stri_split_regex(file,m1,simplify = T)
    filetemp$info[k]<-paste(filetemp$info[k],out,sep = "#")
    }
  }
  #k<-102
  mna<-!is.na(filetemp[k,3:7])
  relev<-filetemp[k,3:7][mna]
  alii<-paste0(relev,collapse = "|")
  aregx<-paste0("(",alii,"|\\.",ext,")")
  rmall<-gsub(aregx,"",filetemp$file[k])
  rmall
  filetemp$info[k]<-rmall
  filetemp$ext[k]<-ext
  #filetemp$out[k]<-paste(filetemp$out[k],filetemp$ext,sep = "|")
#  filetemp$info[k]<-gsub(filetemp$out[k],"",filetemp$file[k])
  ### TODO: OLIVER-OSC > not VER
  ### info DEOE etc. rm
  #inforegx<-paste()
  relev
  filetemp$file[k]
  aregx
  #filetemp$info
  filetemp$year<-gsub("[^0-2]","",filetemp$year)
  filetemp$lang<-gsub("[^DENden]","",filetemp$lang)
  filetemp$type<-toupper(filetemp$type)
  filetemp$type<-gsub("[^WENOweon]","",filetemp$type)
  infoout<-paste(filetemp$lang[k],filetemp$type[k],filetemp$ext[k],sep = "|")
  filetemp$info[k]<-gsub(infoout,"",filetemp$info[k])
  filetemp$lang<-toupper(filetemp$lang)
  filetemp$type<-toupper(filetemp$type)
  mna<-is.na(filetemp[k,])
  filetemp[k,mna]<-""
  # filetemp$renamed<-paste0(filetemp$project,"-",filetemp$year,"_",
  #                          filetemp$participant,"_",filetemp$lang,"_",filetemp$type,"_",
  #                          filetemp$info,".",filetemp$ext)
  # k<-1
  # filetemp$renamed[k]
  # filetemp$renamed[k]<-gsub("[_]{1,3}(\\.)","\\1",filetemp$renamed[k])
}
filetemp$renamed<-paste0(filetemp$project,"-",filetemp$year,"_",
                         filetemp$participant,"_",filetemp$lang,"_",filetemp$type,"_",
                         filetemp$info,".",filetemp$ext)
#k<-1
filetemp$renamed[k]
filetemp$renamed<-gsub("[_]{1,3}(\\.)","\\1",filetemp$renamed)
#filetemp$year<-gsub("[^0-2]","",filetemp$year)
#filetemp$lang<-toupper(filetemp$lang)
#filetemp$lang<-gsub("[^DEN]","",filetemp$lang)
#filetemp$type<-toupper(filetemp$type)
#filetemp$type<-gsub("[^WEOEWNON]","",filetemp$type)
#filetemp$type<-toupper(filetemp$type)
#mout<-
#filetemp$info<-gsub("(OE|WE|WN|ON|")
filetemp$renamed<-paste0(filetemp$project,"-",filetemp$year,"_",
                         filetemp$participant,"_",filetemp$lang,"_",filetemp$type,"_",
                         filetemp$info,".",filetemp$ext)
is.na(m1)
length(m1)
kids
paste("de","en",sep  = "|")
