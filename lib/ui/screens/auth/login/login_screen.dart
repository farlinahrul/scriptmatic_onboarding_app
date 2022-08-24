import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/register/register_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginBloc _bloc = LoginBloc()..init();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/image_login.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    const TextInter(
                      text: "Login Account",
                      size: 25,
                      fontWeight: Weightenum.bold,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const TextInter(
                      text: "Selamat datang kembali, di Scriptmatic",
                      size: 14,
                      fontWeight: Weightenum.regular,
                      color: PaletteColor.textGrey,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    FormInputFieldWithIcon(
                      controller: _bloc.emailController,
                      enableBorder: false,
                      iconPrefix: Image.asset("assets/images/icon_email.png"),
                      labelText: "Email ID",
                      validator: Validator().email,
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return FormInputFieldWithIcon(
                          controller: _bloc.passwordController,
                          maxLines: 1,
                          obscureText: _bloc.isHidePassword,
                          enableBorder: false,
                          iconPrefix:
                              Image.asset("assets/images/icon_password.png"),
                          iconSuffix: GestureDetector(
                            onTap: _bloc.toggleHidePassword,
                            child: _bloc.isHidePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          labelText: "Password",
                          validator: Validator().password,
                          onTap: () {},
                          onSaved: (value) {},
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const TextInter(
                          text: "Lupa Password?",
                          size: 12,
                          fontWeight: Weightenum.medium,
                          color: PaletteColor.primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      title: "Login",
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: PaletteColor.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: TextInter(
                            text: "OR",
                            size: 14,
                            fontWeight: Weightenum.medium,
                            color: PaletteColor.grey,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: PaletteColor.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextInter(
                          text: "Belum punya akun?",
                          size: 12,
                          fontWeight: Weightenum.regular,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            RouteApp.pushReplacement(context, RegisterScreen());
                          },
                          child: const TextInter(
                            text: "Sign Up.",
                            size: 12,
                            fontWeight: Weightenum.regular,
                            color: PaletteColor.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
