import '../../../core/resources/data_state.dart';
import '../dto/register_request_dto.dart';
import '../dto/register_response_dto.dart';

abstract class RegisterRepositoryAbstract {
  Future<DataState<RegisterResponseDTO>> register(RegisterRequestDTO data);
}
