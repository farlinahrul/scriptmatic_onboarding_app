import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/register/register_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/register/register_state.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final RegisterBloc _bloc = RegisterBloc()..init();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                      "assets/images/image_register.png",
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
                      size: 14,
                      fontWeight: Weightenum.regular,
                      color: PaletteColor.textGrey,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    FormInputFieldWithIcon(
                      keyboardType: TextInputType.name,
                      controller: _bloc.nameController,
                      enableBorder: false,
                      iconPrefix: IconButton(
                        icon: SvgPicture.asset(
                          AppIconsPaths.user,
                          width: 24,
                          height: 24,
                          fit: BoxFit.fitWidth,
                        ),
                        onPressed: () {},
                      ),
                      labelText: "Nama Lengkap",
                      validator: Validator().name,
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormInputFieldWithIcon(
                      keyboardType: TextInputType.number,
                      controller: _bloc.handPhoneController,
                      enableBorder: false,
                      iconPrefix: IconButton(
                        icon: SvgPicture.asset(
                          AppIconsPaths.telephone,
                          width: 24,
                          height: 24,
                          fit: BoxFit.fitWidth,
                        ),
                        onPressed: () {},
                      ),
                      labelText: "No - Telp",
                      validator: Validator().number,
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormInputFieldWithIcon(
                      keyboardType: TextInputType.emailAddress,
                      controller: _bloc.emailController,
                      enableBorder: false,
                      iconPrefix: IconButton(
                        icon: SvgPicture.asset(
                          AppIconsPaths.email,
                          width: 24,
                          height: 24,
                          fit: BoxFit.fitWidth,
                        ),
                        onPressed: () {},
                      ),
                      labelText: "Email ID",
                      validator: Validator().email,
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return FormInputFieldWithIcon(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _bloc.passwordController,
                          maxLines: 1,
                          obscureText: _bloc.isHidePassword,
                          enableBorder: false,
                          iconPrefix: IconButton(
                            icon: SvgPicture.asset(
                              AppIconsPaths.password,
                              width: 24,
                              height: 24,
                              fit: BoxFit.fitWidth,
                            ),
                            onPressed: () {},
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
                      height: 40,
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      title: "Sign Up",
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
                          text: "Sudah punya akun?",
                          size: 12,
                          fontWeight: Weightenum.regular,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            RouteApp.pushReplacement(context, LoginScreen());
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
    );
  }
}
