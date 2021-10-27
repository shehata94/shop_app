import 'package:shop_app/models/login_model.dart';

abstract class RegisterCubitStates {}

class RegisterInitState extends RegisterCubitStates {}

class RegisterLoadingState extends RegisterCubitStates {}

class RegisterSuccessState extends RegisterCubitStates {

 final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);


}

class RegisterErrorState extends RegisterCubitStates {}

class RegisterChangePassVisibility extends RegisterCubitStates {}
