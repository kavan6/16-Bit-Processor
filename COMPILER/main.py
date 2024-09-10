# Created by Kavan Heppenstall, 10/09/2024

import sys

from parser import _parser as parser
from lexer import _lexer as lexer
from generator import _generator as generator

t0 = lexer.Tokenizer()
t0.Tokenize(sys.argv)

p0 = parser.Parser(t0.tokens)

g0 = generator.Generator(p0.program)

assem = g0.get_assembly()

print(assem)