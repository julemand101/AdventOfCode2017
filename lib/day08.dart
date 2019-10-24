// --- Day 8: I Heard You Like Registers ---
// https://adventofcode.com/2017/day/8

import 'dart:math' as math;

class Memory {
  int _maxValue = 0;
  final Map<String, int> _registers = {};

  int operator [](String register) {
    if (_registers.containsKey(register)) {
      return _registers[register];
    } else {
      return 0;
    }
  }

  void operator []=(String register, int value) {
    if (value > _maxValue) {
      _maxValue = value;
    }
    _registers[register] = value;
  }

  int get maxValue => _maxValue;
}

int solveA(List<String> lines) {
  final memory = Memory();
  _solve(lines, memory);

  return memory._registers.values.fold(0, math.max);
}

int solveB(List<String> lines) {
  final memory = Memory();
  _solve(lines, memory);

  return memory.maxValue;
}

void _solve(List<String> lines, Memory memory) {
  for (final line in lines) {
    // PARSE
    final parts = line.split(' ');

    final register = parts[0];
    final instruction = parts[1]; // 'inc' or 'dec'
    final value = int.parse(parts[2]);

    final conditionAValue = memory[parts[4]];
    final conditionSign = parts[5];
    final conditionBValue = int.parse(parts[6]);

    if (_testCondition(conditionAValue, conditionSign, conditionBValue)) {
      switch (instruction) {
        case 'inc':
          memory[register] += value;
          break;
        case 'dec':
          memory[register] -= value;
          break;
        default:
          throw Exception('Unknown instruction: $instruction');
      }
    }
  }
}

bool _testCondition(int a, String conditionSign, int b) {
  switch (conditionSign) {
    case '==':
      return a == b;
    case '!=':
      return a != b;
    case '>':
      return a > b;
    case '>=':
      return a >= b;
    case '<':
      return a < b;
    case '<=':
      return a <= b;
    default:
      throw Exception('Unknown condition sign: $conditionSign');
  }
}
