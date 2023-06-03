// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import 'package:fic4_flutter_auth/data/datasources/auth_datasources.dart';
// import 'package:fic4_flutter_auth/data/models/response/login_response_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../data/models/request/login_model.dart';
// import 'package:http/http.dart' as http;
// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthDatasource authDatasource;
//   LoginBloc(
//     this.authDatasource,
//   ) : super(LoginInitial()) {
//     on<DoLoginEvent>((event, emit) async {
//       // ketika success ngapain, ketika error ngapain
//       emit(LoginLoading());
//       try {
//         final result = await authDatasource.login(event.loginModel);
//         print('result: $result');

//         saveTokenToSharedPreferences(result.getAccessToken);
//         emit(LoginLoaded(loginResponseModel: result));
//       } catch (error) {
//         if (error is http.Response) {
//           if (error.statusCode == 401) {
//             emit(LoginError(
//                 message: 'Unauthorized. Please check your credentials'));
//           } else {
//             LoginError(message: 'Failed to login, please try again');
//           }
//         } else {
//           LoginError(message: 'Failed to login, please try again');
//         }
//       }
//     });
//   }

//   void saveTokenToSharedPreferences(String token) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('token', token);
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_datasources.dart';
import '../../data/models/request/login_model.dart';
// import '../../data/models/responses/login_response.dart';
import 'package:http/http.dart' as http;

import '../../data/models/response/login_response_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource datasource;
  LoginBloc(
    this.datasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await datasource.login(event.loginModel);
        print('result: $result');

        saveTokenToSharedPreferences(result.getAccessToken);
        emit(LoginLoaded(loginResponseModel: result));
      } catch (error) {
        if (error is http.Response) {
          if (error.statusCode == 401) {
            emit(LoginError(
                message: 'Unauthorized. Please check your credentials.'));
          } else {
            emit(LoginError(message: 'Failed to login. Please try again.'));
          }
        } else {
          emit(LoginError(message: 'Failed to login. Please try again.'));
        }
      }
    });
  }

  void saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
