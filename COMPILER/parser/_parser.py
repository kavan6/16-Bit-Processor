# Created by Kavan Heppenstall, 10/09/2024

import sys
import os

from parser._ast import *

class Parser:

    def __init__(self, tokens):

        self.tokens = tokens
        self.current_token = 0
        self.program = self.parse_program()

    def peek_next_token(self):
        if len(self.tokens) > 0:
            return self.tokens[0]
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

        # statement -> <variable> '=' <exp> | "return" <exp> ";"

        token = self.pop_next_token()

        if token != 'return':
            raise SyntaxError("Expected 'return' keyword")
        
        exp = self.parse_exp()

        token = self.pop_next_token()

        if token != ';':
            raise SyntaxError("Expected ';'")

        return Ret(exp)
    
    def parse_exp(self):

        # expression -> <logicalAndExp> { '||' <logicalAndExp> }

        term = self.parse_logical_exp()

        next = self.peek_next_token()

        while next == '||':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            next = self.peek_next_token()

        return term       
        
    def parse_logical_exp(self):

        # logicalAndExp -> <equalityExp> { '&&' <equalityExp> }

        term = self.parse_equality_exp()

        next = self.peek_next_token()

        while next == '&&':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            next = self.peek_next_token()

        return term

    def parse_equality_exp(self):

        # equalityExp -> <relationalExp> { ('!=' | '==') <relationalExp> }

        term = self.parse_relational_exp()

        next = self.peek_next_token()

        while next == '!=' or next == '==':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            next = self.peek_next_token()

        return term
    
    def parse_relational_exp(self):

        # relationalExp -> <additiveExp> { ('<=' | '>=' | '<' | '>') <additiveExp> }

        term = self.parse_additive_exp()

        next = self.peek_next_token()

        while next == '<=' or next == '>=' or next == '<' or next == '>':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            next = self.peek_next_token()

        return term
    
    def parse_additive_exp(self):
        
        # additiveExp -> <term> { ('+' | '-') <term>}

        term = self.parse_term()

        next = self.peek_next_token()

        while next == '+' or next == '-':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            next = self.peek_next_token()

        return term

    def parse_factor(self):

        # factor -> '(' <exp> ')' | <unaryOp> <factor> | <int> 

        token = self.pop_next_token()

        if token == '(':
            exp = self.parse_exp()
            token = self.pop_next_token()
            if token != ')':
                raise SyntaxError("Expected )")
            return exp
                      
        elif token.isdigit():
            return Const(int(token))
        else:
            op = self.check_op(token)
            factor = self.parse_factor()
            return UnaryOp(op, factor)

    def parse_term(self):

        # term -> <factor> { ('*' | '/') <factor> }

        factor = self.parse_factor()

        next = self.peek_next_token()

        while next == '*' or next == '/':
            token = self.pop_next_token()
            op = self.check_op(token)
            next_factor = self.parse_factor()
            factor = BinaryOp(op, factor, next_factor)
            next = self.peek_next_token()

        return factor


    def parse_unary(self, token):

        if token == '~' or token == '!' or token == '-':
            return token
        else:
            return 
            raise SyntaxError("Expected unary operator (~, !, -)")
    
    def check_op(self, token):

        # binary_op -> '+' | '*' | '/'
        # unary_op -> '~' | '!' | '-'

        if token == '+' or token == '*' or token == '/' or token == '~' or token == '!' or token == '-':
            return token
        elif token == '&&' or token == '||' or token == '<=' or token == '>=' or token == '<' or token == '>':
            return token      
        else:
            return 
            raise SyntaxError("Invalid operator expected: (+, *, /, !, -, ~)")
        