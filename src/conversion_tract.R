library(gcbiasr)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(cowplot)
library(tikzDevice)

snp <- read_phruscle("../../seq_mars/data/phruscle_snpcall.csv")

tikz('../img/conv_align.tex', width = 5, height = 10)
plot_grid(
    plot_align(snp, "w"
              ,plot_title = "Génotype des clones transformés par la construction introduisant des AT")
   ,plot_align(snp, "s"
              ,plot_title = "Génotype des clones transformés par la construction introduisant des GC")
   ,plot_align(snp, "ws"
              ,plot_title = "Génotype des clones transformés par la construction introduisant des GC et AT")
   ,plot_align(snp, "sw"
              ,plot_title = "Génotype des clones transformés par la construction introduisant des AT et GC")
)
dev.off()

plot_align(snp, "w")

snp_test <- snp %>%
    filter(mutant %in% "ws") %>%
    keep_clean_only() %>%
    sort_by_tract_length() %>%
    filter(cons == "x" | cons == "X") %>%
    rowwise() %>%
    mutate(expb = ifelse(expb %in% c("A", "T"), "w", "s"))

snp_test

group_by(snp_test, refp) %>%
    summarise(don_label = unique(snpb),
              rec_label = unique(refb),
              ref_pos   = unique(refp))
