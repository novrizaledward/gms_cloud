part of 'ttbk_bloc.dart';

@immutable
abstract class TtbkState {}

class TtbkInitial extends TtbkState {}

class TtbkWaiting extends TtbkState {}

class TtbkError extends TtbkState {}

class TtbkLoaded extends TtbkState {
  final ModelTtbkRespone? ttbkModel;

  TtbkLoaded(this.ttbkModel);
}
