# Created by Kavan Heppenstall, 16/09/2024

import copy

class RegisterAllocator:

    def __init__(self, AST, instructions):

        self._instructions = instructions
        self._AST = AST
        self._interference_graph = {}
        self._def_use = {}
        self._in_out = {}
        self._n_registers = 7
        self._registers = {}

        self.liveness_analysis()
        self.build_interference_graph()
        self.simplify()
        self.assign_registers()
        self.update_registers()

    def build_interference_graph(self):

        for instruction in self._instructions:
            live = self._in_out[instruction]['Out']
            for variable in live:
                if variable == 'R7':
                    continue

                if variable not in self._interference_graph:
                    self._interference_graph[variable] = set()
                for variable_dash in live:
                    if variable_dash == 'R7':
                        continue

                    if variable != variable_dash:
                        self._interference_graph[variable].add(variable_dash)

    def simplify(self):
        self.stack = []

        copy_graph = copy.deepcopy(self._interference_graph)

        while copy_graph:
            node = self.get_low_degree_node(copy_graph)
            if not node:
                node = self.select_spill_node(copy_graph)
            self.stack.append(node)
            copy_graph = self.remove_node(copy_graph, node)

    def assign_registers(self):

        while self.stack:

            node = self.stack.pop()

            colours = set(range(self._n_registers))

            neighbours = self._interference_graph.get(node, [])

            for neighbor in neighbours:
                if neighbor in self._registers:
                    colours.discard(self._registers[neighbor])

            if colours:
                self._registers[node] = colours.pop()
            else:
                self.spill(node)

    def spill(self, node):
        print("SPILL:" + node)

    def update_registers(self):
        for v_register, p_register in self._registers.items():
            if v_register == 'R6':
                continue

            self._instructions = [instruction.replace(v_register, f"R{p_register}") for instruction in self._instructions]

    def liveness_analysis(self):

        for instruction in self._instructions:
            parts = instruction.split(' ')

            self._in_out[instruction] = {
                "In" : set(),
                "Out" : set()
            }

        self.compute_def_use()

        changed = True
        while changed:

            changed = False

            for instruction in reversed(self._instructions):

                parts = instruction.split(' ')

                old_in = self._in_out[instruction]['In'].copy() 
                old_out = self._in_out[instruction]['Out'].copy()

                # In[n] = Use[n] U (Out[n] - Def[n]) 

                use_set = self._def_use[instruction]['Use']
                out_set = self._in_out[instruction]['Out']
                def_set = self._def_use[instruction]['Def']

                in_set = use_set | (out_set - def_set)

                self._in_out[instruction]['In'] = in_set


                # Out[n] = U In[s] for each successor of instruction
                if instruction != self._instructions[-1]:
                    next_instr = self._instructions[self._instructions.index(instruction) + 1]
                    self._in_out[instruction]['Out'] = self._in_out[next_instr]['In']

                if old_in != self._in_out[instruction]['In'] or old_out != self._in_out[instruction]['Out']:
                    changed = True


    def compute_def_use(self):

        for instruction in self._instructions:
            parts = instruction.split(' ')

            if parts[0] == 'ADD' or parts[0] == 'SUB' or parts[0] == 'LSL' or parts[0] == 'LSR' or parts[0] == 'CMP':
                _, R0, R1, R2 = parts

                if '#' in parts[3]:
                    self._def_use[instruction] = {
                        "Def" : {R0},
                        "Use" : {R1}
                    }
                else:
                    self._def_use[instruction] = {
                        "Def" : {R0},
                        "Use" : {R1, R2}
                    }

            elif parts[0] == 'MOV':
                
                _, R0, R1, R2 = parts

                if '#' in parts[3] and 'R7' in parts[2]:
                    self._def_use[instruction] = {
                        "Def" : {R0},
                        "Use" : set()
                    }
                elif '#' in parts[3]:
                    self._def_use[instruction] = {
                        "Def" : {R0},
                        "Use" : {R1}
                    }

            elif parts[0] == 'LD' or parts[0] == 'ST':
                if '#' in parts[3]:
                    parts[2] = parts[2].replace('[', '').replace(']', '')
                    _, R0, R1, R2 = parts
                    self._def_use[instruction] = {
                        "Def" : {R0},
                        "Use" : {R1},
                    }
        

            else:
                self._def_use[instruction] = {
                    "Def" : set(),
                    "Use" : set()
                }

    def get_low_degree_node(self, graph):
        for node, edges in graph.items():
            if len(edges) > self._n_registers:
                return node
        
        return None
    
    def remove_node(self, graph, node):
        for neighbour in graph[node]:
            graph[neighbour].remove(node)
        del graph[node]

        return graph

    def select_spill_node(self, graph):
        return max(graph, key=lambda n: len(graph[n]))
    
    def get_instructions(self):
        return self._instructions