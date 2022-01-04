import 'package:bloc/bloc.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/repository/respone/modelttbk.dart';
import 'package:meta/meta.dart';

part 'ttbk_event.dart';
part 'ttbk_state.dart';

class TtbkBloc extends Bloc<TtbkEvent, TtbkState> {
  final ApiProvider apiProvider;
  TtbkBloc(this.apiProvider) : super(TtbkInitial()) {
    on<TtbkAksi>((event, emit) async {
      emit(TtbkWaiting());
      final data = await apiProvider.ttbk(
        event.idSuratJalan,
        event.filePath,
        event.listTtbk,
      );

      if (data?.status == true) {
        emit(TtbkLoaded(data));
      } else if (data?.status == null) {
        emit(TtbkError());
      } else {
        emit(TtbkWaiting());
      }
    });
  }
}
