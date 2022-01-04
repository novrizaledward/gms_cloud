import 'package:bloc/bloc.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/repository/respone/modelBarang.dart';
import 'package:meta/meta.dart';

part 'barang_event.dart';
part 'barang_state.dart';

class BarangBloc extends Bloc<BarangEvent, BarangState> {
  final ApiProvider apiProvider;
  BarangBloc(this.apiProvider) : super(BarangInitial()) {
    on<BarangAksi>((event, emit) async {
      emit(BarangWaiting());
      final data = await apiProvider.detailBarang();

      if (data?.status == true) {
        emit(BarangLoaded(data));
      } else if (data?.status == null) {
        emit(BarangError());
      } else {
        emit(BarangWaiting());
      }
    });
  }
}
