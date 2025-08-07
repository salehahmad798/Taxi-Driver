import 'package:flutter/material.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}

extension BuildContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  void showSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }
}

extension ColorExtensions on Color {
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final f = 1 - amount;
    return Color.fromARGB(
      alpha,
      (red * f).toInt(),
      (green * f).toInt(),
      (blue * f).toInt(),
    );
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final p = 1 + amount;
    return Color.fromARGB(
      alpha,
      (red * p).clamp(0, 255).toInt(),
      (green * p).clamp(0, 255).toInt(),
      (blue * p).clamp(0, 255).toInt(),
    );
  }
}

extension PaddingExtensions on Widget {
  Widget withPadding({EdgeInsets padding = const EdgeInsets.all(8.0)}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
}

extension IterableExtensions<T> on Iterable<T> {
  String joinToString(String separator) {
    return map((e) => e.toString()).join(separator);
  }
}

extension DateTimeExtensions on DateTime {
  String format({String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return toIso8601String(); //logic here
  }
}