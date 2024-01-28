#20240121(07.14)
#14042.overview-docx.from.mdbook-src
####################################
.libPaths(new = "/home/runner/work/HU-LX/HU-LX/rlibs", include.site = TRUE)
library(rmarkdown)
getwd()
render("./pages/overview.md.child_FIRST.Rmd")
tmd<-readLines("./pages/overview.md.child_FIRST.md")
m<-grep("\\\\\\[[a-zA-Z.]{1,12}\\\\\\]",tmd)
tmd[m]
#gsub("\\\\\\[([a-zA-Z.]{1,9})\\\\\\]","[\\1]",tmd[m])
tmd[m]<-gsub("\\\\\\[([a-zA-Z.]{1,12})\\\\\\]","[\\1]",tmd[m]) # replace relative image links ![][image-1] with abs
writeLines(tmd,"./pages/pfaff_corpus-class-overwiew.md")
render("./pages/pfaff_corpus-class-overview.Rmd")
#file.copy("..pages/overview.docx.parent.docx","../pages/pfaff-corpusclass-overview.docx",overwrite = T)
