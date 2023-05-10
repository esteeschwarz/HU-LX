# 13195.HU-LX .docx process sample
# 20230510(19.33)
# .docx file extract marked up (highlighted) code passages in transcripts
#################
getwd()
wd<-"~/boxHKW/UNI/21S/DH/local/HU-LX/S23"
src<-"GCE_document.xml"
library(xml2)
d1<-read_xml(src)
all_r<-xml_find_all(d1,".//w:r/*/*")
t1<-xml_text(all_r)
t1
p1<-xml_path(all_r)
xml_text(all_r[274])
all_p<-xml_find_all(d1,".//w:p")
xml_text(all_p[m[1]])
m<-grep("highlight",all_r)
m2<-stri_extract_all_regex(p1,"w:p\\[[0-9]{1,3}\\].*(highlight)",simplify = T)
m2
p1
#m<-grep("highlight",m2)
m3<-stri_split_fixed(m2,"/w:rPr/w",simplify = T)
m3
m4<-as.array(m3[!is.na(m3[,1])])
m5<-paste0(".//",m4)
xml_text(xml_find_all(d1,m5[5]))
m6<-as.array(m2[!is.na(m2[,1])])
m6<-paste0(".//",m6)
xml_attr(xml_find_all(d1,m6[2]),attr = "val")
xml_text(xml_find_all(d1,m6[4]))
xml_find_all(d1,m6[2])
#wks.
#####
xmlattrs



