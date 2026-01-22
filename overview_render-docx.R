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
mdf.cl<-gsub("\\..*","",mdf)
mdf.rmd<-paste0(mdf.cl,".Rmd")
#mdf
#mdtemp<-tempdir("tmd")
k<-1
#sort(mdf)
m<-grepl("SUMMARY",mdf)
mdf<-mdf[!m]
mdf.d<-paste0(srcpath,mdf)
#mdf.cl<-gsub("\\..*","",mdf)
dir.create("./mod")
for(k in 1:length(mdf)){
  md<-readLines(mdf.d[k])
  #lookaround
  #regx19i<-"((?<=<castList>)((Personen.)(.*)){1,7}(?=</castList>))"
  m<-grep("(\\[[0-9]{1,2}\\])",md)
  rep<-paste0(k,"-\\1")
  fig<-gsub("((?<=\\[)([0-9]{1,2})(?=\\]))",rep,md[m],perl = T) # make links unique over global doc by adding section number
  md[m]<-fig
  mdns<-paste0("./mod/",mdf[k])
  mdns.docx<-paste0("./mod/",mdf.cl[k],".Rmd")
  mdns.pages<-paste0("./pages/",mdf.cl[k],".Rmd")
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
  writeLines(md,mdns.docx)
  writeLines(md,mdns.pages)
}
###
#getwd()
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
# render("./docx/pfaff_corpusclass-overview.Rmd")
#render_book(input = "./pages")
render_site(input = "./overview-rmd")
render("./docx/pfaff_corpusclass-overview-doc.Rmd")

file.copy("./docx/pfaff_corpusclass-overview-doc.docx","./overview-rmd/_book/pfaff_corpusclass-overview.docx",overwrite = T)

