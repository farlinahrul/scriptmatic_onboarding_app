import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/auth/login/login_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_state.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingBloc _bloc = OnboardingBloc()..fetchData();

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _bloc,
            listener: ((context, state) {}),
          ),
        ],
        child: Scaffold(
          backgroundColor: PaletteColor.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
            buildWhen: (previous, current) => current is OnBoardingLoaded,
            builder: (context, state) {
              if (state is OnBoardingLoaded) {
                List<Widget> listWidgetSlider = [];

                for (int i = 0; i < state.listSliderPath.length; i++) {
                  listWidgetSlider.add(
                    Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Image.asset(
                              state.listSliderPath[i],
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextInter(
                              align: TextAlign.center,
                              text: state.listSliderTitle[i],
                              size: 25,
                              fontWeight: Weightenum.bold,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 42,
                              ),
                              child: TextInter(
                                align: TextAlign.center,
                                maxLines: 3,
                                text: state.listSliderDescription[i],
                                size: 16,
                                fontWeight: Weightenum.regular,
                                color: PaletteColor.textGrey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return Stack(
                  children: [
                    // header
                    Align(
                      alignment: Alignment.topRight,
                      child: BlocBuilder<OnboardingBloc, OnboardingState>(
                        builder: (_, __) {
                          return _skipButton();
                        },
                      ),
                    ),
                    // body
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider(
                          carouselController: _bloc.sliderController,
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              height: MediaQuery.of(context).size.height / 1.5,
                              viewportFraction: 1.0,
                              aspectRatio: 2.0,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              onPageChanged: (index, _) {
                                _bloc.changeCurrentIndex(index);
                              }),
                          items: listWidgetSlider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<OnboardingBloc, OnboardingState>(
                          buildWhen: (_, current) =>
                              current is OnBoardingChangeSlide,
                          builder: (_, slideState) {
                            List<Widget> listWidgetIconPagination = [];
                            for (int i = 0;
                                i < state.listSliderPath.length;
                                i++) {
                              listWidgetIconPagination.add(
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    shape: _bloc.currentSlideIndex == i
                                        ? BoxShape.rectangle
                                        : BoxShape.circle,
                                    borderRadius: _bloc.currentSlideIndex == i
                                        ? const BorderRadius.all(
                                            Radius.circular(
                                              16,
                                            ),
                                          )
                                        : null,
                                    color: _bloc.currentSlideIndex == i
                                        ? PaletteColor.primary
                                        : PaletteColor.primary20,
                                  ),
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: listWidgetIconPagination,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    // bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<OnboardingBloc, OnboardingState>(
                        buildWhen: (_, current) =>
                            current is OnBoardingChangeSlide,
                        builder: (context, state) {
                          return _bloc.isLastIndex()
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 24),
                                  child: PrimaryButton(
                                    onPressed: () {
                                      RouteApp.pushScreen(
                                          context, LoginScreen());
                                    },
                                    title: "Get Started",
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    )
                  ],
                );
              }
              return const Center(child: Text("KOSONG"));
            },
          )),
        ),
      ),
    );
  }

  Widget _skipButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 10),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              _bloc.skipToLastIndex();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextInter(
                    text: !_bloc.isLastIndex() ? "Skip" : "",
                    size: 14,
                    fontWeight: Weightenum.semiBold,
                    color: PaletteColor.primary,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  // !_bloc.isLastIndex()
                  //     ? Image.asset(
                  //         'assets/images/arrow_right.png',
                  //         width: 8,
                  //         fit: BoxFit.fitWidth,
                  //       )
                  //     : const SizedBox()
                  !_bloc.isLastIndex()
                      ? SvgPicture.asset(
                          AppIconsPaths.skipNext,
                          width: 20,
                          fit: BoxFit.fitWidth,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
