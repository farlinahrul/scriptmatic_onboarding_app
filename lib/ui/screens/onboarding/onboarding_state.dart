import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  final int time;

  OnboardingState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class OnBoardingInitial extends OnboardingState {}

class OnBoardingLoading extends OnboardingState {}

class OnBoardingLoaded extends OnboardingState {
  final List<String> listSliderPath, listSliderTitle, listSliderDescription;

  OnBoardingLoaded(
      {required this.listSliderPath,
      required this.listSliderTitle,
      required this.listSliderDescription});
}
