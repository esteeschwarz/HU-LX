f<-list.files()
s<-strsplit(f,"_")
s1<-lapply(s,function(x){
  n<-paste0(x[2:length(x)],collapse = "_")
})
s1
file.rename(f,unlist(s1))
