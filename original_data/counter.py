#!/usr/bin/python
#
# counts items in a list and sorts them by count

import fileinput, os, sys, re

class Counter:
    def __init__(self):
        self.dict = {}        # map from item to count
    def add(self, item):
        count = self.dict.setdefault(item,0)
        self.dict[item] = count + 1
    def counts(self, descending=None):                # list of (count, item)
        result = [[val, key] for (key, val) in self.dict.items()]
        result.sort()
        if descending: result.reverse()
        return result       
    def pretty_print(self, file_object=False, descending=None):
        # should offer option to limit number printed
        for (val, key) in self.counts(descending):
           #print val, key
           if (file_object):
               print >> file_object, val, key
           else:
               print val, key
               
    def high_counts(self, min_count=0):
        temp_dict = {}
        for (val, key) in self.counts():
            if val > min_count:
                temp_dict[key] = val
        return temp_dict
    
    def top_n_words(self, n=1000000):
        word_counts = self.counts(True)  # descending order
        temp_dict = {}
        for i, (cnt, wrd) in enumerate(word_counts):
            if i < n:
                temp_dict[wrd] = i+1     # 1-based indexing (so 0 can be OOV)
        return temp_dict

    def words(self):
        return self.dict.keys()
    
if __name__ == '__main__':
    sentence = "Hello there this is a test.  Hello there this was a test, but now it is not."
    words = sentence.split()
    c = Counter()
    for word in words:
        c.add(word)
    print "Ascending count:"
    print c.counts()
    print "Descending count:"
    print c.counts(1)
    print "counts bigger than 1"
    print c.high_counts(1)
    print "top 5 words"
    print c.top_n_words(5)
    out_file = open('test_out.txt','w')
    c.pretty_print(out_file)
