library(gcbiasr)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(cowplot)
library(tikzDevice)
library(extrafont)

snp <- read_phruscle("../../seq_mars/data/phruscle_snpcall.csv")

pdf('../img/trace_w.pdf', family = "Ubuntu", height = 11.69, width = 8.27, onefile = FALSE)
plot_align(snp, "w" ,plot_title = "Donneur AT") +
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('../img/trace_s.pdf', family = "Ubuntu", height = 11.69, width = 8.27, onefile = FALSE)
plot_align(snp, "s" ,plot_title = "Donneur GC")+
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('../img/trace_ws.pdf', family = "Ubuntu", height = 11.69, width = 8.27, onefile = FALSE)
plot_align(snp, "ws" ,plot_title = "Donneur AT / GC")+
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('../img/trace_sw.pdf', family = "Ubuntu", height = 11.69, width = 8.27, onefile = FALSE)
   plot_align(snp, "sw" ,plot_title = "Donneur GC / AT")
dev.off()
