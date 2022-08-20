part of 'qr_reader_bloc.dart';

abstract class QrReaderState extends Equatable {
  const QrReaderState();
  
  @override
  List<Object> get props => [];
}

class QrReaderInitial extends QrReaderState {}
