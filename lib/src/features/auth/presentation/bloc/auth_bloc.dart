import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../data/datasources/local/services/shared_preferences_service.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../data/repositories/login_repository.dart';
import '../../data/repositories/register_repository.dart';
import '../../domain/dto/register_request_dto.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterRepository registerRepository;
  final LoginRepository loginRepository;
  final SharedPreferencesService sharedPreferencesService;

  AuthBloc({
    required this.registerRepository,
    required this.loginRepository,
    required this.sharedPreferencesService,
  }) : super(const AuthInitial()) {
    on<AuthRegisterEvent>(_onRegister);
  }

  _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final response = await registerRepository.register(event.data);

    if (response is DataSuccess) {
      if (response.data?.user != null && response.data?.accessToken != null) {
        sharedPreferencesService.token = response.data?.accessToken ?? '';
        emit(AuthSuccess(
          authenticated: true,
          user: response.data!.user,
        ));
      } else {
        emit(const AuthFailure(message: 'Error'));
      }
    }

    if (response is DataError) {
      emit(AuthFailure(
        message: response.error?.response?.data['message'] ?? 'Error',
      ));
    }
  }
}
