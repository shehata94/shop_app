import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterCubitStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  LoginModel loginModel;
  void userRegister(String name, String email,String phone, String password) {
    emit(RegisterLoadingState());

    DioHelper.postData(path: 'register', lang: 'en', data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState());
    });
  }

  IconData suffix = Icons.visibility;
  bool isPass = true;
  void changePassVisibility() {
    isPass = !isPass;

    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(RegisterChangePassVisibility());
  }
}
