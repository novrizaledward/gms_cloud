part of 'detail_suratjalan_bloc.dart';

@immutable
abstract class DetailSuratjalanState {}

class DetailSuratjalanInitial extends DetailSuratjalanState {}

class DetailSuratJalanWaiting extends DetailSuratjalanState {
  final String msgWaiting;

  DetailSuratJalanWaiting(this.msgWaiting);
}

class DetailSuratJalanError extends DetailSuratjalanState {
  final String msgError;

  DetailSuratJalanError(this.msgError);
}

class DetailSuratJalanLoaded extends DetailSuratjalanState {
  final ModelDetailSuratJalanRespone? modelDetailSuratJalanRespone;

  DetailSuratJalanLoaded(this.modelDetailSuratJalanRespone);
}
