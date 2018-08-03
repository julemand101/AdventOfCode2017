// --- Day 23: Coprocessor Conflagration ---
// https://adventofcode.com/2017/day/23

int solveA(List<String> program) {
  Map<String, int> registers = {
    "a": 0,
    "b": 0,
    "c": 0,
    "d": 0,
    "e": 0,
    "f": 0,
    "g": 0,
    "h": 0,
  };

  int mulCalls = 0;

  for (int i = 0; i < program.length; i++) {
    String instruction = program[i];
    List<String> parts = instruction.split(" ");
    String opcode = parts[0];
    String x = parts[1];
    int y = getValue(registers, parts[2]);

    if (opcode == "set") {
      registers[x] = y;
    } else if (opcode == "sub") {
      registers[x] -= y;
    } else if (opcode == "mul") {
      registers[x] *= y;
      mulCalls++;
    } else if (opcode == "jnz") {
      if (registers[x] != 0) {
        i += y - 1;
      }
    } else {
      throw "Unknown instruction: $instruction";
    }
  }

  return mulCalls;
}

int getValue(Map<String, int> registers, String value) =>
    int.parse(value, onError: (string) => registers[string]);
