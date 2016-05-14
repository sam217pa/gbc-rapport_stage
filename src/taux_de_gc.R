library(gcbiasr)
library(dplyr)
library(extrafont)
## library(tidyr)
library(broom)
## library(purrr)

snp <- conversion_tract
height <- 5
width <- 6

set_gcbiasr_theme()

gc_content <- get_gc_content(snp)

pdf("img/gc_content.pdf", family = "Ubuntu", height = height, width = with, onefile = FALSE)
gc_content %>% plot(plot_title = "") +
    theme(axis.text.x = element_text(angle = 45))
dev.off()


tidy(
    wilcox.test(
    (gc_content %>% filter(mutant == "sw", type == "Recombinant"))$GC,
    (gc_content %>% filter(mutant == "sw", type == "Receveur"))$GC
   ,paired = TRUE
    )
)
