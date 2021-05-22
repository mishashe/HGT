
#Input file with connections of NR accession numbers to SEED ontology
#NR accession SSIDs Level1 level2 level3 level4
#Output present in the dataset accessions which can be connected to SEED
SS = {}
with open('SEED_annotation') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        SS[dat[0]] = '\t'.join(dat[2:])

out = open('matches_SEED','w')
with open('alignment.txt') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        if float(dat[-1]) > 50:
            if dat[0] in SS:
                out.write(SS[dat[0]] + '\n')



out.close()


