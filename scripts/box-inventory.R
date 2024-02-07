library(readr)
library(writexl)
inv<-read.csv("LLDM_inventory.txt",sep = "/",header = T)
inv<-read.csv("/Users/guhl/boxHKW/21S/DH/local/HU-LX/alii/inventoryWS2023earlier.csv",sep = "/",header = F)
inv<-inv[2:length(inv$V1),]
write_xlsx(inv,"/Users/guhl/boxHKW/21S/DH/local/HU-LX/alii/box_inventory_WS2023-24-earlier.xlsx")
inv<-read.csv("/Volumes/EXT/boxHKW/21S/DH/local/HU-LX/alii/inventoryWS2023earlier.txt",sep = "/",header = F)

#inv.txt<-readLines("boxHU/inventory.txt")

# m<-grep("\\.exb",inv[,1:5])
# inv[m,]
# inv.m<-matrix(inv)
# inv.u<-unlist(inv.m)
# inv.m<-matrix(inv.u,nrow = length(inv$X1))
# ###
# m<-grep("[a-zA-Z0-9]\\.exb",inv.m)
# inv.m[m]
# inv.m[414]
# exb1<-inv.m[m]
# colnames(inv.m)<-c(1:5)
# gr.dir<-function(x)grep(x,inv)
# exb2<-lapply(exb1, gr.dir)
# exb2
# exb1[2]
# exb1
# exb1[45]
# exb2[2]
m<-grep("RKO",inv$X2)
rko1<-inv[m,2:5]
#write.csv(rko1,"inventory_rko.csv")
m<-grep("OSZ",inv$X2)
osz1<-inv[m,2:5]
#write.csv(osz1,"inventory_osz.csv")
m<-grep("SESB",inv$X2)
sesb1<-inv[m,2:5]
#write.csv(sesb1,"inventory_sesb.csv")
# library(writexl)
# write_xlsx(rko1,"20230120(14.31)_box-inventory_RKO.xlsx")
# write_xlsx(osz1,"20230120(14.31)_box-inventory_OSZ.xlsx")
# write_xlsx(sesb1,"20230120(14.31)_box-inventory_SESB.xlsx")
###
#rko.m<-matrix(rko1)
rko.sf<-rko1
rko1<-osz1
rko1<-sesb1


m3<-grep("[a-zA-Z0-9]\\.",rko1$X4)
m4<-grep("(^RKO[A-Z]{3})",rko1$X4)
m.ela<-rko1$X4[m3]
m.ela
#rko1$X4[m3]
#ms<-grep("OSZ",rko1$X2)
library(stringi)
rko.p<-stri_extract_all_regex(rko1$X4[m3],"[A-Z]{3}",simplify = T)
rko.p.u<-unique(matrix(rko.p))
rko.p.u
rko.p.u<-rko.p.u[rko.p.u!=""]
p.ns<-rko.p.u[rko.p.u!="RKO"]
p.ns<-p.ns[p.ns!="OSZ"]
p.ns<-p.ns[p.ns!="SES"]
p.ns<-p.ns[p.ns!="STS"]
p.ns<-p.ns[p.ns!="EXT"]

p.ns
p.ns<-p.ns[!is.na(p.ns)]
p.ns
get.files<-function(x)grep(x,rko1$X4)
rko.f<-lapply(p.ns, get.files)
rko.f
p.list<-list()
k<-3
t<-c("dreimal","schwar.ze","katz.e")
grep("\\.",t)
for(k in 1:length(rko.f)){
ns<-p.ns[k]
item<-rko1$X4[rko.f[[k]]]
item
m<-grep("\\.",item)
p.list[[ns]]<-item[m]
  
}
#p.df<-data.frame(p.list)
#p.l<-function(x)
p.l<-lapply(p.list, length)
p.m<-max(unlist(p.l))
p.l
rko.f
#p.ns<-p.ns[!is.na(p.ns)]
p.dm<-matrix("n.a.",ncol = p.m+1)
p.df<-data.frame(p.dm)
colnames(p.df)[1]<-'participant'
p.df$participant<-NA
k<-3
for(k in 1:length(rko.f)){
  ns<-p.ns[k]
  p.df[k,]<-rep('n.a.',length(p.df))
  p.df$participant[k]<-ns
  items<-p.list[[ns]]
  
  l.i<-length(items)+1
  if(l.i>1)
    p.df[k,2:l.i]<-items
  
}

