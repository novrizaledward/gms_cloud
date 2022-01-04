import 'package:bloc/bloc.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/repository/respone/mdlSuratJalanRespone.dart';
import 'package:meta/meta.dart';

part 'suratjalan_event.dart';
part 'suratjalan_state.dart';

class SuratjalanBloc extends Bloc<SuratjalanEvent, SuratjalanState> {
  final ApiProvider apiProvider;
  SuratjalanBloc(this.apiProvider) : super(SuratjalanInitial()) {
    on<SuratJalanAksi>((event, emit) async {
      emit(SuratJalanWaiting("waitingMsg"));
      final data = await apiProvider.suratJalan();

      if (data?.status == true) {
        emit(SuratJalanLoaded(data));
      } else if (data?.status == null) {
        emit(SuratJalanError('loading gagal'));
      } else {
        emit(SuratJalanWaiting("waitingMsg"));
      }
    });
  }
}
