#20240121(07.14)
#14042.overview-docx.from.mdbook-src
####################################
### critical
.libPaths(new = "/home/runner/work/HU-LX/HU-LX/rlibs", include.site = TRUE)
###
library(rmarkdown)
library(bookdown)

### get mds clean
srcpath<-"./mdbook/workflow/src/"
mdf<-list.files(srcpath)
#mdf
#mdtemp<-tempdir("tmd")
k<-1
#sort(mdf)
#m<-grepl("SUMMARY",mdf)
#rm(mdf.cl)
m<-grepl("^_",mdf)
mdf<-mdf[!m]
mdf.d<-paste0(srcpath,mdf)
#mdf.cl<-gsub("\\..*","",mdf)
#dir.create("./mod")
dir.create("./pages")
file.copy("./overview-rmd/","./pages/",overwrite = T,recursive = T)
#dir.create("./")
mdf.cl<-gsub("\\..*","",mdf)
mdf.rmd<-paste0(mdf.cl,".Rmd")
for(k in 1:length(mdf)){
  md<-readLines(mdf.d[k])
  #lookaround
  #regx19i<-"((?<=<castList>)((Personen.)(.*)){1,7}(?=</castList>))"
  regx.foot<-"\\[\\^([0-9]{1,2})\\]"
  m3<-grep(regx.foot,md)
  md[m3]
  #gsub("\\\\\\[([a-zA-Z.]{1,9})\\\\\\]","[\\1]",tmd[m])
  # md[m2]<-gsub("\\\\\\[([a-zA-Z.]{1,12})\\\\\\]","[\\1]",md[m2]) # replace relative image links ![][image-1] with abs
  # 
  repl.foot<-paste0("[^",k,"-\\1]")
  md[m3]<-gsub(regx.foot,repl.foot,md[m3],perl = T) # replace relative image links ![][image-1] with abs
  m<-grep("(\\[[0-9]{1,2}\\])",md)
  rep<-paste0(k,"-\\1")
  fig<-gsub("((?<=\\[)([0-9]{1,2})(?=\\]))",rep,md[m],perl = T) # make links unique over global doc by adding section number
  md[m]<-fig
  mdns<-paste0("./mod/",mdf.cl[k])
  mdns<-paste0("./pages/overview-rmd/",mdf.cl[k])
#  mdns.docx<-paste0("./docx/",mdf.cl[k],".Rmd")
  mdns.pages<-paste0(mdns,".Rmd")
  # m2<-grep("\\\\\\[[a-zA-Z.]{1,12}\\\\\\]",md)
  regx.img<-"\\[(image-)"
  m2<-grep(regx.img,md)
  md[m2]
  #gsub("\\\\\\[([a-zA-Z.]{1,9})\\\\\\]","[\\1]",tmd[m])
  # md[m2]<-gsub("\\\\\\[([a-zA-Z.]{1,12})\\\\\\]","[\\1]",md[m2]) # replace relative image links ![][image-1] with abs
  # 
  repl.img<-paste0("[",k,"-\\1")
  md[m2]<-gsub("\\[(image-)",repl.img,md[m2],perl = T) # replace relative image links ![][image-1] with abs

  
  #mdns<-mdf.rmd[k]
 # writeLines(md,mdns.docx)
  writeLines(md,mdns.pages)
}
###
getwd()
#render("./docx/overview.md.child_FIRST.Rmd")
# tmd<-readLines("./docx/overview.md.child_FIRST.md")
# m<-grep("\\\\\\[[a-zA-Z.]{1,12}\\\\\\]",tmd)
# tmd[m]
# #gsub("\\\\\\[([a-zA-Z.]{1,9})\\\\\\]","[\\1]",tmd[m])
# tmd[m]<-gsub("\\\\\\[([a-zA-Z.]{1,12})\\\\\\]","[\\1]",tmd[m]) # replace relative image links ![][image-1] with abs
#writeLines(tmd,"./docx/pfaff_corpus-class-overview.md")
#writeLines(tmd,"./pages/pfaff_corpus-class-overview.Rmd")

cat("---- > pages:",list.files("./pages","\n"))
cat("---- > docx:",list.files("./docx","\n"))
cat("\n")
system("pandoc --version") # lapsi: 3.8.2.1 # brew upgrade: 3.8.3, runner: 2.9.2.1
# render("./docx/pfaff_corpusclass-overview.Rmd")
#render_book(input = "./pages")


render_site(input = "./pages/overview-rmd")
# render_book(input = "./pages/overview-rmd")
cat("------ > processed site....\n")
doc.child<-"../pages/overview-rmd/_book/pfaff_corpusclass-overview.md"
# doc.child<-"../pages/overview-rmd/pfaff_corpusclass-overview.Rmd"
render("./docx/pfaff_corpusclass-overview-doc.Rmd")

file.copy("./docx/pfaff_corpusclass-overview-doc.docx","./pages/overview-rmd/_book/pfaff_corpusclass-overview.docx",overwrite = T)

