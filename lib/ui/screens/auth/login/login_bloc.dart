import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  bool isHidePassword = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  /*  For Backend Component  */
  void init() {
    emit(LoginLoaded());
  }

  void toggleHidePassword() {
    isHidePassword = !isHidePassword;
    emit(LoginChangeState());
  }
}
