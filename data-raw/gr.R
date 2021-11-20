## code to prepare `gr` dataset goes here

# Prepare maser
fname <- "~/prosser-lab/seq_projects/Ben_Prosser_RNAseq_Jennine_2021-06/rMATS/output_cstat_0.01_NEG_PTBP2"
msr <- maser::maser(fname, c("NEG", "PTBP2"), ftype = "JC")
msr_filtered <- maser::filterByCoverage(msr, avg_reads = 20)

# Gene of interest
#geneS <- "SYNGAP1"
geneS <- "EPS8L2"
msr_top_gene <- maser::geneEvents(msr_filtered, geneS = geneS, fdr = 0.05, deltaPSI = 0.05)

# GRanges
event <- "A3SS"
events_grl <- slot(msr_top_gene, paste0(event, "_gr"))
gr <- unlist(events_grl)

# Data
usethis::use_data(gr, overwrite = TRUE)
