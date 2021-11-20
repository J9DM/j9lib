#' GRanges from maser event
#'
#' A dataset containing the genomic ranges associated with a maser event type
#' for a single gene.
#'
#' @format A GRanges object with event ranges and 3 metadata columns:
#' \describe{
#'   \item{ranges}{IRanges}
#'   \item{ID}{rMATS event ID}
#'   \item{GeneID}{ENSG}
#'   \item{geneSymbol}{gene symbol}
#' }
"gr"
