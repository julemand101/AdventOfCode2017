// --- Day 18: Duet ---
// https://adventofcode.com/2017/day/18

import 'dart:collection';

class Memory {
  int _sendCounter = 0;
  final Queue<int> _inQueue;
  final Queue<int> _outQueue;
  final Map<String, int> _registers = {};

  Memory([this._inQueue, this._outQueue]);

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

  int getValue(String value) => int.tryParse(value) ?? getRegister(value);

  void send(int value) {
    _outQueue.add(value);
    _sendCounter++;
  }

  int get sendCounter => _sendCounter;
  bool get canReceive => _inQueue.isNotEmpty;
  int receive() => _inQueue.removeFirst();
}

int solveA(List<String> instructions) {
  int last_played_frequency = 0;
  final mem = Memory();

  for (int i = 0; i < instructions.length; i++) {
    final instruction = instructions[i];
    final parts = instruction.split(" ");
    final opcode = parts[0];
    final x = parts[1];
    final y = parts.length == 3 ? parts[2] : null;

    if (opcode == 'snd') {
      last_played_frequency = mem.getValue(x);
    } else if (opcode == 'set') {
      mem.setRegister(x, mem.getValue(y));
    } else if (opcode == 'add') {
      mem.setRegister(x, mem.getRegister(x) + mem.getValue(y));
    } else if (opcode == 'mul') {
      mem.setRegister(x, mem.getRegister(x) * mem.getValue(y));
    } else if (opcode == 'mod') {
      mem.setRegister(x, mem.getRegister(x) % mem.getValue(y));
    } else if (opcode == 'rcv') {
      if (mem.getValue(x) != 0) {
        break;
      }
    } else if (opcode == 'jgz') {
      if (mem.getValue(x) > 0) {
        i += mem.getValue(y) - 1;
        continue;
      }
    } else {
      throw Exception('Unknown instruction: $instruction');
    }
  }

  return last_played_frequency;
}

int solveB(List<String> instructions) {
  final qA = Queue<int>();
  final qB = Queue<int>();

  final memA = Memory(qB, qA)..setRegister('p', 0);
  final memB = Memory(qA, qB)..setRegister('p', 1);

  final iA = runProgram(instructions, memA).iterator;
  final iB = runProgram(instructions, memB).iterator;

  bool statusA, statusB;
  do {
    statusA = iA.moveNext();
    statusB = iB.moveNext();
  } while (!statusA || !statusB || memA.canReceive || memB.canReceive);

  return memB.sendCounter;
}

Iterable runProgram(List<String> instructions, Memory mem) sync* {
  for (int i = 0; i < instructions.length; i++) {
    final instruction = instructions[i];
    final parts = instruction.split(" ");
    final opcode = parts[0];
    final x = parts[1];
    final y = parts.length == 3 ? parts[2] : null;

    if (opcode == 'snd') {
      mem.send(mem.getValue(x));
    } else if (opcode == 'set') {
      mem.setRegister(x, mem.getValue(y));
    } else if (opcode == 'add') {
      mem.setRegister(x, mem.getRegister(x) + mem.getValue(y));
    } else if (opcode == 'mul') {
      mem.setRegister(x, mem.getRegister(x) * mem.getValue(y));
    } else if (opcode == 'mod') {
      mem.setRegister(x, mem.getRegister(x) % mem.getValue(y));
    } else if (opcode == 'rcv') {
      while (!mem.canReceive) {
        yield null;
      }
      mem.setRegister(x, mem.receive());
    } else if (opcode == 'jgz') {
      if (mem.getValue(x) > 0) {
        i += mem.getValue(y) - 1;
        continue;
      }
    } else {
      throw Exception('Unknown instruction: $instruction');
    }
  }
}
