import 'package:extra/api/api_response.dart';
import 'package:extra/bloc/generic_bloc.dart';
import 'package:extra/service/firebase_service.dart';

class WelcomeBloc extends GenericBloc<bool> {

  final service = FirebaseService();

  Future<ApiResponse> doCreateUser(String email, String password) async {
    return await service.doCreateUser(email, password);

  }

  Future<ApiResponse> doLogin(String email, String password) async {
    return await service.doLogin(email, password);
  }

  Future<ApiResponse> doResetLogin(String email) async {
    return await service.doResetLogin(email);
  }

  Future<ApiResponse> loginGoogle() async {
    return await service.loginGoogle();
  }
}
