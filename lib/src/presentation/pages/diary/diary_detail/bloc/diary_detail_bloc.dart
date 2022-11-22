import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'diary_detail_event.dart';
part 'diary_detail_state.dart';

class DiaryDetailBloc extends Bloc<DiaryDetailEvent, DiaryDetailState> {
  DiaryDetailBloc() : super(DiaryDetailInitial()) {
    on<DiaryDetailEvent>((event, emit) {});
  }
}
