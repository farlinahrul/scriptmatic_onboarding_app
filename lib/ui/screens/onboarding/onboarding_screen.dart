import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_state.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingBloc _bloc = OnboardingBloc()..fetchData();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _bloc,
            listener: ((context, state) {
              if (state is OnBoardingChangeSlide) {
                print("Change Slide");
              }
              if (state is OnBoardingSkipSlide) {
                print("Skip Slide");
              }
            }),
          ),
        ],
        child: Scaffold(
          body: SafeArea(
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
            buildWhen: (previous, current) => current is OnBoardingLoaded,
            builder: (context, state) {
              if (state is OnBoardingLoaded) {
                List<Widget> listWidgetSlider = [];
                List<Widget> listWidgetIconPagination = [];
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
                            TextInter(
                              align: TextAlign.center,
                              maxLines: 2,
                              text: state.listSliderDescription[i],
                              size: 14,
                              fontWeight: Weightenum.regular,
                              color: PaletteColor.textGrey,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                  listWidgetIconPagination.add(
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
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
                return Column(
                  children: [
                    _skipButton(),
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
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _bloc.currentSlideIndex = index;
                            });
                          }),
                      items: listWidgetSlider,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: listWidgetIconPagination,
                    ),
                    const Expanded(child: SizedBox()),
                    _bloc.isLastIndex()
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: PrimaryButton(
                              title: "Get Started",
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                );
              }
              return Center(child: Text("KOSONG"));
            },
          )),
        ),
      ),
    );
  }

  Widget _skipButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                setState(() {
                  _bloc.skipToLastIndex();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextInter(
                      text: !_bloc.isLastIndex() ? "Skip" : "",
                      size: 12,
                      fontWeight: Weightenum.semiBold,
                      color: PaletteColor.primary,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    !_bloc.isLastIndex()
                        ? Image.asset(
                            'assets/images/arrow_right.png',
                            width: 8,
                            fit: BoxFit.fitWidth,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
