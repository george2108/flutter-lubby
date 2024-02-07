import '../../../core/resources/data_state.dart';
import '../dto/login_request_dto.dart';
import '../dto/login_response_dto.dart';

abstract class LoginRepositoryAbstract {
  Future<DataState<LoginResponseDTO>> login(LoginRequestDTO data);
}
