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

class Assign:

    def __init__(self, _name, _exp):
        self._name = _name
        self._exp = _exp

    def __repr__(self) -> str:
        return f"Assign({self._name, self._exp})"

class Var:

    def __init__(self, _string):
        self._string = _string

    def __repr__(self) -> str:
        return f"Var({self._string})"


class Const:

    def __init__(self, _integer):
        self._integer = _integer

    def __repr__(self) -> str:
        return f"Constant({self._integer})"

class Exp:

    def __init__(self, _exp):
        self._exp = _exp

    def __repr__(self) -> str:
        return f"Exp({self._exp})"


class Declare:

    def __init__(self, _string, _exp = 0):
        self._string = _string
        self._exp = _exp

    def __repr__(self) -> str:
        return f"Declare({self._string, self._exp})"

class Ret:

    def __init__(self, _exp):
        self._exp = _exp

    def __repr__(self) -> str:
        return f"Return({self._exp})"

class Function:

    def __init__(self, _string, _statements):
        self._string = _string
        self._statements = _statements

    def __repr__(self) -> str:
        return f"Function({self._string}, {self._statements})"

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
