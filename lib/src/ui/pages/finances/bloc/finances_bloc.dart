import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'finances_event.dart';
part 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  FinancesBloc() : super(const FinancesState()) {
    on<ChangePageEvent>(changePageEvent);
  }

  changePageEvent(ChangePageEvent event, Emitter<FinancesState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
