import 'package:bloc/bloc.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/repository/respone/cobaimage.dart';
import 'package:gms_cloud/repository/respone/mdlDetailSuratJalanRespone.dart';
import 'package:meta/meta.dart';

part 'detail_suratjalan_event.dart';
part 'detail_suratjalan_state.dart';

class DetailSuratjalanBloc
    extends Bloc<DetailSuratjalanEvent, DetailSuratjalanState> {
  final ApiProvider apiProvider;
  DetailSuratjalanBloc(this.apiProvider) : super(DetailSuratjalanInitial()) {
    on<DetailSuratJalanAksi>((event, emit) async {
      emit(DetailSuratJalanWaiting('Mohon Tunggu'));
      final data = await apiProvider.detailSuratJalan(event.idSuratJalan);

      if (data?.status == true) {
        emit(DetailSuratJalanLoaded(data));
      } else if (data?.status == null) {
        emit(DetailSuratJalanError('loading gagal'));
      } else {
        emit(DetailSuratJalanWaiting("waitingMsg"));
      }
    });
  }
}
