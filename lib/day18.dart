// --- Day 18: Duet ---
// https://adventofcode.com/2017/day/18

class Memory {
  Map<String, int> _registers = new Map();

  void setRegister(String register, int value) {
    _registers[register] = value;
  }

  int getRegister(String register) {
    if (_registers.containsKey(register)) {
      return _registers[register];
    } else {
      return 0;
    }
  }

  int getValue(var value) {
    var temp = int.parse(value, onError: (source) => null);

    if (temp == null) {
      return getRegister(value);
    } else {
      return temp;
    }
  }
}

int solveA(List<String> instructions) {
  int last_played_frequency = 0;
  Memory mem = new Memory();

  for (int i = 0; i < instructions.length; i++) {
    String instruction = instructions[i];
    List<String> parts = instruction.split(" ");
    String opcode = parts[0];
    String x = parts[1];
    String y = parts.length == 3 ? parts[2] : null;

    if (opcode == "snd") {
      last_played_frequency = mem.getValue(x);
    } else if (opcode == "set") {
      mem.setRegister(x, mem.getValue(y));
    } else if (opcode == "add") {
      mem.setRegister(x, mem.getRegister(x) + mem.getValue(y));
    } else if (opcode == "mul") {
      mem.setRegister(x, mem.getRegister(x) * mem.getValue(y));
    } else if (opcode == "mod") {
      mem.setRegister(x, mem.getRegister(x) % mem.getValue(y));
    } else if (opcode == "rcv") {
      if (mem.getValue(x) != 0) {
        break;
      }
    } else if (opcode == "jgz") {
      if (mem.getValue(x) > 0) {
        i += mem.getValue(y) - 1;
        continue;
      }
    } else {
      throw "Unknown instruction: $instruction";
    }
  }

  return last_played_frequency;
}
