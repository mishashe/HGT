# HGT
Here we describe in detail analysis of exact matches between genomic sequences.
1. Calculation of all exact matches between two genomic sequences:

To find all matches longer than 300bp between sequences in files 1.fa and 2.fa and save it in the file Res.mumm we use the following command: mummer -maxmatch -n -b -l 300 1.fa 2.fa > Res.mumm.

2. Making histogram of matches lengths

To do so we use the C programm in file MakeHistFromMummer.c. It takes as an input Res.mumm and generates the histogram in file ResHist.mumm - two columns: match length and corresponding number of matches.


3. Calculation the prefactor of the resulting power-law.

To calculate the prefactor from the match length histogram in ResHist.mumm we use the Matlab script that can be found in file CalculatePrefactor.m. It takes as an input the file with the histogram file, minimal match length (rmin=300bp in our case) and total lengths of sequences 1.fa (L1) and 2.fa (L2).

4. Calculation of the GO and SEED terms along the matches.

To output the matches sequences we run mummer with the "-s" option: mummer -maxmatch -n -s -b -l 300 1.fa 2.fa > Res.mumm.
KSENIA

5. Calculation of the GO and SEED terms enrichment.

To calculate 
