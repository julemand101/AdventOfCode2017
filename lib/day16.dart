// --- Day 16: Permutation Promenade ---
// https://adventofcode.com/2017/day/16

String solveA(List<String> programs, List<String> danceMoves) {
  for (String danceMove in danceMoves) {
    if (danceMove[0] == "s") {
      // Spin
      int length = int.parse(danceMove.substring(1));

      _spin(programs, length);
    } else if (danceMove[0] == "x") {
      // Exchange
      var parts = danceMove.substring(1).split("/");
      int posA = int.parse(parts[0]);
      int posB = int.parse(parts[1]);

      _exchange(programs, posA, posB);
    } else if (danceMove[0] == "p") {
      // Partner
      var parts = danceMove.substring(1).split("/");
      String a = parts[0];
      String b = parts[1];

      _partner(programs, a, b);
    }
  }

  return programs.join();
}

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
