part of 'detail_suratjalan_bloc.dart';

@immutable
abstract class DetailSuratjalanEvent {}

class DetailSuratJalanAksi extends DetailSuratjalanEvent {
  final String? idSuratJalan;

  DetailSuratJalanAksi(this.idSuratJalan);
}
