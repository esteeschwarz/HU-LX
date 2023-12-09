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
