# Created by Kavan Heppenstall, 10/09/2024

from parser._ast import *

class Generator:

    def __init__(self, AST):
        self._AST = AST

        self._func_label = None

        self._label_count = 0

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
        elif isinstance(node, UnaryOp):
            return self.visit_unary(node)
        else:
            raise ValueError(f"Unknown AST node type: {type(node)}")
    
    def visit_program(self, node):
        self.generate_code(node._func_dec)

    def visit_function(self, node):
        func_name = node._string
        self._func_label = func_name
        #self.output.append(f" .globl _{func_name}")       
        self.output.append(f"{func_name}:")

        self.generate_code(node._statement)

    def visit_return(self, node):

        self.generate_code(node._exp)

        self.output.append(f"JMP {self._func_label}")

    def visit_constant(self, node):

        constant = node._integer

        self.output.append(f"MOV R6 R7 #{constant}")

    def visit_unary(self, node):

        self.generate_code(node._exp)

        if node._operator == '!':
            
            label_false = self.gen_label()
            label_end = self.gen_label()

            self.output.append(f"CMP R6 R6 R7")
            self.output.append(f"BNE {label_false}")           

            self.output.append(f"MOV R6 R7 #1")
            self.output.append(f"JMP {label_end}")            

            self.output.append(f"{label_false}:")
            self.output.append(f"MOV R6 R7 #0")

            self.output.append(f"{label_end}:")

        elif node._operator == '-':
            self.output.append(f"SUB R6 R0 R6")
        elif node._operator == '~':
            self.output.append(f"SUB R5 R0 #1")
            self.output.append(f"XOR R6 R5 R5")
        else:
            raise ValueError(f"Unknown unary operator")

    def get_assembly(self):

        return "\n".join(self.output)
    
    def gen_label(self):
        self._label_count += 1
        return f"_L{self._label_count}"