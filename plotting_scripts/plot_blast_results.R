library(genoPlotR)

setwd("~/Research/jim_summer_projects/flagellaria")


comp <- read_comparison_from_blast("blast_out.txt")

?plot_gene_map

#################
library(ggplot2)
library(dplyr)

# Read in tabular BLAST output (outfmt 6)
blast <- read.table("blast_out.txt", header = FALSE, sep = "\t")
colnames(blast) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen",
                     "qstart", "qend", "sstart", "send", "evalue", "bitscore")


# Bin bitscore into categories
blast <- blast %>%
  mutate(score_bin = cut(bitscore,
                         breaks = c(-Inf, 40, 50, 80, 200, Inf),
                         labels = c("<40", "40–50", "50–80", "80–200", "≥200"),
                         right = FALSE))

# Define custom colors for the bins
score_colors <- c(
  "<40"     = "#000",  # light blue
  "40–50"   = "#0020e9",  # medium blue
  "50–80"   = "#75ea4c",  # green
  "80–200"  = "#db3de9",  # orange
  "≥200"    = "#db3324"   # red
)

blast1 <- blast %>% filter(qseqid=="Flagellaria_indica_Trinity_comp23995_c0_seq1")
blast2 <- blast %>% filter(qseqid=="Flagellaria_indica_Trinity_comp23995_c0_seq2")

# Plot
ggplot(blast1, aes(xmin = qstart, xmax = qend, y = sseqid, color = score_bin)) +
  geom_errorbarh(height = 0.3, size = 1) +
  scale_color_manual(values = score_colors, name = "Bitscore") +
  labs(title = "BLAST Hits Along Seq 1",
       x = "Query Position (seq1)", y = "Subject ID") +
  theme_bw()

ggsave("seq1_blast.png",width = 10,height = 8)

ggplot(blast2, aes(xmin = qstart, xmax = qend, y = sseqid, color = score_bin)) +
  geom_errorbarh(height = 0.3, size = 1) +
  scale_color_manual(values = score_colors, name = "Bitscore") +
  labs(title = "BLAST Hits Along Seq 2",
       x = "Query Position (seq2)", y = "Subject ID") +
  theme_bw()

ggsave("seq2_blast.png",width = 10,height = 8)


