library(readr)
taxa <- read_delim("rankedlineage.dmp", col_names = TRUE,delim="\t|")
species <- taxa$X5
genus <- taxa$X7
family <- taxa$X9
order <- taxa$X11
class <- taxa$X13
phylum <- taxa$X15
kingdom <- taxa$X19
Ind <- which(!is.na(species) & !is.na(genus) & !is.na(family) & !is.na(order) & !is.na(class) & !is.na(phylum) & !is.na(kingdom) & kingdom=="Bacteria")
Table <- data.frame(species=species[Ind],genus=genus[Ind],family=family[Ind],order=order[Ind],class=class[Ind],phylum=phylum[Ind],kingdom=kingdom[Ind])
write.table(Table,
            file = paste("Taxonomy.txt",sep=""),
            append=FALSE,row.names=FALSE,col.names=TRUE,sep = "\t",quote=FALSE)



