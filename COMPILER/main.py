# Created by Kavan Heppenstall, 10/09/2024

import sys

from parser import _parser as parser
from lexer import _lexer as lexer
from generator import _generator as generator
from assembler import _assembler as assembler

t0 = lexer.Tokenizer()
t0.Tokenize(sys.argv)

print(t0.tokens)

p0 = parser.Parser(t0.tokens)

print(p0.program)

g0 = generator.Generator(p0.program)

print(g0.output)

a0 = assembler.Assembler(g0.output)

#a0 = assembler.Assembler(['lab:','ADDS R0 R0 #13', 'ADDS R0 R0 #13', 'ST R0 [R7 #0]', 'LD R1 [R7 #0]', 'ADDS R1 R1 R0', 'foo:', 'CMP R0 R0 R0', 'BEQ foo'])

machine_code = a0.assemble()

for i in range(0, len(machine_code)):
    machine_code[i] = f"{int(machine_code[i], 2):04X}"

print(machine_code)

output_soruce = "output/machine_code.txt"

with open(output_soruce, 'w') as outfile:
    for line in machine_code:
        outfile.write(line + "\n")
    outfile.write("finish\n")

    outfile.close()

