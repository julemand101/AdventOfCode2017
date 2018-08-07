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

// Manually optimized
int solveB(_) {
  var h = 0;

  for (var b = 105700; b <= 122700; b += 17) {
    if (!isPrime(b)) {
      h++;
    }
  }

  return h;
}

// https://introcs.cs.princeton.edu/java/13flow/Prime.java.html
bool isPrime(int b) {
  for (var d = 2; (d * d) <= b; d++) {
    if (b % d == 0) {
      return false;
    }
  }
  return true;
}

int getValue(Map<String, int> registers, String value) =>
    int.tryParse(value) ?? registers[value];
