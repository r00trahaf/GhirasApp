import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  bool isValidPassword() => length >= 8 && length <= 15;

  Color toHexa() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ScaffoldStateExtensions on GlobalKey<ScaffoldState> {
  showTosta(BuildContext context, { @required message, isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    try {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
