# Created by Kavan Heppenstall, 10/09/2024

from parser._ast import *

class Generator:

    def __init__(self, AST):
        self._AST = AST

        self._func_label = None
        self._stack_addr = None

        self._label_count = 0
        self._stack_count = 512

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
        elif isinstance(node, BinaryOp):
            return self.visit_binary(node)
        else:
            raise ValueError(f"Unknown AST node type: {type(node)}")
    
    def visit_program(self, node):
        self.generate_code(node._func_dec)

    def visit_function(self, node):
        func_name = node._string
        self._func_label = func_name

        self._stack_addr = self.gen_stack()

        # Function entry point label
        self.output.append(f"{func_name}:")


        self.make_constant(self._stack_addr)

        # Initialise stack pointer register R5
        self.output.append(f"MOV R5 R7 #0")
        self.output.append(f"ADD R5 R7 R6")

        # Gen function body
        self.generate_code(node._statement)

        # Function end point label
        self.output.append(f"end:")

    def visit_return(self, node):

        # Generate return expression
        self.generate_code(node._exp)

        # Exit function
        self.output.append(f"JMP end")

    def visit_constant(self, node):

        # Set constant
        constant = node._integer

        self.make_constant(constant)

    def visit_unary(self, node):

        self.generate_code(node._exp)

        if node._operator == '!':
            
            label_false = self.gen_label()
            label_end = self.gen_label()

            self.output.append(f"CMP R7 R6 R7")
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

    def visit_binary(self, node):

        self.generate_code(node._exp0)

        # Decrement stack pointer
        self.output.append(f"SUB R5 R5 #1")
        # Store R6 (constant) into open spot in stack
        self.output.append(f"ST R6 [R5 #0]")

        # Load R1 with top of stack
        self.output.append(f"LD R1 [R5 #0]")
        # Increment stack pointer
        self.output.append(f"ADD R5 R5 #1")

        self.generate_code(node._exp1)

        if node._operator == '+':           
            self.output.append(f"ADD R1 R1 R6")
        elif node._operator == '-':
            self.output.append(f"SUB R1 R1 R6")
        elif node._operator == '*':
            
            self.output.append(f"MOV R0 R7 #0")

            label_end = self.gen_label()

            self.output.append(f"CMP R7 R1 R7")
            self.output.append(f"BEQ {label_end}")
            self.output.append(f"CMP R7 R6 R7")
            self.output.append(f"BEQ {label_end}")

            label_loop = self.gen_label()

            self.output.append(f"{label_loop}:")
            
            self.output.append(f"ADD R0 R0 R1")

            self.output.append(f"SUBS R6 R6 #1")

            self.output.append(f"BNE {label_loop}")

            self.output.append(f"{label_end}:")
            self.output.append(f"MOV R6 R0 #0")


        elif node._operator == '/':
            print("DIVIDE")
        else:
            raise ValueError("Unknown binary operator {node._operator}")

    def get_assembly(self):

        return "\n".join(self.output)
    
    def gen_label(self):
        self._label_count += 1
        return f"_L{self._label_count}"
    
    def gen_stack(self):
        self._stack_count -= 1
        return self._stack_count

    def make_constant(self, constant):

        if int(constant) > 15 or int(constant) < 0:
            # Make constant as it cannot be created with an immediate
            b_const = format(constant, 'b')
            nzeros = 16 - len(b_const)
            zeros = nzeros*'0'
            b_const = zeros + b_const

            self.output.append(f"MOV R6 R7 #0")

            # Break larger (16 bit) immediate down into 4 bit immediates
            # 4 bit immediates are supported
            for i in range(0, 16, 4):
                # Convert 4 bit parts of constant into integers
                part = int(b_const[i:i+4], 2)
                # Shift will depend on which part of constant is being dealt with
                shift_amount = 12 - i

                # Nothing needs to be done for 0
                if part != 0:
                    # Incrementally build constant through accumulation
                    self.output.append(f"ADD R6 R6 #{part}")

                    # No shift needed for last part
                    if shift_amount > 0:
                        # Shift parts
                        self.output.append(f"LSL R6 R6 #{shift_amount}")

            # If constant negative create the negative through subtraction
            if constant < 0:
                self.output.append(f"SUB R6 R7 R6")

        else:
            # Move immediate constant into return register R6
            self.output.append(f"MOV R6 R7 #{constant}")
