import 'package:bloc/bloc.dart';
import 'package:fic4_flutter_auth/data/localsources/auth_local_storage.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth/data/models/response/login_response_model.dart';

import '../../data/models/request/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource authDatasource;
  LoginBloc(
    this.authDatasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      // ketika success ngapain, ketika error ngapain
      try {
        emit(LoginLoading());
        final result = await authDatasource.login(event.loginModel);
        await AuthLocalStorage().saveToken(result.accessToken);
        emit(LoginLoaded(loginResponseModel: result));
      } catch (e) {
        emit(LoginError(message: 'Network Problem'));
      }
    });
  }
}
