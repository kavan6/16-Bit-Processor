# Created by Kavan Heppenstall, 10/09/2024

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
        self.exp = Const(0)
        self.statement = Ret(self.exp)
        self.function_declaration = Function("my_func", self.statement)
        self.program = Program(self.function_declaration)
