import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_reader_event.dart';
part 'qr_reader_state.dart';

class QrReaderBloc extends Bloc<QrReaderEvent, QrReaderState> {
  QrReaderBloc() : super(QrReaderInitial()) {
    on<QrReaderEvent>((event, emit) {});
  }
}
