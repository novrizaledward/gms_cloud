part of 'suratjalan_bloc.dart';

@immutable
abstract class SuratjalanState {}

class SuratjalanInitial extends SuratjalanState {}

class SuratJalanWaiting extends SuratjalanState {
  final String msgWaiting;

  SuratJalanWaiting(this.msgWaiting);
}

class SuratJalanError extends SuratjalanState {
  final String msgError;

  SuratJalanError(this.msgError);
}

class SuratJalanLoaded extends SuratjalanState {
  final SuratJalanRespone? suratJalanRespone;

  SuratJalanLoaded(this.suratJalanRespone);
}