m<-p.df$participant=="ELA"
sum(m)
le<-sum(p.df[m,]!="n.a.")
le<-le+1
p.df[m,le:(le-1+length(m.ela))]<-m.ela
#p.df.rko<-p.df
p.df.sesb<-p.df
#save(p.df.sesb,file = "work/p.df_all-part-files_sesb.RData")
library(writexl)
#write_xlsx(p.df.sesb,"work/20240120(17.27)_SESB_files-of-participants.xlsx")
load("work/p.df_all-part-files_osz.RData")
load("work/p.df_all-part-files_sesb.RData")
p.df.osz.m<-p.df.osz[p.df.osz$participant!="EXT"&p.df.osz$participant!="IBU",]
#save(p.df.osz.m,file = "work/p.df_all-part-files_osz.RData")
p.df.osz<-p.df.osz.m
#write_xlsx(p.df.osz,"work/20240120(17.27)_OSZ_files-of-participants.xlsx")
load("work/p.df_all-part-files_rko.RData")
#write_xlsx(p.df.rko,"work/20240120(17.27)_RKO_files-of-participants.xlsx")

#write_xlsx(p.df.sesb,"work/20240120(17.27)_SESB_files-of-participants.xlsx")

### combine df:
#p.df.com<-rbind(p.df.osz,p.df.rko,p.df.sesb)
#p.df.l<-lapply(list, function)
p.df.rko<-p.df.sesb
lb<-function(x)rbind(p.df.rko[,x])
ls<-c(2:length(p.df.rko))
p.df.com.rko<-lapply(ls,lb)
p.unl<-unlist(p.df.com.rko)


rko.df<-data.frame(participant=rep(p.df.rko$participant,length(p.unl)/length(p.df.rko$participant)),file=p.unl)
osz.df<-data.frame(participant=rep(p.df.rko$participant,length(p.unl)/length(p.df.rko$participant)),file=p.unl)
sesb.df<-data.frame(participant=rep(p.df.rko$participant,length(p.unl)/length(p.df.rko$participant)),file=p.unl)

particip.df.cpt<-rbind(rko.df,sesb.df,osz.df)
save(particip.df.cpt,file="work/particip.df.cpt_all-p-onecolumn.RData")
load("work/particip.df.cpt_all-p-onecolumn.RData")
#m<-particip.df.cpt$file!="n.a."
#particip.df.cpt<-particip.df.cpt[m,]
c.ns<-c("type","lang","format")
p.df.c<-particip.df.cpt
#c.ns<-data.frame(c.ns)
p.df.c<-cbind(p.df.c,type=NA,lang=NA,format=NA)
lang.array<-c("EN","DE")
type.array<-c("ON","OE","WN","WE")
format.array<-c("exb","pdf","mp3","docx","cha")
###
p.df.c<-particip.df.cpt
g.type<-function(x)sum(grepl("WN",x))
p.df.c$WN<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("WE",x))
p.df.c$WE<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("OE",x))
p.df.c$OE<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("ON",x))
p.df.c$ON<-as.character(lapply(p.df.c$file,g.type))
###
g.type<-function(x)sum(grepl("DE",x))
p.df.c$DE<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("EN",x))
p.df.c$EN<-as.character(lapply(p.df.c$file,g.type))
###
g.type<-function(x)sum(grepl("\\.exb",x))
p.df.c$exb<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("\\.pdf",x))
p.df.c$pdf<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("\\.mp3|MP3",x))
p.df.c$mp3<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("\\.docx",x))
p.df.c$docx<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("\\.cha",x))
p.df.c$cha<-as.character(lapply(p.df.c$file,g.type))
g.type<-function(x)sum(grepl("$\\..*",x))
p.df.c$alii<-as.character(lapply(p.df.c$file,g.type))
###
library(purrr)
p.df.c$total<-0
p.dfsum<-function(x)sum(as.double(x[3:15]))
for(k in 1:length(p.df.c$participant)){
  p.df.c$total[k]<-sum(as.double(p.df.c[k,3:length(p.df.c)]))
}
p.df.c$total<-lapply(p.df.c,p.dfsum)
save(p.df.c,file="particip.df.cpt_all-p-onecolumn.RData")
library(writexl)
write_xlsx(p.df.c,"20240121(10.07)_table_check-files.xlsx")
library(readr)
write_csv(p.df.c,"20240121(10.07)_table_check-files.csv")
typeof(p.df.c[2,3])
mode(p.df.1[2,3])<-"character"
rm(p.df.c)
load("particip.df.cpt_all-p-onecolumn.RData")
p.df.sf<-p.df.c
p.df.1<-as.data.frame(p.df.c)
k<-1
p.df.n1<-p.df.c
for(k in 1:length(p.df.c$participant)){
  part<-p.df.c$participant[k]
  file<-p.df.c$file[k]
  values<-unlist(p.df.c[k,])
  p.df.n1[k,]<-as.character(values)

  }
typeof(values)
values



##################
## WS2023 and earlier

#inv<-inv[2:length(inv$V1),]
library(writexl)
write_xlsx(inv, "/Volumes/EXT/boxHKW/21S/DH/local/HU-LX/alii/20240131(17.19)_box-inventory_WS2023andearlier.xlsx")
