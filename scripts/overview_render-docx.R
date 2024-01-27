#20240121(07.14)
#14042.overview-docx.from.mdbook-src
####################################
.libPaths(new = "/home/runner/work/HU-LX/HU-LX/rlibs", include.site = TRUE)
library(rmarkdown)
render("../pages/overview.md.child.Rmd")
tmd<-readLines("../pages/overview.md.child.md")
m<-grep("\\\\\\[[a-zA-Z.]{1,12}\\\\\\]",tmd)
tmd[m]
#gsub("\\\\\\[([a-zA-Z.]{1,9})\\\\\\]","[\\1]",tmd[m])
tmd[m]<-gsub("\\\\\\[([a-zA-Z.]{1,12})\\\\\\]","[\\1]",tmd[m])
writeLines(tmd,"../pages/pfaff-corpus-class.md")
render("../pages/overview.docx.parent.Rmd")
#file.copy("..pages/overview.docx.parent.docx","../pages/pfaff-corpusclass-overview.docx",overwrite = T)
