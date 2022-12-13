import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final list = await readFile();
  int operlaping = 0;

  partOne(list, operlaping);
  partTwo(list, operlaping);
}

void partOne(List<List<String>?> list, int operlaping) {
  for (var pairs in list) {
    if (findRange(pairs!, true)) operlaping++;
  }
  print("There are $operlaping fully overlaping pairs");
}

void partTwo(List<List<String>?> list, int operlaping) {
  for (var pairs in list) {
    if (findRange(pairs!, false)) operlaping++;
  }
  print("There are $operlaping overlaping pairs");
}

bool findRange(List<String> list, bool partOne) {
  final pairs =
      list.map((e) => e.split('-').map((e) => int.parse(e)).toList()).toList();
  if (partOne) {
    return fullOverlap(pairs);
  } else {
    return overlap(pairs);
  }
}

bool fullOverlap(List<List<int>> pairs) {
  for (var pair in pairs) {
    final otherPair = pairs.indexOf(pair) == 0 ? 1 : 0;
    if ((pair.first >= pairs[otherPair].first &&
            pair.first <= pairs[otherPair].last) &&
        pair.last >= pairs[otherPair].first &&
        pair.last <= pairs[otherPair].last) {
      return true;
    }
  }
  return false;
}

bool overlap(List<List<int>> pairs) {
  for (var pair in pairs) {
    final otherPair = pairs.indexOf(pair) == 0 ? 1 : 0;
    if ((pair.first >= pairs[otherPair].first &&
            pair.first <= pairs[otherPair].last) ||
        pair.last >= pairs[otherPair].first &&
            pair.last <= pairs[otherPair].last) {
      return true;
    }
  }
  return false;
}

Future<List<List<String>?>> readFile() async {
  final input =
      await File('inputs/day_four/input.txt').readAsString(encoding: utf8);
  final list = input.split("\n");
  list.removeWhere((element) => element == '');

  return list.map((e) {
    return e.split(',');
  }).toList();
}
