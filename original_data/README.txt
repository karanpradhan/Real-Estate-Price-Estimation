processing

1. preprocss.py: read files and generate a set of files such that rows correspond  to
   price.txt
   city.txt
   words.txt
   bigrams.txt

2. make_dictionary.py: generates 
    word_dictionary.txt  - a dictionary mapping between words/bigrams and integers
    <input_filename>.int - a translation of the input file into integers

3. convert the city, words and bigram files into sparse matlab matrices
    dropping words of count less than 4

4. split into train and test set

