#13363.wrapup table create
#20230904(18.24)
################
library(readr)
library(readxl)
source("/users/guhl/documents/github/r-essais/scripts/getmd.r")
src<-"/users/guhl/boxhkw/21s/dh/local/hu-lx/alii/20230621_SES_data_exchange – Kopie.xlsx"

txhead<-"## class findings"

d1<-read_xlsx(src,sheet = "Laura")
d2<-data.frame(d1)
length(d2[,1])
m<-c(1,2,3,5,6,7,8,9)
d1<-d2[m]
#d1$Noticing<-gsub("(\\*|\\\r\\\n)","/",d1$Noticing)
#d1$Interviewer<-gsub("(\\*|\\\r\\\n)","/",d1$Interviewer)
#d1$Self.correction..content.or.form.<-gsub("(\\*|\\\r\\\n)","/",d1$Self.correction..content.or.form.)
md.1<-getmd(d1,txhead)
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
m<-c(1,2,3,5,6,7,8,9)
d1<-d2[m]
#d1.sub<-as.data.frame(gsub("(\\*|\r|\n)","/",d1))
d1$Noticing<-gsub("(\\*|\\\r\\\n)","/",d1$Noticing)
d1$Interviewer<-gsub("(\\*|\\\r\\\n)","/",d1$Interviewer)
d1$Self.correction..content.or.form.<-gsub("(\\*|\\\r\\\n)","/",d1$Self.correction..content.or.form.)
#d1$Noticing
#d1$Interviewer
#d1
md.1<-getmd(d1,txhead)
writeLines(md.1,"findings02.md")
###
d1<-read_xlsx(src,sheet = "Miriam")
d2<-data.frame(d1)
length(d2[,1])
m<-c(1,2,3,5,6,7,8,9)
d1<-d2[m]
d1$Hesitation.phenomena..Pauses..repeated.articles
d1$Self.correction..content.or.form.
d1$Hesitation.phenomena..Pauses..repeated.articles<-gsub("(\\*|\\\r\\\n)","/",d1$Hesitation.phenomena..Pauses..repeated.articles)
d1$Prepositions<-gsub("(\\*|\\\r\\\n)","/",d1$Prepositions)
d1$Self.correction..content.or.form.<-gsub("(\\*|\\\r\\\n|‘)","/",d1$Self.correction..content.or.form.)
d1$Articles<-gsub("(\\*|\\\r\\\n|‘|')","/",d1$Articles)
d1$Conjunctions<-gsub("(\\*|\\\r\\\n|‘|')","/",d1$Conjunctions)

md.1<-getmd(d1,txhead)
writeLines(md.1,"findings03.md")
