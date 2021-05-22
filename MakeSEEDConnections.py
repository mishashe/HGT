

#### Parsing file with ontologies levels
# SSID Level1 Level2 Level3 Level4
# SS00007	RNA Metabolism	RNA processing and modification	16S rRNA modification within P site of ribosome	Penicillin-binding protein 3
levels = {}
with open('m5nr_v1.ontology.all') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        levels[dat[0]] = '\t'.join(dat[1:])


###Parsing file with inner MD5 ontology IDs and SSIDs
#7964	SS00784	14
SS = {}
with open('ontology_map') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        SS[dat[0]] = dat[1]

###Parsing files with connections of MD5 IDs  and inner ontology IDs
#tmd5, source, function, ontology
#000003ac77101b5457b901e0b1fdc162	14	4702390	99512
md5 = {}
with open('md5_ontology_map') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        if dat[0] not in md5:
            md5[dat[0]] = {}
        md5[dat[0]][SS[dat[3]]] = ''
        

###Parsing result of the alignment of NR and MD5
##000003ac77101b5457b901e0b1fdc162 gi|526245024|ref|YP_008320350.1| tail length tape-measure protein [Paenibacillus phage phiIBB_Pl23]....
#Output file with connections of NR accession numbers to SEED ontology
out = open('SEED_annotation','w')
with open('alignment_md5_to_nr') as file1:
    for line in file1:
        dat = line.strip().split('\t')
        if dat[0] in md5:
            for item in md5[dat[0]]:
                out.write('\t'.join([dat[1],item,levels[item]]) + '\n')

out.close()













