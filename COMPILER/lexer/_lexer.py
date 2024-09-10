# Created by Kavan Heppenstall, 10/9/2024

# Accept a file and return a list of tokens

import sys, re, os

class Tokenizer:

    def __init__(self):
        self.tokens = -1
        self.token_re = r"[0-9]+|[a-zA-Z]\w*|int|return|[{}\[\]\(\);]"

    def Tokenize(self, sys_args):

        source_file = 0

        if(len(sys_args) > 1):
            source_file = sys_args[1]
        else:
            print("Usage: <source_file.c>")
            return 0

        with open(source_file, 'r') as infile:
            source = infile.read().strip()

            self.tokens = re.findall(self.token_re, source)
            


