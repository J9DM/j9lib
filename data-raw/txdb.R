## code to prepare `txdb` dataset goes here

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene::TxDb.Hsapiens.UCSC.hg38.knownGene

usethis::use_data(txdb, overwrite = TRUE)
