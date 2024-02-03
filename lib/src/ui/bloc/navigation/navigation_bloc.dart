import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, String> {
  NavigationBloc() : super('Passwords') {
    on<ChangeNavigationEvent>((event, emit) {
      emit(event.item);
    });
  }
}
