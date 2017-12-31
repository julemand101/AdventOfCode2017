// --- Day 16: Permutation Promenade ---
// https://adventofcode.com/2017/day/16

abstract class Command {
  execute(List<String> programs);

  void _spin(List<String> programs, int length) {
    for (int i = 0; i < length; i++) {
      for (int k = programs.length - 1; k != 0; k--) {
        _exchange(programs, k, k - 1);
      }
    }
  }

  void _exchange(List<String> programs, int posA, int posB) {
    String temp = programs[posA];
    programs[posA] = programs[posB];
    programs[posB] = temp;
  }

  void _partner(List<String> programs, String a, String b) {
    int posA = programs.indexOf(a);
    int posB = programs.indexOf(b);
    _exchange(programs, posA, posB);
  }
}

class SpinCommand extends Command {
  int length;

  SpinCommand(String input) {
    this.length = int.parse(input);
  }

  execute(List<String> programs) {
    _spin(programs, length);
  }
}

class ExchangeCommand extends Command {
  int posA;
  int posB;

  ExchangeCommand(String input) {
    var parts = input.split("/");
    this.posA = int.parse(parts[0]);
    this.posB = int.parse(parts[1]);
  }

  execute(List<String> programs) {
    _exchange(programs, posA, posB);
  }
}

class PartnerCommand extends Command {
  String a;
  String b;

  PartnerCommand(String input) {
    var parts = input.split("/");
    this.a = parts[0];
    this.b = parts[1];
  }

  execute(List<String> programs) {
    _partner(programs, a, b);
  }
}

String solveA(List<String> programs, List<String> danceMoves) {
  _parse(danceMoves).forEach((command) => command.execute(programs));
  return programs.join();
}

String solveB(List<String> programs, List<String> danceMoves, int times) {
  List<Command> commands = _parse(danceMoves);
  List<String> history = _findLoopCount(programs, commands);

  return history[times % history.length];
}

List<Command> _parse(List<String> danceMoves) {
  return danceMoves.map((String danceMove) {
    if (danceMove[0] == "s") {
      // Spin
      return new SpinCommand(danceMove.substring(1));
    } else if (danceMove[0] == "x") {
      // Exchange
      return new ExchangeCommand(danceMove.substring(1));
    } else if (danceMove[0] == "p") {
      // Partner
      return new PartnerCommand(danceMove.substring(1));
    }
  }).toList(growable: false);
}

List<String> _findLoopCount(List<String> programs, List<Command> commands) {
  String find = programs.join();
  List<String> history = new List();
  history.add(find);

  while (true) {
    commands.forEach((command) => command.execute(programs));
    String string = programs.join();

    if (string == find) {
      return history;
    } else {
      history.add(string);
    }
  }
}
