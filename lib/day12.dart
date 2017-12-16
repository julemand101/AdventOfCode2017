// --- Day 12: Digital Plumber ---
// https://adventofcode.com/2017/day/12

class Program {
  final String name;
  final List<Program> programs = new List();

  Program(this.name);

  void addProgram(Program program) {
    programs.add(program);
  }

  int visit(Set<String> history) {
    if (history.contains(this.name)) {
      return 0;
    }
    history.add(this.name);
    return programs.fold(1, (count, program) => count + program.visit(history));
  }
}

int solveA(Iterable<String> pipes) {
  return _solve(pipes)["0"].visit(new Set());
}

int solveB(Iterable<String> pipes) {
  Map<String, Program> cache = _solve(pipes);

  int count = 0;
  while (cache.length > 0) {
    Set<String> history = new Set();

    cache[cache.keys.first].visit(history);
    history.forEach((name) => cache.remove(name));

    count++;
  }

  return count;
}

Map<String, Program> _solve(Iterable<String> pipes) {
  Map<String, Program> cache = new Map();

  for (String pipe in pipes) {
    var parts = pipe.split(" <-> ");
    var from = parts[0];
    var tos = parts[1].split(", ");

    Program fromProgram = _getProgram(cache, from);

    for (String to in tos) {
      Program toProgram = _getProgram(cache, to);
      fromProgram.addProgram(toProgram);
    }
  }

  return cache;
}

Program _getProgram(Map<String, Program> cache, String name) {
  Program program;
  if (!cache.containsKey(name)) {
    program = new Program(name);
    cache[name] = program;
  } else {
    program = cache[name];
  }
  return program;
}
