# Created by Kavan Heppenstall, 10/09/2024

from parser._ast import *

class Generator:

    def __init__(self, AST):
        self._AST = AST

        self.output = []
        self.generate_code(self._AST)

    def generate_code(self, node):

        if isinstance(node, Program):
            return self.visit_program(node)
        elif isinstance(node, Function):
            return self.visit_function(node)
        elif isinstance(node, Ret):
            return self.visit_return(node)
        elif isinstance(node, Const):
            return self.visit_constant(node)
        else:
            raise ValueError(f"Unknown AST node type: {type(node)}")
    
    def visit_program(self, node):
        self.generate_code(node._func_dec)

    def visit_function(self, node):
        func_name = node._string
        self.output.append(f" .globl _{func_name}")       
        self.output.append(f"_{func_name}:")

        self.generate_code(node._statement)

    def visit_return(self, node):

        self.generate_code(node._exp)

        self.output.append(f"ret")

    def visit_constant(self, node):

        constant = node._integer

        self.output.append(f"movl ${constant}, %eax")

    def get_assembly(self):

        return "\n".join(self.output)