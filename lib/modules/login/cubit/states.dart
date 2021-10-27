import 'package:shop_app/models/login_model.dart';

abstract class LoginCubitStates {}

class LoginInitState extends LoginCubitStates {}

class LoginLoadingState extends LoginCubitStates {}

class LoginSuccessState extends LoginCubitStates {

 final LoginModel loginModel;

  LoginSuccessState(this.loginModel);


}

class LoginErrorState extends LoginCubitStates {}

class ChangePassVisibility extends LoginCubitStates {}
