import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnboardingState {}

class OnBoardingLoading extends OnboardingState {}

class OnBoardingLoaded extends OnboardingState {
  final List<String> listSliderPath, listSliderTitle, listSliderDescription;

  const OnBoardingLoaded(
      {required this.listSliderPath,
      required this.listSliderTitle,
      required this.listSliderDescription});
}

class OnBoardingChangeSlide extends OnboardingState {}

class OnBoardingSkipSlide extends OnboardingState {}
