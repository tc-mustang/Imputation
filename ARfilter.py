#!/usr/bin/env python 

#   Filter a vcf file and outputs only the marker that have a lower AR than the one specified
#   rjl278@cornell.edu
#   ARfilter.py <vcf_file> <threshold> <output_prefix>

import sys
import re
import gzip
from itertools import islice

#lista = list()
#lista_set = set()

######## List with the markers to be on the genetic map file

vcf = sys.argv[1];
thresh = sys.argv[2];
out = sys.argv[3];

with gzip.open(vcf, 'rb') as f, gzip.open('%s.vcf.gz' %(out), 'wb') as f_out:
    
    head = list(islice(f, 10))
    for elements in head:
            f_out.write(elements)
    
    for lines in f:
        ar2 = re.findall("AR2=\d.*?\d*?\d*?;", lines[1:350])
        lenght = len(ar2[0])-1
	ar = float(ar2[0][4:lenght])
	if ar > float(thresh) :
		f_out.write(lines)
            
