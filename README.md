# HGT
Here we describe the analysis of exact matches between genomic sequences published in the biorXiv article: https://www.biorxiv.org/content/10.1101/2020.06.09.139501v2.abstract

1. Identificaton of all exact matches between two genomic sequences: 
To find all matches longer than 300bp between sequences in files 1.fa and 2.fa and save it in the file Res.mumm we use the following command: 
mummer -maxmatch -n -b -l 300 1.fa 2.fa > Res.mumm.
  
2. Making frequency table of matches lengths 
To do so we use the C programm named MakeHistFromMummer.c. It takes as an input Res.mumm and generates the frequency table, that we output to the file named ResHist.mumm.
The output file has two columns: column 1 gives the length of the match, column 2 the corresponding number of matches found for each length.
    
3. Calculation the prefactor of the resulting power-law. 
To calculate the prefactor from the match length frequency table in ResHist.mumm we use the Matlab script that can be found in file CalculatePrefactor.m. It takes as an input the file with the frequency table file, minimal match length (rmin=300bp in our case) and total lengths of sequences 1.fa (L1) and 2.fa (L2).

4. Calculation of the GO and SEED terms along the matches. 
To output the sequence of the matches, we run mummer with the "-s" option: mummer -maxmatch -n -s -b -l 300 1.fa 2.fa > Res.mumm_w_seq. 

To make the connections of SEED to NR accession numbers, from the database files mentioned in the paper we used the
MakeSEEDConnections.py script.

To predict proteins from exact matches we used the following command:
prodigal -i Res.mumm_w_seq.fasta -a predicted_prot.faa -o orf.gff -p meta -q -f gff

To get SEED annotations we used:
diamond blastp -d nr.dmnd -q predicted_prot.faa -o alignment.txt -p 10 —quiet -k 0 ConnectNRToSEED.py

GO terms search has been done using:
./interproscan.sh -i predicted_prot.faa -f tsv -dp --goterms -pa -appl Pfam -appl TIGRFAM --cpu 20

  
5. Calculation of the GO and SEED terms enrichment. 
To calculate the enrichment of GO/SEED terms we use the R script in file Enrichment.R. This script takes as an input a file containing the DNA sequence of the matches (to get their total length) and the number of SEED/GO hits from another file. It outputs the table of GO/SEED terms with their corresponding enrichment and significance level, based on the Fisher exact test.

6. Mathematica notebook IllustrationBox1.nb (see pdf in IllustrationBox1.pdf) describes how Box 1 is generated.
