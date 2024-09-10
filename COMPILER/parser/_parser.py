# Created by Kavan Heppenstall, 10/09/2024

import sys
import os

from parser._ast import *

class Parser:

    def __init__(self, tokens):

        self.tokens = tokens
        self.current_token = 0
        self.program = self.parse_program()


    def get_next_token(self):

        if self.current_token < len(self.tokens):
            token = self.tokens[self.current_token]
            self.current_token += 1
            return token
        else:
            return None
        
    def check_next_token(self):

        if self.current_token < len(self.tokens):
            return self.tokens[self.current_token]
        else:
            return None

    def pop_next_token(self):
        if len(self.tokens) > 0:
            return self.tokens.pop(0)
        else:
            return None

    def parse_program(self):

        # program -> function

        func_dec = self.parse_func_dec()
        return Program(func_dec)
    
    def parse_func_dec(self):
        
        # function -> "int" <name> "(" ")" "{" <statement> "}"

        token = self.pop_next_token()

        if token != 'int':
            raise SyntaxError("Expected 'int' keyword")

        name = self.pop_next_token()

        token = self.pop_next_token()

        if token != '(':
            raise SyntaxError("Expected '('")

        token = self.pop_next_token()

        if token != ')':
            raise SyntaxError("Expected ')'")

        token = self.pop_next_token()

        if token != '{':
            raise SyntaxError("Expected '{'")

        statement = self.parse_statement()

        token = self.pop_next_token()

        if token != '}':
            raise SyntaxError("Expected '}'")

        return Function(name, statement)
    
    def parse_statement(self):

        # statement -> "return" <exp> ";" | "return" <exp> <operator> <exp> ";"

        token = self.pop_next_token()

        if token != 'return':
            raise SyntaxError("Expected 'return' keyword")
        
        exp = self.parse_exp()

        token = self.pop_next_token()

        if token != ';':
            raise SyntaxError("Expected ';'")

        return Ret(exp)
    
    def parse_exp(self):

        # expression -> <int>

        token = self.pop_next_token()

        if not token.isdigit():
            raise SyntaxError("Expected a constant (int)")
        
        return Const(int(token))