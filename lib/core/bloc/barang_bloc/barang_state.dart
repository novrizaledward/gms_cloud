part of 'barang_bloc.dart';

@immutable
abstract class BarangState {}

class BarangInitial extends BarangState {}

class BarangWaiting extends BarangState {}

class BarangError extends BarangState {}

class BarangLoaded extends BarangState {
  final ModelBarang? modelBarang;

  BarangLoaded(this.modelBarang);
}
