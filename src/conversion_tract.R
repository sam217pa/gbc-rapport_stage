library(gcbiasr)
library(ggplot2)
library(dplyr)
library(extrafont)

snp <- conversion_tract

height <- 8.3
width <- 5.8

pdf('img/trace_w.pdf', family = "Ubuntu", height = height, width = width, onefile = FALSE)
plot_align(snp, "w" ,plot_title = "") +
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('img/trace_s.pdf', family = "Ubuntu", height = height, width = width, onefile = FALSE)
plot_align(snp, "s" ,plot_title = "")+
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('img/trace_ws.pdf', family = "Ubuntu", height = height, width = width, onefile = FALSE)
plot_align(snp, "ws" ,plot_title = "")+
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
pdf('img/trace_sw.pdf', family = "Ubuntu", height = height, width = width, onefile = FALSE)
   plot_align(snp, "sw" ,plot_title = "")+
    guides(color = FALSE, size = FALSE, shape = FALSE)
dev.off()
