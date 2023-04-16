getwd()
d1<-read_csv("local/HU-LX/SES/DB_explique.csv")
x<-grep("c_",colnames(d1))
x1<-d1[1,x]
#| c_NSM | nonstandard semantics | 
#|:--|:---|
c0<-"|column|explanation|example|"
c1<-paste0("|",colnames(d1)[x],"|",x1,"|")
c2<-paste0("|:--|:---|")
c2<-c(c0,"\n",c2,"\n",c1)

c0<-"|column|explanation|example|"
c2<-paste0("|",colnames(d1),"|",d1[1,],"|",d1[2,],"|")
c1<-paste0("|:--|:---|:---|")
c3<-c(c0,"\n",c1,"\n",c2)
c3
write_clip(c3)

