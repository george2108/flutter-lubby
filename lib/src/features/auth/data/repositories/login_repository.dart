import '../../../../core/resources/data_state.dart';
import '../../../../data/repositories/base_http_repository.dart';
import '../../domain/dto/login_request_dto.dart';
import '../../domain/dto/login_response_dto.dart';
import '../../domain/repositories/login_repository_abstract.dart';

class LoginRepository extends BaseHttpRepository
    implements LoginRepositoryAbstract {
  @override
  Future<DataState<LoginResponseDTO>> login(LoginRequestDTO data) {
    throw UnimplementedError();
  }
}
