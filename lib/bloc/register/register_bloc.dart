// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth/data/datasources/api_datasources.dart';
import 'package:fic4_flutter_auth/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth/data/models/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await datasource.register(event.request);
      emit(RegisterLoaded(model: result));
      print("RESULT : $result");
    });
  }
}
