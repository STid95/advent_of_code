import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  List<String> list = await readFile();
  print("We have ${countVisibleTrees(list)} visible trees");
}

int countVisibleTrees(List<String> list) {
  int visibleTrees = list.first.length + list.last.length;
  int higherScore = 0;

  for (var row = 1; row < list.length - 1; row++) {
    String currentRow = list[row];
    visibleTrees += 2;
    for (var tree = 1; tree < currentRow.length - 1; tree++) {
      int scenicScore = 0;

      int height = int.parse(currentRow[tree]);
      if (checkRight(tree, height, currentRow).keys.first == true ||
          checkLeft(tree, height, currentRow).keys.first == true ||
          checkTop(tree, height, row, list).keys.first == true ||
          checkBottom(tree, height, row, list).keys.first == true) {
        visibleTrees++;
      }
      scenicScore = checkLeft(tree, height, currentRow).values.first *
          checkRight(tree, height, currentRow).values.first *
          checkBottom(tree, height, row, list).values.first *
          checkBottom(tree, height, row, list).values.first;
      if (scenicScore > higherScore) higherScore = scenicScore;
    }
  }
  print("The higher score is $higherScore");
  return visibleTrees;
}

Map<bool, int> checkLeft(int tree, int height, String currentRow) {
  bool leftVisible = true;
  int treesSeen = 0;
  for (var leftTree = tree - 1; leftTree > -1; leftTree--) {
    treesSeen++;

    int left = int.parse(currentRow[leftTree]);
    if (height.compareTo(left) != 1) {
      leftVisible = false;
      break;
    }
  }

  return {leftVisible: treesSeen};
}

Map<bool, int> checkRight(
  int tree,
  int height,
  String currentRow,
) {
  bool rightVisible = true;
  int treesSeen = 0;

  for (var leftTree = tree + 1; leftTree < currentRow.length; leftTree++) {
    treesSeen++;

    int right = int.parse(currentRow[leftTree]);

    if (height.compareTo(right) != 1) {
      rightVisible = false;
      break;
    }
  }
  return {rightVisible: treesSeen};
}

Map<bool, int> checkBottom(int column, int height, int row, List<String> map) {
  bool bottomVisible = true;
  int treesSeen = 0;
  for (var bottomRow = row + 1; bottomRow < map.length; bottomRow++) {
    treesSeen++;

    int bottom = int.parse(map[bottomRow][column]);
    if (height.compareTo(bottom) != 1) {
      bottomVisible = false;
      break;
    }
  }

  return {bottomVisible: treesSeen};
}

Map<bool, int> checkTop(int column, int height, int row, List<String> map) {
  bool topVisible = true;
  int treesSeen = 0;

  for (var topRow = row - 1; topRow > -1; topRow--) {
    treesSeen++;

    int top = int.parse(map[topRow][column]);
    if (height.compareTo(top) != 1) {
      topVisible = false;
      break;
    }
  }

  return {topVisible: treesSeen};
}

Future<List<String>> readFile() async {
  final input =
      await File('inputs/day_eight/example.txt').readAsString(encoding: utf8);
  final list = input.split("\n");
  list.removeWhere((element) => element == '');
  return list;
}
