library(gcbiasr)
library(dplyr)
library(zoo)
library(seqinr)
library(ggplot2)
library(extrafont)

p <-
    cowplot::plot_grid(
        breakpoints_distribution(conversion_tract) %>% plot(facet = FALSE, inverse = FALSE) +
        xlab("") +
        ylab("Nombre de\ntransformant") +
        theme(axis.text.x = element_blank(), panel.margin = unit(0, "cm"))
       ,
        sliding_gc("~/stage/seq/reference.fasta", 100) %>%
        plot(plot_title = "") +
        ylab("Taux de GC") +
        coord_cartesian(xlim = c(132, 850))
       ,
        ncol = 1,
        align = "v",
        labels = c("a", "b")
    )

ggsave("~/stage/rapport_stage/img/gc_content.pdf", p)
