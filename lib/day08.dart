// --- Day 8: I Heard You Like Registers ---
// https://adventofcode.com/2017/day/8

import 'dart:math' as math;

class Memory {
  int _maxValue = 0;
  Map<String, int> _registers = new Map();

  int operator [](String register) {
    if (_registers.containsKey(register)) {
      return _registers[register];
    } else {
      return 0;
    }
  }

  operator []=(String register, int value) {
    if (value > _maxValue) {
      _maxValue = value;
    }
    _registers[register] = value;
  }

  int get maxValue => _maxValue;
}

int solveA(List<String> lines) {
  Memory memory = new Memory();

  return _solve(lines, memory);
}

int solveB(List<String> lines) {
  Memory memory = new Memory();

  _solve(lines, memory);

  return memory.maxValue;
}

int _solve(List<String> lines, Memory memory) {
  for (String line in lines) {
    // PARSE
    List<String> parts = line.split(" ");

    String register = parts[0];
    String instruction = parts[1]; // 'inc' or 'dec'
    int value = int.parse(parts[2]);

    int conditionAValue = memory[parts[4]];
    String conditionSign = parts[5];
    int conditionBValue = int.parse(parts[6]);

    if (_testCondition(conditionAValue, conditionSign, conditionBValue)) {
      switch (instruction) {
        case 'inc':
          memory[register] += value;
          break;
        case 'dec':
          memory[register] -= value;
          break;
        default:
          throw "Unknown instruction: $instruction";
      }
    }
  }

  return memory._registers.values.fold(0, math.max);
}

bool _testCondition(int a, String conditionSign, int b) {
  switch (conditionSign) {
    case '==':
      return (a == b);
    case '!=':
      return (a != b);
    case '>':
      return (a > b);
    case '>=':
      return (a >= b);
    case '<':
      return (a < b);
    case '<=':
      return (a <= b);
    default:
      throw "Unknown condition sign: $conditionSign";
  }
}
