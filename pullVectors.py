##pullVectors.py
###
## Given a toefl file, pulls out vectors from a given dictionary vector file

import sys
import csv
from optparse import OptionParser  

WORD_COLUMN = 0
VECTOR_START = 5#column where vector starts
VECTOR_END = 1000#big number = rest of array

optParser = OptionParser()

optParser.add_option("-t", "--toefl", metavar="FILENAME", dest="toefl",                                                                  
                     help="toefl file")                                 
optParser.add_option("-c", "--csvfile", metavar="FILENAME", dest="csvfile",     
                     help="csv dictionary filename")                                       
                                                                                
(options,args) = optParser.parse_args()                                                                                                                          

optParser = OptionParser()                                                      

print >> sys.stderr, "READING TOEFL FILE"
reader = csv.reader(open(options.toefl, 'rb'), delimiter=',', quotechar='"')                                                                            
words = set()
i = 0
for row in reader:
    if i > 0:
        words = words.union(set(row))
    i +=1

print >> sys.stderr, "done."

print >> sys.stderr, "READING CSV"
reader = csv.reader(open(options.csvfile, 'rb'), delimiter=',', quotechar='"')                                                                            
newRows = {}
i = 0;
for row in reader:                                                                                                                                                
    if i > 0:
        word = row[WORD_COLUMN]
        if (word in words):
            newRows[word] = row[VECTOR_START:VECTOR_END]
    i+=1
print >> sys.stderr, "done."

print >> sys.stderr, "OUTPUTTING"

words = list(words)

for word in sorted(words):
    if word in newRows:
        print '%s,%s' %(word, ','.join(newRows[word]))
    else:
        print >> sys.stderr, "warning %s not found in big dictionary" % word
                        
