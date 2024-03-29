% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_msr2gviz.R
\name{plot_msr2gviz}
\alias{plot_msr2gviz}
\title{Generates a Gviz plot associated with an rMATS event type for a single gene.}
\usage{
plot_msr2gviz(gr, txdb, n_plus = 1000)
}
\arguments{
\item{gr}{GRanges object for a given gene and event type "event" (metadata)}

\item{txdb}{A TxDb object}

\item{n_plus}{Integer to expand IRanges for plotting (comparable to + operator)}
}
\value{
A Gviz plotTracks plot
}
\description{
Generates a Gviz plot associated with an rMATS event type for a single gene.
}
