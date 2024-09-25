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


        self.gen_constant(self._stack_addr)

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

        self.gen_constant(constant)

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

        # Load *R1* with top of stack
        # R1 needs some form of allocation as it gets replaced if there are more than 2 operands in use
        self.output.append(f"LD R1 [R5 #0]")
        # Increment stack pointer
        self.output.append(f"ADD R5 R5 #1")

        self.generate_code(node._exp1)

        if node._operator == '+':           
            self.output.append(f"ADD R6 R1 R6")
        elif node._operator == '-':
            self.output.append(f"SUB R6 R1 R6")
        elif node._operator == '*':
            
            self.gen_multiplication()

        elif node._operator == '/':
            
            # if R6 is 0 we have divide by 0
            if node._exp1 == 0:
                raise ValueError(f"Divide by 0 error")

            self.gen_division()

        elif node._operator == '%':

            self.gen_modulo()
            
        elif node._operator == '||':
            self.output.append(f"OR R6 R1 R6")
        elif node._operator == '&&':
            self.output.append(f"AND R6 R1 R6")
        elif node._operator == '<<':
            self.output.append(f"LSL R6 R1 R6")
        elif node._operator == '>>':
            self.output.append(f"LSR R6 R1 R6")
        elif node._operator == '^':
            self.output.append(f"XOR R6 R1 R6")
        elif node._operator == '!=':
            
            self.gen_notequal()

        elif node._operator == '==':

            self.gen_equal()

        elif node._operator == '<=':
            
            self.gen_lteq()

        elif node._operator == '>=':

            self.gen_gteq()     

        elif node._operator == '<':
            
            self.gen_lt()
        
        elif node._operator == '>':
            
            self.gen_gt()

        else:
            raise ValueError(f"Unknown binary operator {node._operator}")

    def get_assembly(self):

        return "\n".join(self.output)
    
    def gen_label(self):
        self._label_count += 1
        return f"_L{self._label_count}"
    
    def gen_stack(self):
        self._stack_count -= 1
        return self._stack_count

    def gen_multiplication(self):
        
        # OPERATION: R1*R6 -> R6

        self.output.append(f"MOV R0 R7 #0")

        label_finish = self.gen_label()

        label_zero = self.gen_label()

        self.output.append(f"CMP R7 R1 R7")
        self.output.append(f"BEQ {label_zero}")
        self.output.append(f"CMP R7 R6 R7")
        self.output.append(f"BEQ {label_zero}")

        label_loop = self.gen_label()

        self.output.append(f"{label_loop}:")
        
        self.output.append(f"ADD R0 R0 R1")

        self.output.append(f"SUBS R6 R6 #1")

        self.output.append(f"BNE {label_loop}")

        self.output.append(f"{label_zero}:")
        self.output.append(f"MOV R6 R0 #0")

        self.output.append(f"{label_finish}:")

    def gen_division(self):
        
        # OPERATION: R1/R6 -> R6

        # initialise accumulator reg (R0) to 0
        self.output.append(f"MOV R0 R7 #0")

        # set operation finish label
        label_finish = self.gen_label()

        # set 0 label
        label_zero = self.gen_label()

        # if first operand is 0 go to end
        # only need to check the first operand with division
        self.output.append(f"CMP R7 R1 R7")
        self.output.append(f"BEQ {label_zero}")

        # set loop label
        label_loop = self.gen_label()

        # beginning of operation loop
        self.output.append(f"{label_loop}:")
        
        # subtract op1 from op1
        self.output.append(f"SUB R1 R1 R6")

        self.output.append(f"ADDS R0 R0 #1")

        self.output.append(f"BGT {label_loop}")
        self.output.append(f"BEQ {label_loop}")
        self.output.append(f"JMP {label_finish}")

        self.output.append(f"{label_zero}:")
        # set return register to 0 (0/anything = 0)
        self.output.append(f"MOV R6 R0 #0")
        
        self.output.append(f"{label_finish}:")

    def gen_modulo(self):

        print("MODULO")

    def gen_notequal(self):

        label_eq = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if equal
        self.output.append(f"BNE {label_eq}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_eq}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")

    def gen_equal(self):

        label_ne = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if not equal
        self.output.append(f"BNE {label_ne}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_ne}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")

    def gen_lteq(self):

        label_gt = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if greater than
        self.output.append(f"BGT {label_gt}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_gt}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")

    def gen_gteq(self):

        label_lt = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if less than
        self.output.append(f"BLT {label_lt}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_lt}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")   

    def gen_lt(self):

        label_ge = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if greater than or equal
        self.output.append(f"BGT {label_ge}")
        self.output.append(f"BEQ {label_ge}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_ge}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")

    def gen_gt(self):

        label_le = self.gen_label()
        label_end = self.gen_label()

        # compare operands
        self.output.append(f"CMP R7 R1 R6")
        # branch if greater than or equal
        self.output.append(f"BLT {label_le}")
        self.output.append(f"BEQ {label_le}")
        self.output.append(f"MOV R6 R7 #1")
        self.output.append(f"JMP {label_end}")

        self.output.append(f"{label_le}:")
        self.output.append(f"MOV R6 R7 #0")

        self.output.append(f"{label_end}:")


    def gen_constant(self, constant):

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

