// --- Day 18: Duet ---
// https://adventofcode.com/2017/day/18

import 'dart:collection';

class Memory {
  int _sendCounter = 0;
  final Queue<int> _inQueue;
  final Queue<int> _outQueue;
  final Map<String, int> _registers = new Map();

  Memory([this._inQueue = null, this._outQueue = null]);

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

  int getValue(var value) => int.tryParse(value) ?? getRegister(value);

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

int solveB(List<String> instructions) {
  Queue<int> qA = new Queue();
  Queue<int> qB = new Queue();

  Memory memA = new Memory(qB, qA)..setRegister("p", 0);
  Memory memB = new Memory(qA, qB)..setRegister("p", 1);

  Iterator iA = runProgram(instructions, memA).iterator;
  Iterator iB = runProgram(instructions, memB).iterator;

  bool statusA, statusB;
  do {
    statusA = iA.moveNext();
    statusB = iB.moveNext();
  } while (!statusA || !statusB || memA.canReceive || memB.canReceive);

  return memB.sendCounter;
}

Iterable runProgram(List<String> instructions, Memory mem) sync* {
  for (int i = 0; i < instructions.length; i++) {
    String instruction = instructions[i];
    List<String> parts = instruction.split(" ");
    String opcode = parts[0];
    String x = parts[1];
    String y = parts.length == 3 ? parts[2] : null;

    if (opcode == "snd") {
      mem.send(mem.getValue(x));
    } else if (opcode == "set") {
      mem.setRegister(x, mem.getValue(y));
    } else if (opcode == "add") {
      mem.setRegister(x, mem.getRegister(x) + mem.getValue(y));
    } else if (opcode == "mul") {
      mem.setRegister(x, mem.getRegister(x) * mem.getValue(y));
    } else if (opcode == "mod") {
      mem.setRegister(x, mem.getRegister(x) % mem.getValue(y));
    } else if (opcode == "rcv") {
      while (!mem.canReceive) {
        yield null;
      }
      mem.setRegister(x, mem.receive());
    } else if (opcode == "jgz") {
      if (mem.getValue(x) > 0) {
        i += mem.getValue(y) - 1;
        continue;
      }
    } else {
      throw "Unknown instruction: $instruction";
    }
  }
}
