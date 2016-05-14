library(gcbiasr)
library(dplyr)
library(extrafont)
library(tidyr)
library(broom)
library(purrr)

snp <- conversion_tract
height <- 5
width <- 6

set_gcbiasr_theme()

pdf("img/gc_content.pdf", family = "Ubuntu", height = height, width = with, onefile = FALSE)
get_gc_content(snp) %>% plot()
dev.off()

gc_content <- get_gc_content(snp)

gc_model <- function(df)
{
    lm(GC ~ type, data = df)
}

gc_content_mod <-
    gc_content %>%
    mutate(type = factor(type, levels = c("Recombinant", "Donneur", "Receveur"))) %>%
    group_by(mutant) %>%
    nest() %>%
    mutate(
        mod = data %>% map(gc_model),
        clean_mod = mod %>% map(broom::tidy)
    )

augment(gc_content_mod$mod[[1]]) %>% head()

aov(data = gc_content, GC ~ type)


tidy(lm(data = gc_content, GC ~ type + mutant))

library(nlme)

fits <- lmList(data = gc_content, GC ~ type | mutant)

summary(fits)

gc_content <- gc_content %>%
    mutate(type = factor(type, levels = c("Recombinant", "Donneur", "Receveur")))

tidy(
    wilcox.test((gc_content %>% filter(mutant == "sw", type == "Recombinant"))$GC,
    (gc_content %>% filter(mutant == "sw", type == "Receveur"))$GC
   ,paired = TRUE
  ## , alternative = "less"
    )
)

library(cowplot)

plot_grid(
    plot(get_gc_content(snp))

)
