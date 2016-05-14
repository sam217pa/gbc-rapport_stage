library(gcbiasr)
library(dplyr)
library(ggthemes)

snp <- conversion_tract

set_gcbiasr_theme()

pdf("img/gc_content.pdf", )
get_gc_content(snp) %>% plot()
dev.off()
