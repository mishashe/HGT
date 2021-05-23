# Import matches sequences
Matches <- read_tsv("matches.fasta",  col_names=FALSE)
# Get number of matches
N_matches <- nrow(Matches)
# Number of control matches is twice as high because for a match between two contigs we take one random sequence from one contig and one random sequence from the secon one. 
N_control <- 2*N_matches


# SEED
Matches <- read_tsv("SEED",  col_names=FALSE)
Control <- read_tsv("SEED_control",  col_names=FALSE)
# Uncomment relevant level below
# Table <- merge(data.frame(table(Matches[,3])),data.frame(table(Control[,3])),by="Var1") # uncomment this for SEED1 analysis
# Table <- merge(data.frame(table(Matches[,4])),data.frame(table(Control[,4])),by="Var1") # uncomment this for SEED2 analysis
# Table <- merge(data.frame(table(Matches[,5])),data.frame(table(Control[,5])),by="Var1") # uncomment this for SEED3 analysis
# Table <- merge(data.frame(table(Matches[,6])),data.frame(table(Control[,6])),by="Var1") # uncomment this for SEED4 analysis


#GO (uncomment for GO analysis)
#Table <- as.data.frame(read_tsv("GO_terms",  col_names=TRUE)); colnames(Table)[1] <- "Var1" # uncomment this for GO analysis


# Calculate enrichment analysis
Table$Enrichment <- 0
Table$ci95 <- 0
Table$pVal <- 0
for (i in 1:nrow(Table))
{
  test <- fisher.test(matrix(as.numeric(c(Table[i,2],N_matches,Table[i,3],N_control)),2,2))
  Table$Enrichment[i] <- test$estimate
  Table$ci95[i] <- test$estimate-test$conf.int[1]
  Table$pVal[i] <- test$p.value
}

# output results
Table <- Table[order(Table$Enrichment,decreasing=TRUE),]
write.table(Table,
            file = paste("Table",sep=""),
            append=FALSE,row.names=FALSE,col.names=TRUE,sep = "\t",quote=FALSE)


#################################################################################################################################



















