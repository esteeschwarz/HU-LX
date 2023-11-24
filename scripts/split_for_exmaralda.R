library(readtext)
t<-readtext("~/boxHKW/21S/DH/local/HU-LX/LLDM/SESB-12_ADE_DE_WN_txt.txt")
t$text
library(stringi)
pt<-"( |[,.;:!?()]|[a-zäöüß](?=[,.;:?!()]))"
#pt<-"(?=,.[a-z])"
#splits text after: whitespace, ,.;?!(): /tokenizer, including punctuation
stri_split_regex(t$text,pt)
stri_extract_all_regex(t$text,pt)
