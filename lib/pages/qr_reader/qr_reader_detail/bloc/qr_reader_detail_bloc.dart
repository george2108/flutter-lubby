import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_reader_detail_event.dart';
part 'qr_reader_detail_state.dart';

class QrReaderDetailBloc extends Bloc<QrReaderDetailEvent, QrReaderDetailState> {
  QrReaderDetailBloc() : super(QrReaderDetailInitial()) {
    on<QrReaderDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
