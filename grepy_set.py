#!/usr/bin/env python 

#   Extract exon number of a set of genes
#   Depending on the file it would need some tweeks
#   rjl278@cornell.edu
#   LIST + FRequencies

import sys
import re

import gzip
lista = list()
lista_set = set()

######## List with the markers to be on the genetic map file

with open(sys.argv[1]) as f:
    tmp = list()
    for line in f:
        lista.append(line.rstrip())
        
 
      
 ######## Genetic Map file      

lista_set = set(lista)  
        
with open(sys.argv[2]) as f:
    for line in f:
        a = line.split()
        b = a[3]
        #print b
        if b in lista_set:
            print line.rstrip()


