// --- Day 16: Permutation Promenade ---
// https://adventofcode.com/2017/day/16

abstract class Command {
  void execute(List<String> programs);

  void _spin(List<String> programs, int length) {
    for (int i = 0; i < length; i++) {
      for (int k = programs.length - 1; k != 0; k--) {
        _exchange(programs, k, k - 1);
      }
    }
  }

  void _exchange(List<String> programs, int posA, int posB) {
    final temp = programs[posA];
    programs[posA] = programs[posB];
    programs[posB] = temp;
  }

  void _partner(List<String> programs, String a, String b) {
    final posA = programs.indexOf(a);
    final posB = programs.indexOf(b);
    _exchange(programs, posA, posB);
  }
}

class SpinCommand extends Command {
  final int length;

  SpinCommand(String input) : length = int.parse(input);

  @override
  void execute(List<String> programs) {
    _spin(programs, length);
  }
}

class ExchangeCommand extends Command {
  late final int posA;
  late final int posB;

  ExchangeCommand(String input) {
    final parts = input.split("/");
    posA = int.parse(parts[0]);
    posB = int.parse(parts[1]);
  }

  @override
  void execute(List<String> programs) {
    _exchange(programs, posA, posB);
  }
}

class PartnerCommand extends Command {
  late final String a;
  late final String b;

  PartnerCommand(String input) {
    final parts = input.split("/");
    a = parts[0];
    b = parts[1];
  }

  @override
  void execute(List<String> programs) {
    _partner(programs, a, b);
  }
}

String solveA(List<String> programs, List<String> danceMoves) {
  _parse(danceMoves).forEach((command) => command.execute(programs));
  return programs.join();
}

String solveB(List<String> programs, List<String> danceMoves, int times) {
  final commands = _parse(danceMoves);
  final history = _findLoopCount(programs, commands);

  return history[times % history.length];
}

List<Command> _parse(List<String> danceMoves) {
  return danceMoves.map((String danceMove) {
    if (danceMove[0] == "s") {
      // Spin
      return SpinCommand(danceMove.substring(1));
    } else if (danceMove[0] == "x") {
      // Exchange
      return ExchangeCommand(danceMove.substring(1));
    } else if (danceMove[0] == "p") {
      // Partner
      return PartnerCommand(danceMove.substring(1));
    } else {
      throw Exception('Should never happen!');
    }
  }).toList(growable: false);
}

List<String> _findLoopCount(List<String> programs, List<Command> commands) {
  final find = programs.join();
  final history = <String>[];
  history.add(find);

  // ignore: literal_only_boolean_expressions
  while (true) {
    for (final command in commands) {
      command.execute(programs);
    }
    final string = programs.join();

    if (string == find) {
      return history;
    } else {
      history.add(string);
    }
  }
}
