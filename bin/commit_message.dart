import 'dart:io';

dynamic main() {
  final rootDir = Directory.current;
  final commitFile = File("${rootDir.path}/.git/COMMIT_EDITMSG");
  final commitMessage = commitFile.readAsStringSync();

  final regExp = RegExp(
    r'(fix|feat|wip|none|chore|refactor|docs|style|test)\(\w+\):\s?(\[\DEV-\d+])?.+',
  );

  final valid = regExp.hasMatch(commitMessage);
  if (!valid) exitCode = 1;
}
