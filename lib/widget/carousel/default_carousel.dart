import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class XCarousel extends StatefulWidget {
  const XCarousel({super.key});

  @override
  State<XCarousel> createState() => _XCarouselState();
}

class _XCarouselState extends State<XCarousel> {
  late CarouselController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              viewportFraction: AppSize.s1,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: AppConstantData.listNotificationBanner,
        ),
        _renderIndicator()
      ],
    );
  }

  Widget _renderIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _currentIndex,
      count: AppConstantData.listNotificationBanner.length,
      effect: const ScaleEffect(
        radius: AppRadius.r8,
        scale: AppSize.s2,
        spacing: AppPadding.p8,
        dotHeight: AppSize.s6,
        dotWidth: AppSize.s6,
        activeDotColor: AppColors.orange,
      ),
    );
  }
}
