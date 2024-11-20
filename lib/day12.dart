// --- Day 12: Digital Plumber ---
// https://adventofcode.com/2017/day/12

class Program {
  final String name;
  final List<Program> programs = [];

  Program(this.name);

  void addProgram(Program program) {
    programs.add(program);
  }

  int visit(Set<String> history) {
    if (history.contains(name)) {
      return 0;
    }
    history.add(name);
    return programs.fold(1, (count, program) => count + program.visit(history));
  }
}

int solveA(Iterable<String> pipes) {
  return _solve(pipes)['0']!.visit({});
}

int solveB(Iterable<String> pipes) {
  final cache = _solve(pipes);

  int count = 0;
  while (cache.isNotEmpty) {
    final history = <String>{};

    cache[cache.keys.first]!.visit(history);
    for (final name in history) {
      cache.remove(name);
    }

    count++;
  }

  return count;
}

Map<String, Program> _solve(Iterable<String> pipes) {
  final cache = <String, Program>{};

  for (final pipe in pipes) {
    final parts = pipe.split(' <-> ');
    final from = parts[0];
    final tos = parts[1].split(', ');

    final fromProgram = _getProgram(cache, from);

    for (final to in tos) {
      final toProgram = _getProgram(cache, to);
      fromProgram.addProgram(toProgram);
    }
  }

  return cache;
}

Program _getProgram(Map<String, Program> cache, String name) {
  Program program;
  if (!cache.containsKey(name)) {
    program = Program(name);
    cache[name] = program;
  } else {
    program = cache[name]!;
  }
  return program;
}
