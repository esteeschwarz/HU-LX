#13372.ses wrapup print
#20230910(10.21)
################
#transform mdb src template to print version
############################################
getwd()
library(readtext)
library(xfun)
library(readr)
srcdir<-"~/Documents/GitHub/school/pr/2023-04-15/ses_wrapup/src"
f<-list.files(srcdir)
f.md<-file_ext(f)
f.md.w<-grep("md",f.md)
rm(f.df)
#f.df<-array()
m<-grep("SUMMARY",f)
f.sum<-readLines(paste(srcdir,f[m],sep = "/"))
f.sum.o<-grep(".md",f.sum) #.md links in summary.md
f.sum.o.cl<-gsub("\\[[0-9]{1,2}\\]:\t","",f.sum[f.sum.o])
f.sum.o.cl<-append(f.sum.o.cl,"SUMMARY.md",after = 0)
###
f.df<-data.frame(pid=1:length(f.md.w))

for(k in 1:length(f.md.w)){
f.df$file[k]<-f[f.md.w[k]]
f.df$pos[k]<-which(f.df$file[k]==f.sum.o.cl)
f.df$head[k]<-readLines(paste(srcdir,f[f.md.w[k]],sep = "/"))[1]
f.df$page[k]<-  readtext(paste(srcdir,f[f.md.w[k]],sep = "/"))$text

}
f.df.o<-d[order(d$pos.m),]

f.df.o$page<-gsub("^#{2,4}","#",f.df.o$page) #turn all top header to h1 header
###
#combine pages
writeLines(f.df.o$page[2:length(f.df.o$page)],"mdbook/ses-wrapup-raw.md")
f.df.o$file.index<-letters[1:length(f.df.o$file)]
f.df.o$file.sort<-paste0(f.df.o$file.index,"_",f.df.o$file)
dir.create("ulysses")
for(k in 1:length(f.df.o$file)){
  writeLines(f.df.o$page[k],paste("ses-md",f.df.o$file.sort[k],sep = "/"))
}
write_csv(f.df.o,"/volumes/ext/boxhkw/21s/dh/local/hu-lx/doc/ses-wrapup.csv")

d<-read_csv("/volumes/ext/boxhkw/21s/dh/local/hu-lx/doc/ses-wrapup.csv")
m<-which(d$pos.m!=0)
k<-20
for(k in m[1]:length(d$file)){
  writeLines(d$page[k],paste("ses-mdb",d$file[k],sep = "/"))
}
for(k in 1:length(d$file)){
  writeLines(d$page[k],paste("ses-mdb",d$file[k],sep = "/"))
}
regx<-"((?<=:\t)(.*)(?=.png))"
repl<-"https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/\\1"
d$page[1:19]<-gsub(regx,repl,d$page[1:19],perl = T)
d$page[1]
md.sum<-readtext("ses-mdb/SUMMARY.md")$text
md.sum
f.df.o$page[1]<-md.sum
#d$page[20]<-f.df.o$page[20]
# regx19i<-"((?<=:)(.*)(?=.png))"
# repl19i<-"<head>\\3</head>\\4"

# f.df[7]
# k<-6
# f.x<-readtext(paste(srcdir,f[f.md.w[k]],sep = "/"))
# f.x$text
m<-grep("SUMMARY",f)
f.sum<-readLines(paste(srcdir,f[m],sep = "/"))
f.sum
#####

f.sum.o<-grep(".md",f.sum) #.md links in summary.md
f.sum.o.cl<-gsub("\\[[0-9]{1,2}\\]:\t","",f.sum[f.sum.o])
f.sum.o.cl<-append(f.sum.o.cl,"SUMMARY.md",after = 0)
m<-which(f.sum.o.cl%in%f.df$file)
which(f.df$file==f.sum.o.cl[1])
k<-1
which(f.df$file[k]==f.sum.o.cl)

