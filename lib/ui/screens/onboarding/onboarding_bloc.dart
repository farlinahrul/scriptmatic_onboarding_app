import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_state.dart';

class OnboardingBloc extends Cubit<OnboardingState> {
  OnboardingBloc() : super(OnBoardingInitial());

  final List<String> _listSliderPath = [
    "assets/images/slider_1.png",
    "assets/images/slider_2.png",
    "assets/images/slider_3.png",
  ];

  final List<String> _listSliderTitle = [
    "Pilih Kategori",
    "Masukkan Data Produk",
    "Selesai",
  ];

  final List<String> _listSliderDesctiption = [
    "Pilih salah satu kategori script yang tersedia untuk disesuaikan dengan kebutuhan bisnis Anda.",
    "Generate script follow up Anda dengan mengisi data produk yang dibutuhkan oleh sistem.",
    "Kumpulan Script muncul dan siap untuk digunakan sesuai dengan kebutuhan Anda Saat ini.",
  ];

  int currentSlideIndex = 0;

  CarouselController sliderController = CarouselController();

  /*  For Backend Component  */
  void fetchData() {
    emit(OnBoardingLoading());
    emit(OnBoardingLoaded(
      listSliderPath: _listSliderPath,
      listSliderTitle: _listSliderTitle,
      listSliderDescription: _listSliderDesctiption,
    ));
  }

  bool isLastIndex() {
    if (currentSlideIndex == _listSliderTitle.length - 1) {
      return true;
    }
    return false;
  }

  void changeCurrentIndex(final int index) {
    currentSlideIndex = index;
    emit(OnBoardingChangeSlide());
  }

  void skipToLastIndex() {
    sliderController.animateToPage(_listSliderTitle.length - 1);
  }
}
