#!/usr/bin/env python

#
#   Filter the Dosage files to only includes SNPs from a list
#   In general it will look for the first line of a file. If that element is on the list it will print it.
#   Usage: grepy_set.py <list> <file>
#   Will print the results to the standard output and the header. Modify if you dont have a header. "File" is gzipped 
#   rjl278@cornell.edu
#

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

with gzip.open(sys.argv[2], 'rb') as f:
    header = f.readline()
    print header.rstrip()
    for line in f:
        a = line.split()
        b = a[0]
        if b in lista_set:
            print line.rstrip()


