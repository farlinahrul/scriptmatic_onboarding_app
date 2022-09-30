import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

import '../../../../data/blocs/credential/register/register_bloc.dart';
import '../../../../data/blocs/credential/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterBloc _bloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = RegisterBloc()..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                        AppImagePaths.imgRegister,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const TextInter(
                        text: "Sign Up",
                        size: 25,
                        fontWeight: Weightenum.bold,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const TextInter(
                        text: "Silahkan memulai dengan membuat akun anda!",
                        size: 16,
                        fontWeight: Weightenum.regular,
                        color: PaletteColor.textGrey,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      FormInputFieldWithIcon(
                        contentPadding: const EdgeInsets.only(top: 14),
                        keyboardType: TextInputType.name,
                        controller: _bloc.nameController,
                        enableBorder: false,
                        iconPrefix: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            AppIconsPaths.user,
                          ),
                        ),
                        labelText: "Nama Lengkap",
                        validator: Validator().name,
                        onTap: () {},
                        onSaved: (value) {},
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormInputFieldWithIcon(
                        contentPadding: const EdgeInsets.only(top: 14),
                        keyboardType: TextInputType.number,
                        controller: _bloc.handPhoneController,
                        enableBorder: false,
                        iconPrefix: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            AppIconsPaths.telephone,
                          ),
                        ),
                        labelText: "No - Telp",
                        validator: Validator().phone,
                        onTap: () {},
                        onSaved: (value) {},
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormInputFieldWithIcon(
                        contentPadding: const EdgeInsets.only(top: 14),
                        keyboardType: TextInputType.emailAddress,
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
                        height: 14,
                      ),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return FormInputFieldWithIcon(
                            contentPadding: const EdgeInsets.only(top: 14),
                            keyboardType: TextInputType.visiblePassword,
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
                        height: 48,
                      ),
                      PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //TODO: action sign up
                          }
                        },
                        title: "Sign Up",
                        borderRadius: 50,
                      ),
                      const SizedBox(
                        height: 32,
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
                            text: "Sudah punya akun?",
                            size: 12,
                            fontWeight: Weightenum.regular,
                            color: PaletteColor.textGrey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              RouteApp.pushReplacement(context, const LoginScreen());
                            },
                            child: const TextInter(
                              text: "Log In.",
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
      ),
    );
  }
}
