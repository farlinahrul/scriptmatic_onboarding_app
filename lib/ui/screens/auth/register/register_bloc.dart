import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/register/register_state.dart';

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController handPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = true;

  void toggleHidePassword() {
    isHidePassword = !isHidePassword;
    emit(RegisterChangeState());
  }

  /*  For Backend Component  */
  void init() {
    emit(RegisterLoaded());
  }
}
