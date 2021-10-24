import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginCubitStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPass = true;

  void userLogin(String email, String password) {
    emit(LoginLoadingState());

    DioHelper.postData(path: Login, lang: 'en', data: {
      'email': email,
      'password': password,
    }).then((value) {
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error);
      emit(LoginErrorState());
    });
  }

  void changePassVisibility() {
    isPass = !isPass;

    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(ChangePassVisibility());
  }
}
