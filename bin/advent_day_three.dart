import 'dart:io';

Future<void> main() async {
  int sum = 0;

  List<String> rucksacks = await readFile();
  partOne(sum, rucksacks);
  partTwo(sum, rucksacks);
}

void partTwo(int sum, List<String> rucksacks) {
  int initialList = rucksacks.length;

  for (var i = 0; i < initialList; i++) {
    sum += findItemInGroup(rucksacks.sublist(0, 3));
    rucksacks.removeRange(0, 3);
    if (rucksacks.length < 3) break;
  }
  print('The priorities of badges are $sum');
}

void partOne(int sum, List<String> rucksacks) {
  for (var rucksack in rucksacks) {
    sum += findItemInRucksack(rucksack);
  }
  print('The total priorities are $sum');
}

int findItemInRucksack(String rucksack) {
  int priority = 0;
  int limit = rucksack.length ~/ 2;
  List<String> compartments = [
    rucksack.substring(0, limit),
    rucksack.substring(limit)
  ];
  for (var i = 0; i < compartments.first.length; i++) {
    if (compartments.last.contains(compartments.first[i])) {
      String commonItem = compartments.first[i];
      priority = calculatePriority(commonItem);
      break;
    }
  }
  return priority;
}

int findItemInGroup(List<String> rucksacks) {
  int priority = 0;
  rucksacks.sort((b, a) => a.length.compareTo(b.length));

  for (var i = 0; i < rucksacks.first.length; i++) {
    if (rucksacks.last.contains(rucksacks.first[i]) &&
        rucksacks[1].contains(rucksacks.first[i])) {
      String commonItem = rucksacks.first[i];
      priority = calculatePriority(commonItem);
      break;
    }
  }
  return priority;
}

int calculatePriority(String commonItem) {
  int index = 0;
  bool lowerCase =
      commonItem.compareTo(commonItem.toLowerCase()) == 0 ? true : false;

  if (lowerCase) {
    index = commonItem.codeUnitAt(0) - 96;
  } else {
    index = commonItem.codeUnitAt(0) - 38;
  }
  return index;
}

Future<List<String>> readFile() async {
  final input = await File('inputs/day_three/input.txt').readAsString();
  final list = input.split("\n").map((e) => e.replaceAll(' ', '')).toList();
  list.removeWhere((element) => element == '');
  return list;
}
