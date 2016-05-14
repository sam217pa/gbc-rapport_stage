library(gcbiasr)
library(dplyr)
library(extrafont)

snp <- conversion_tract
height <- 5
width <- 6

set_gcbiasr_theme()

pdf("img/gc_content.pdf", family = "Ubuntu", height = height, width = with, onefile = FALSE)
get_gc_content(snp) %>% plot()
dev.off()
