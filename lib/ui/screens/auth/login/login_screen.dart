import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/register/register_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/dashboard_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

import '../../../../data/blocs/credential/login/login_bloc.dart';
import '../../../../data/blocs/credential/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _bloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc()..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: PaletteColor.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImagePaths.imgLogin,
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
                        size: 16,
                        fontWeight: Weightenum.regular,
                        color: PaletteColor.textGrey,
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      FormInputFieldWithIcon(
                        contentPadding: const EdgeInsets.only(top: 14),
                        controller: _bloc.emailController,
                        enableBorder: false,
                        iconPrefix: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            AppIconsPaths.email,
                          ),
                        ),
                        labelText: "Email ID",
                        validator: Validator().email,
                        onTap: () {},
                        onSaved: (value) {},
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return FormInputFieldWithIcon(
                            contentPadding: const EdgeInsets.only(top: 14),
                            controller: _bloc.passwordController,
                            maxLines: 1,
                            obscureText: _bloc.isHidePassword,
                            enableBorder: false,
                            iconPrefix: Padding(
                              padding: const EdgeInsets.all(14),
                              child: SvgPicture.asset(
                                AppIconsPaths.password,
                              ),
                            ),
                            iconSuffix: GestureDetector(
                              onTap: _bloc.toggleHidePassword,
                              child: _bloc.isHidePassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 20,
                                    ),
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
                        height: 64,
                      ),
                      PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            RouteApp.pushScreen(context, const DashboardScreen());
                          }
                        },
                        title: "Login",
                        borderRadius: 50,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: PaletteColor.textGrey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: TextInter(
                              text: "OR",
                              size: 14,
                              fontWeight: Weightenum.medium,
                              color: PaletteColor.textGrey,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: PaletteColor.textGrey,
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
                            color: PaletteColor.textGrey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              RouteApp.pushReplacement(
                                  context, const RegisterScreen());
                            },
                            child: const TextInter(
                              text: "Sign Up.",
                              size: 12,
                              fontWeight: Weightenum.medium,
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
      ),
    );
  }
}
