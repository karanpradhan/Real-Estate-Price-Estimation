#!/usr/bin/python
#----------------------------------
#     preprocess.py
#----------------------------------
#
# read files and generate a set of files such that rows correspond

price_fptr = open('price.txt','w')
city_fptr  = open('city.txt','w')
words_fptr = open('words.txt','w')
bigrams_fptr = open('bigrams.txt','w')

# for later
files = ['newBostonTokenized3', 'newChicagoTokenized3','newLATokenized3','newLasVegasTokenized3','newMiamiTokenized3','newNewYorkTokenized3','newPhiladelphiaTokenized3']

# for testing
files = ['newChicagoTokenized3']

# should perhaps first filter out the punctuation?

def make_bigrams(word_list):
    bigrams = ''
    word1 = word_list[0]
    for word in word_list[1:]:
        bigrams = bigrams + word1 + '_' + word + ' '
        word1 = word
    return bigrams
    
#----------------------------------------------
for input_filename in files:
 city_name = input_filename[3:8] # for now
 for line in  open('../data/'+input_filename,'r'):
    tokens = line.split()
    price,words  = tokens[0], tokens[1:]
    price_fptr.write(price + '\n')
    for word in words:
        words_fptr.write(word + ' ')
    words_fptr.write('\n')
    city_fptr.write(city_name + '\n')
    bigrams_fptr.write(make_bigrams(words) + '\n')

    

