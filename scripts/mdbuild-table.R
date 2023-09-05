#13363.wrapup table create
#20230904(18.24)
################
library(readr)
library(readxl)
source("/users/guhl/documents/github/r-essais/scripts/getmd.r")
src<-"/users/guhl/boxhkw/21s/dh/local/hu-lx/alii/20230621_SES_data_exchange – Kopie.xlsx"

d1<-read_xlsx(src,sheet = "Laura")
d2<-data.frame(d1)
length(d2[,1])
d1<-d2
md.1<-getmd(d1)
writeLines(md.1,"findings01.md")
getwd()
# d1<-read_xlsx(src,sheet = "Philipp")
# d2<-data.frame(d1)
# length(d2[,1])
# d1<-d2
# 
# md.1<-getmd(d1)
# writeLines(md.1,"findings02.md")
d1<-read_xlsx(src,sheet = "Katharina")
d2<-data.frame(d1)
length(d2[,1])
d1<-d2
d1.sub<-as.data.frame(gsub("(\\*|\r|\n)","/",d1))
md.1<-getmd(d1)
writeLines(md.1,"findings03.md")
d1<-read_xlsx(src,sheet = "Miriam")
d2<-data.frame(d1)
length(d2[,1])
d1<-d2
md.1<-getmd(d1)
writeLines(md.1,"findings04.md")
