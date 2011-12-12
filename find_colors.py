#!/usr/bin/env python

# call using test_find_colors
# ./find_colors.py 'pretty/pretty_3_grams_PHC_50k_30.csv' 'a b c dog'
# generates colors.csv 

# TODO: add in test whether source file is a .csv (with header) or .txt (without header)

import os, sys

# source of the lists to be processed
category_file = open("categories.txt")


# put category_names in right format for grep
def make_category_names(name_list):
    '''category_names='("bluejay"|"parrot"|"blackbird")' '''
    category_names = "'(" + '"' + '"|"'.join(name_list) + '"' + ")'"
    return category_names

def call_R():
    # TODO: finish
    # TODO change into the approriate directory (?)
    os.system('R CMD BATCH --no-save colors.R')
    # saves the resulting pdf to subdirectory ./pdfs/

def make_colors_csv(filename, category_names, header=True):
    if (header):
        os.system('touch colors.csv; rm colors.csv')
        # grab the header
        call_grep1 = '(head -1 ' + filename + ' )  > colors.csv'
        os.system(call_grep1)
        # grab the rest
        category_names = "'(" + '"' + '"|"'.join(name_list) + '"' + ")'"
        call_grep2 = ' (egrep ' + category_names + ' ' + filename + ')' + ' >> colors.csv'
    else:
        os.system('touch colors.txt; rm colors.txt')
        category_names = "'(" +  '|'.join(name_list)  + ")'"
        call_grep2 = ' (egrep ' + category_names + ' ' + filename + ')' + ' >> colors.txt'
    #print call_grep2  # debug
    os.system(call_grep2)
    
if __name__ == '__main__':
    #filename = 'pretty/pretty_3_grams_PHC_50k_30.csv'
    filename = sys.argv[1]
    #name_list = ['alpha', 'beta', 'delta']
    name_list = sys.argv[2].split()
    print 'source file    = ', filename
    print 'category names = ', ' '.join(name_list)
    filetype = filename.split('.')[1].strip()
    header = True
    if filetype == 'txt':
        header = False
    make_colors_csv(filename, name_list, header)





