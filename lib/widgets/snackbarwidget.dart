import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Severity {
  success, info, error
}

Color alertMessageColor(Severity severity, BuildContext context) {
  switch (severity) {
    case Severity.success:
      return Theme.of(context).colorScheme.error;
    case Severity.error:
      return Theme.of(context).colorScheme.error;
    default:
      return Theme.of(context).colorScheme.background;
  }
}


class SnackBarWdiget {
  static SnackBar displaySnackBar(String message, BuildContext context,
      {String? actionMessage, VoidCallback? onClick, Severity severity = Severity.success}) {
    return SnackBar(
      content: Text(
        message,
        // style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      action: (actionMessage != null)
          ? SnackBarAction(
              textColor: Colors.white,
              label: actionMessage,
              onPressed: () {
                return onClick!();
              },
            )
          : null,
      duration: const Duration(seconds: 2),
      backgroundColor: alertMessageColor(severity, context),
    );
  }
}
