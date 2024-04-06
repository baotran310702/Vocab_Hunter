part of 'global_bloc.dart';

abstract class GlobalEvent {}

class GlobalInitialEvent extends GlobalEvent {}

class ChangeFlashCardSide extends GlobalEvent {}

class ResetFlashCardSide extends GlobalEvent {}
