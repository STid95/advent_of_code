import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  List<String> list = await readFile();
  List<int?> listInInt = convertIntoInt(list);
  List<int> topThree = [];

  for (var i = 0; i < list.length; i++) {
    if (listInInt.isNotEmpty) {
      topThree = addAndCompare(listInInt, topThree);
    } else {
      break;
    }
  }
  print(
      "The total calories are ${topThree.sublist(0, 3).reduce((value, element) => value + element)}");
}

Future<List<String>> readFile() async {
  final input =
      await File('inputs/day_one/input.txt').readAsString(encoding: utf8);
  final list = input.split("\n");
  return list;
}

List<int> addAndCompare(List<int?> listInInt, List<int> topThree) {
  int? currentElf = listInInt.length == 1
      ? listInInt.first
      : listInInt
          .sublist(
              0,
              listInInt.indexOf(
                  listInInt.where((element) => element == null).isEmpty
                      ? null
                      : listInInt.firstWhere((element) => element == null)))
          .reduce((value, element) => value! + element!);
  if (listInInt.where((element) => element == null).isNotEmpty) {
    removeFromInitialList(listInInt);
  }
  if (currentElf != null) {
    compareToTopList(topThree, currentElf);
  }
  return topThree;
}

void compareToTopList(List<int> topThree, int currentElf) {
  if (topThree.where((element) => element < currentElf).isNotEmpty ||
      topThree.length < 3) {
    if (topThree.length == 3) {
      topThree.removeAt(topThree.length - 1);
    }
    topThree.add(currentElf);
    topThree.sort((b, a) => a.compareTo(b));
  }
}

void removeFromInitialList(List<int?> listInInt) {
  listInInt.removeRange(
      0,
      listInInt.indexOf(listInInt.firstWhere((element) => element == null)) +
          1);
}

List<int?> convertIntoInt(List<String> list) {
  List<int?> listInInt = list.map((e) {
    if (e == "") {
      return int.tryParse(e);
    } else {
      return int.parse(e);
    }
  }).toList();
  return listInInt;
}
