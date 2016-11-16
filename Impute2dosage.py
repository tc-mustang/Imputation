#!/usr/bin/env python

'''
Transforms IMPUTE2 out format to dosage
Roberto Lozano ... rjl278@cornell.edu .. for bugs
'''

import re
import sys
import numpy as np
import gzip

gen = sys.argv[1]       # Gen file gzipped
sample = sys.argv[2]    # Cassava IDs
filt = sys.argv[3]       # only output these filtered marker
output = sys.argv[4]    # output will be gzipped

#gen = "output"     #use for testing in the notebook
#sample = "../final.ped.sample"

f1 = gzip.open(output, 'wt')

header = list()
header.append("ID")
with open(sample) as g:
    next(g) # skip 1 line
    next(g) # skip 2 line
    for lines in g:
        a = lines.split(" ")
        header.append(a[0])
    header.append("\n")    
    f1.write("\t".join(header))    
    #print ("\t".join(header))

keep = list()
with open(filt) as h:
    for lines in h:
        keep.append(lines.rstrip())

keeper = set(keep)

with gzip.open(gen, 'rt') as f :
    
    for lines in f:
        a = lines.split(" ")
        chrom = a[1].split("-")[0]
        snpid = "S"+str(chrom)+"_"+str(a[2])
        
        if snpid in keeper :
            nmarkers = (len(a) - 5)/3
            markers = a[5:]
            
            dosage = list()
            
            for x in range(1, int(nmarkers)*3,3):
                tmp = float(markers[x-1])*0 + float(markers[x])*1 + float(markers[x+1])*2
                tmp2 =  '%.2f' % tmp
                dosage.append(tmp2)
            
            dosage.append("\n") 
            f1.write(snpid+ "\t" + "\t".join(dosage))
        
        else:
            next

f1.close()       
