#!/usr/bin/python2
#----------------------------------
#  dictionary.py 
#----------------------------------
#
# builds a dictionary to translate between ints and words
# simplest usage:
#     my_dict = dictionary(['testfile.txt'])        # build word -> int mapping
#     print my_dict.translate_file('testfile.txt')  # translate same file     

import os, sys, counter, pickle, time, glob

# WARNING: assumes input is tokenized (depending on option);
#          does not lowercase


class dictionary:
     ''' main class of dictionaries'''
     def __init__(self, doc_list=[], n_vocab=100,zero_based_index = True,tokenize_method="simple",include_OOV=True,file_name="dict.pkl"):
          # TODO: add in options for chinese and for non-zero-base indexing)
          self.n_vocab = n_vocab           # vocabulary size
          self.dict = {}                   # mapping from word to unique integer
          self.inverse_dictionary = {}     # mapping from integer to word
          self.name = file_name
	  self.zero_based_index = zero_based_index
	  self.tokenize_method = tokenize_method
	  self.include_OOV = include_OOV
	  self.dict = build_dictionary(doc_list, self.n_vocab, self.zero_based_index,self.tokenize_method,self.include_OOV)
	  for word in self.dict.keys():
	  	self.inverse_dictionary[self.dict[word]] = word


     def write(self, filename = "dict.pkl"):
          ''' dump dictionary to a pickle'''
          output = open(filename, 'wb')
          pickle.dump(self.dict, output)
          return filename

     def read(self, filename = "dict.pkl"):
          pkl_file = open(filename, 'rb')
          self.dict =  pickle.load(pkl_file)
          return self.dict

     def contains_word(self, word):
          return  word in self.keys()

     def translate_file(self, filename,tokenize_method="simple",include_OOV=True):
          ''' translate words in a file to integers'''
          infile = open(filename)
          words = []
	  words_inter = []
	  words_final = []
	  self.include_OOV = include_OOV
	  '''
          for line in infile:
               #print words  #DEBUG
               if(tokenize_method=="simple"):
                    for word in line.split():
		         word = word.lower()
                         words.append(word)
          #     else: #commented before
          #          words.append(tokenize.tokenize(line)) #commented before
	  '''
	  if(tokenize_method == "simple"):
	  	for line in infile:
			for word in line.split():
			#	word = word.lower()
				words.append(word)
	  else:
	  	for line in infile:
			words_inter.append(tokenize_string(line))
		words = [item for sublist in words_inter for item in sublist]
	  for word in words:
	  	if word <> '</S>':
			words_final.append(word)
          int_list =  translate_words_to_integers(words_final, self.dict,self.zero_based_index,self.include_OOV)
          return int_list

     def translate_directory(self, dirname, outfilename='ints.txt'):
          ''' translate words in files in a directory to ints'''
          outfile = open(outfilename,'w')
          files = glob.glob(dirname + "/*")
          for file in files:
               int_list = self.translate_file(file)
               for item in int_list:
                    outfile.write(str(item) +'\n')
          outfile.close()
    

     def print_dictionary(self, print_ints=False):
          ''' print out the words in the dictionary, with or without the ints'''
          if print_ints:
               words = self.dict.items()
               for pair in words:
                    print pair[1], pair[0]
          else:
               words = self.dict.keys()
               words.sort()
               print words

     def print_dictionary_to_file(self, filename, print_ints=False):
          ''' print out the words in the dictionary, with or without the ints'''
          file_ptr = open(filename,'w')
          if print_ints:
               # TODO: should sort these based on the integer
               words = self.dict.items()
               for pair in words:
                   file_ptr.write(str(pair[1]) + ' ' + pair[0] + '\n')
          else:
               words = self.dict.keys()
               words.sort()
               for word in words:
                    file_ptr.write(word)

def make_dictionary(token_list):
     ''' input: a list of tokens'''
     c = counter.Counter()
     for word in token_list:
          c.add(word)
     word_int_dict = {}          
     for i,word in enumerate(c.words()):
               word_int_dict[word] = i
     return word_int_dict                           # words -> int
          
def build_dictionary(document_list, n_vocab=100,zero_based_index = True,tokenize_method="simple",include_OOV=True, src_directory=""):
     ''' input: a list of documents '''
     c = counter.Counter()

     words = []
     words_mid = []
     words_inter = []
     for document_name in document_list:
     	print document_name
     	file = open(document_name)
	if(tokenize_method == "simple"):
		for line in file:
			for word in line.strip().split():
			#	word = word.lower()
				c.add(word)
	else:
		print "tokenizing"
		words_inter = []
		for line in file:
			words_inter.append(tokenize_string(line))
		words_mid = [item for sublist in words_inter for item in sublist]

		for word in words_mid:
			if word <> '</S>':
				c.add(word)

     words = c.top_n_words(n_vocab).keys()
     #print len(words)
     word_int_dict = {}
     if include_OOV:
          if zero_based_index:
	       word_int_dict['<OOV>'] = 0
	       for i,word in enumerate(words):
	            word_int_dict[word] = i+1
          else:
	       word_int_dict['<OOV>'] = 1
	       for i,word in enumerate(words):
	            word_int_dict[word] = i+2
     else:    
          for i,word in enumerate(words):
               word_int_dict[word] = i
     return word_int_dict                           # words -> int


# TODO: move into the object?
def translate_words_to_integers(word_list, dictionary, zero_based_index = True,keep_OOV=True):
     '''translates the document to a list of integers'''
     # missing word is tagged as '0'
     int_list = []
     for word in word_list:
          if word in dictionary:
               int_list.append(dictionary[word])
          else:
               if(keep_OOV):
		    if zero_based_index:
		         int_list.append(0)
		    else:
                         int_list.append(1)
     return int_list

# TODO: move into the object?
def translate_integers_to_words(int_list, dictionary):
     '''inverse of translate_words_to_integers'''
     # build reverse dictionary
     reverse_dict = {}
     reverse_dict[0] = '-'      # 0 maps to "-" for now
     for (word, int) in dictionary.items():
          reverse_dict[int] = word
     # now map the int_list to corresponding words
     word_doc = []
     for int in int_list:
          if int in reverse_dict:
               word_doc.append(reverse_dict[int])
          else:
               word_doc.append('<OOV>')  # out of vocabulary - should be rare
     return word_doc

if __name__ == '__main__':
     my_dict = make_dictionary(['a', 'list', 'of', 'a', 'word'])
     print my_dict
     my_dict = dictionary(['testfile.txt']) 
     my_dict.print_dictionary()     # defaults without the ints
     my_dict.write()
     my_dict.read()
     my_dict.print_dictionary(True)     # with the ints as well as words

     print "translating file"
     print my_dict.translate_file('testfile.txt')

     print "test one-based indexing"
     my_dict = dictionary(['testfile.txt'], 100, False,"tokenize")
     my_dict.write()
     my_dict.print_dictionary(True)    # with the ints as well as words
     print my_dict.translate_file('testfile.txt')
     
