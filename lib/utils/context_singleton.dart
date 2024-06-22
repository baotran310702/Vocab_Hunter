import 'package:flutter/material.dart';

//Set global context for showDialog
class ContextSingleton {
  ContextSingleton._internal();

  static final ContextSingleton _singleton = ContextSingleton._internal();

  factory ContextSingleton() => _singleton;

  static BuildContext? globalContext;

  BuildContext? get getGlobalContext => globalContext;

  set context(BuildContext? value) => globalContext = value;
}
