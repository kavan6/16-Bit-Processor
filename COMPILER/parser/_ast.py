# Created by Kavan Heppenstall, 10/09/2024

class BinaryOp:

    def __init__(self, _operator, _exp0, _exp1):
        self._operator = _operator
        self._exp0 = _exp0
        self._exp1 = _exp1

    def __repr__(self) -> str:
        return f"BinaryOp({self._operator, self._exp0, self._exp1})"


class UnaryOp:

    def __init__(self, _operator, _exp):
        self._operator = _operator
        self._exp = _exp

    def __repr__(self) -> str:
        return f"UnaryOp({self._operator, self._exp})"


class Const:

    def __init__(self, _integer):
        self._integer = _integer

    def __repr__(self) -> str:
        return f"Constant({self._integer})"

class Ret:

    def __init__(self, _exp):
        self._exp = _exp

    def __repr__(self) -> str:
        return f"Return({self._exp})"

class Function:

    def __init__(self, _string, _statement):
        self._string = _string
        self._statement = _statement

    def __repr__(self) -> str:
        return f"Function({self._string}, {self._statement})"

class Program:

    def __init__(self, _func_dec):
        self._func_dec = _func_dec

    def __repr__(self) -> str:
        return f"Program({self._func_dec})"

class AST:
    
    def __init__(self):
        # example
        self.exp = UnaryOp('~', Const(0)) | Const(0)
        self.statement = Ret(self.exp)
        self.function_declaration = Function("my_func", self.statement)
        self.program = Program(self.function_declaration)
