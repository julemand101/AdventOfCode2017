// --- Day 4: High-Entropy Passphrases ---
// https://adventofcode.com/2017/day/4

int solveA(List<String> passphrases) {
  return passphrases
      .where((line) => line.trim().isNotEmpty)
      .where(_containsNoDuplicatedWords)
      .length;
}

bool _containsNoDuplicatedWords(String passphrase) {
  Set<String> set = new Set();

  for (String word in passphrase.split(" ")) {
    if (set.contains(word)) {
      return false;
    } else {
      set.add(word);
    }
  }

  return true;
}
