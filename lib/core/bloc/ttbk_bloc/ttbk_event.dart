part of 'ttbk_bloc.dart';

@immutable
abstract class TtbkEvent {}

class TtbkAksi extends TtbkEvent {
  final String idSuratJalan;
  final String filePath;
  final List<String> listTtbk;

  TtbkAksi(this.idSuratJalan, this.filePath, this.listTtbk);
}
