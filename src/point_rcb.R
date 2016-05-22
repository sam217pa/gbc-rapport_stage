## [2016-05-16 Mon 11:14] analyses de la distribution des points de recombinaison

library(gcbiasr)
library(ggplot2)
library(extrafont)

set_gcbiasr_theme()

height = 4
width = 6

pdf('img/distr_rcb_pt.pdf', family = "Ubuntu", height = height, width = width, onefile = FALSE)
plot(gcbiasr::breakpoints_distribution(conversion_tract), inverse = FALSE) +
   labs(y = "Nombre de\ntransformants")
dev.off()
