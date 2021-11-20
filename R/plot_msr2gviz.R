#' Generates a Gviz plot associated with an rMATS event type for a single gene.
#'
#' @param gr GRanges object for a given gene and event type "event" (metadata)
#' @param txdb A TxDb object
#' @param n_plus Integer to expand IRanges for plotting (comparable to + operator)
#'
#' @importFrom GenomeInfoDb genome seqnames
#' @importFrom IRanges start end
#' @import Gviz
#'
#' @return A Gviz plotTracks plot
#' @export
#'
#' @examples plot_msr2gviz(gr, txdb)
#'
plot_msr2gviz <- function(gr, txdb, n_plus = 1000) {
  gene_symbol <- gr$geneSymbol %>% unique()

  # rMATS event information
  gen <- GenomeInfoDb::genome(txdb) %>% unique() # genome
  chr <- as.character(GenomeInfoDb::seqnames(gr)[1]) # chromosome
  exon_range_1 <- IRanges::start(gr) %>% min() # start
  exon_range_2 <- IRanges::end(gr) %>% max() # end

  # rMATS event GRanges
  msr_event <- gr$event %>% unique()

  switch(
    msr_event,
    "A3SS" = {
      gr_1 <- gr[names(gr) %in% c("exon_short", "exon_flanking")]
      gr_2 <- gr[names(gr) %in% c("exon_long", "exon_flanking")] },
    "A5SS" = {
      gr_1 <- gr[names(gr) %in% c("exon_short", "exon_flanking")]
      gr_2 <- gr[names(gr) %in% c("exon_long", "exon_flanking")] },
    "RI" = {
      gr_1 <- gr[names(gr) %in% c("exon_upstream", "exon_downstream")]
      gr_2 <- gr[names(gr) %in% c("exon_ir")] },
    "SE" = {
      gr_1 <- gr[names(gr) %in% c("exon_upstream", "exon_downstream")]
      gr_2 <- gr[names(gr) %in% c("exon_upstream", "exon_target", "exon_downstream")] },
    "MXE" = {
      gr_1 <- gr[names(gr) %in% c("exon_upstream", "exon_1", "exon_downstream")]
      gr_2 <- gr[names(gr) %in% c("exon_upstream", "exon_2", "exon_downstream")] }
  )

  # rMATS event ids
  ids_1 <- gr_1$ID
  ids_2 <- gr_2$ID

  # Gviz tracks
  axisTrack <- Gviz::GenomeAxisTrack()

  atrack_1 <- Gviz::AnnotationTrack(gr_1, group = ids_1, name = msr_event,
                                    shape = "box", genome = gen)
  atrack_2 <- Gviz::AnnotationTrack(gr_2, group = ids_2, name = msr_event,
                                    shape = "box", genome = gen)

  grtrack <- Gviz::GeneRegionTrack(txdb, chromosome = chr,
                                   start = exon_range_1, end = exon_range_2,
                                   name = paste("UCSC knownGene:", gene_symbol))

  # gviz
  Gviz::plotTracks(list(axisTrack, atrack_1, atrack_2, grtrack),
                   groupAnnotation = "group", transcriptAnnotation = c("transcript"),
                   from = (exon_range_1 - n_plus), to = (exon_range_2 + n_plus))
}
