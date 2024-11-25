// --- Day 25: The Halting Problem ---
// https://adventofcode.com/2017/day/25

int solve(Iterable<String> input) {
  final rules = <String, Rule>{};
  late String state;
  late int checksum;

  // Parse
  final iter = input.iterator;
  while (iter.moveNext()) {
    String line = iter.current;

    if (line.startsWith('Begin in state ')) {
      state = line['Begin in state '.length];
    } else if (line.startsWith('Perform a diagnostic checksum after ')) {
      checksum = int.parse(line.split(' ')[5]);
    } else if (line.startsWith('In state ')) {
      final state = line['In state '.length];
      final rule = Rule();

      //   If the current value is 0:
      line = next(iter);
      //     - Write the value 1.
      line = next(iter);
      rule.value0write = int.parse(line['    - Write the value '.length]) == 1;
      //     - Move one slot to the right.
      line = next(iter);
      rule.value0cursorMove = (line.contains('right')) ? 1 : -1;
      //     - Continue with state B.
      line = next(iter);
      rule.value0state = line['    - Continue with state '.length];

      //   If the current value is 1:
      line = next(iter);
      //     - Write the value 1.
      line = next(iter);
      rule.value1write = int.parse(line['    - Write the value '.length]) == 1;
      //     - Move one slot to the right.
      line = next(iter);
      rule.value1cursorMove = (line.contains('right')) ? 1 : -1;
      //     - Continue with state B.
      line = next(iter);
      rule.value1state = line['    - Continue with state '.length];

      rules[state] = rule;
    }
  }

  var cursor = 0;
  final tape = Tape();

  for (int step = 0; step < checksum; step++) {
    final rule = rules[state]!;
    final currentValue = tape[cursor];

    tape[cursor] = rule.write(currentValue);
    cursor += rule.cursorMove(currentValue);
    state = rule.state(currentValue);
  }

  return tape.checksum;
}

String next(Iterator<String> iter) {
  if (!iter.moveNext()) {
    throw Exception('Fail!');
  } else {
    return iter.current;
  }
}

class Tape {
  Set<int> tape = {};

  bool operator [](int key) => tape.contains(key);

  void operator []=(int key, bool value) =>
      value ? tape.add(key) : tape.remove(key);

  int get checksum => tape.length;
}

class Rule {
  late bool value0write;
  late int value0cursorMove;
  late String value0state;

  late bool value1write;
  late int value1cursorMove;
  late String value1state;

  bool write(bool value) => !value ? value0write : value1write;
  int cursorMove(bool value) => !value ? value0cursorMove : value1cursorMove;
  String state(bool value) => !value ? value0state : value1state;
}
