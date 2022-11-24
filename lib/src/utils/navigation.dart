import 'package:flutter/material.dart';

abstract class Navigation {
  static push(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static pushModal(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => page,
      ),
    );
  }

  static pushReplacement(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static pushReplacementModal(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => page,
      ),
    );
  }

  static pushAndRemoveUntil(
    BuildContext context,
    Widget page,
    Function predicate,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static pushAndRemoveUntilModal(
    BuildContext context,
    Widget page,
    Function predicate,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => page,
      ),
      (route) => false,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static popUntil(BuildContext context) {
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }
}
