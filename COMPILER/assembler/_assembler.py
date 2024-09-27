# Created by Kavan Heppenstall, 11/09/2024

class Assembler:

    def __init__(self, instructions):
        self._op_map = {
            "JMP" : "0000",
            "ADD" : "0001",
            "SUB" : "0010",
            "LSL" : "0011",
            "LSR" : "0100",
            "AND" : "0101",
            "OR" : "0110",
            "XOR" : "0111",
            "LD" : "1000",
            "ST" : "1001",
            "MOV" : "1010",
            "BEQ" : "1011",
            "BNE" : "1100",
            "BLT" : "1101",
            "BGT" : "1110",
            "CMP" : "1111"
        }
        self._label_map = {}
        self._instructions = instructions
        self._pass = False

    def assemble(self):

        if not self._pass:
            self.find_labels()
            self._pass = True
        return self.generate_machine_code()

    def find_labels(self):
        address = 0

        for instruction in self._instructions:
            if ':' in instruction:
                label = instruction.split(':')[0]
                self._label_map[label] = address
            else:
                address += 1

    def generate_machine_code(self):
        
        m_code = []
        address = 0
        for instruction in self._instructions:
            instruction = instruction.strip()
            instruction = instruction.replace('[', '')
            instruction = instruction.replace(']', '')
            if ':' in instruction:
                continue
            elif 'ADD' in instruction or 'SUB' in instruction or 'LSL' in instruction or 'LSR' in instruction or 'AND' in instruction or 'OR' in instruction or 'XOR' in instruction:
                parts = instruction.split(' ')

                OP = self._op_map[parts[0][0:3]]
                REG0 = self.get_reg_code(parts[1])
                REG1 = self.get_reg_code(parts[2])

                immed_en = '0'
                flag_en = '0'

                if 'S' in parts[0][-1]:
                    flag_en = '1'
                
                if '#' in parts[3]:
                    immed_en = '1'
                    code = OP + REG0 + REG1 + self.get_immed_code(parts[3].strip('#')) + flag_en + immed_en
                else:
                    REG2 = self.get_reg_code(parts[3])
                    code = OP + REG0 + REG1 + REG2 + '0' + flag_en + immed_en
            
            elif 'LD' in instruction or 'ST' in instruction:
                parts = instruction.split(' ')

                OP = self._op_map[parts[0][0:2]]
                REG0 = self.get_reg_code(parts[1])
                REG1 = self.get_reg_code(parts[2])

                immed_en = '0'
                flag_en = '0'

                if 'S' in parts[0][-1]:
                    flag_en = '1'
                
                if '#' in parts[3]:
                    immed_en = '1'
                    code = OP + REG0 + REG1 + self.get_immed_code(parts[3].strip('#')) + flag_en + immed_en
                else:
                    REG2 = self.get_reg_code(parts[3])
                    code = OP + REG0 + REG1 + REG2 + '0' + flag_en + immed_en
            elif 'MOV' in instruction:
                parts = instruction.split(' ')

                OP = self._op_map[parts[0][0:3]]
                REG0 = self.get_reg_code(parts[1])
                REG1 = self.get_reg_code(parts[2])

                immed_en = '0'
                flag_en = '0'

                if 'S' in parts[0][-1]:
                    flag_en = '1'
                
                if '#' in parts[3]:
                    immed_en = '1'
                    code = OP + REG0 + REG1 + self.get_immed_code(parts[3].strip('#')) + flag_en + immed_en
                else:
                    raise ValueError("MOV instruction missing immediate")
            elif 'BEQ' in instruction or 'BNE' in instruction or 'BLT' in instruction or 'BGT' in instruction or 'JMP' in instruction:
                parts = instruction.split(' ')
                label = parts[1]
                if label in self._label_map:
                    code = self._op_map[instruction.split(' ')[0]] + self.get_address_code(self._label_map[label]) + '1'
                elif 'R' in label:
                    REG = self.get_reg_code(label)
                    code = self._op_map[instruction.split(' ')[0]] + '000' + REG + '00000' + '0'
                else:
                    raise ValueError(f"Undefined label {label}")
            elif 'CMP' in instruction:
                parts = instruction.split(' ')

                OP = self._op_map['CMP']
                REG0 = self.get_reg_code(parts[1])
                REG1 = self.get_reg_code(parts[2])

                immed_en = '0'
                flag_en = '1'
                
                if '#' in parts[3]:
                    immed_en = '1'
                    code = OP + REG0 + REG1 + self.get_immed_code(parts[3].strip('#')) + flag_en + immed_en
                else:
                    REG2 = self.get_reg_code(parts[3])
                    code = OP + REG0 + REG1 + REG2 + '0' + flag_en + immed_en

            m_code.append(code)
            address += 1
        return m_code

    def get_reg_code(self, reg):
        return format(int(reg[1]), '03b')

    def get_immed_code(self, immed):
        if int(immed) > 15:
            raise ValueError("Immediate > 15 unsupported")
        elif int(immed) < 0:
            raise ValueError("Immediate < 0 unsupported")
        return format(int(immed), '04b')

    def get_address_code(self, address):
        return format(address, '011b')