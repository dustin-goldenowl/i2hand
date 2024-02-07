import 'package:flutter/material.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/feature/on_boarding/page/item/i2hand_text.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const XAppName(),
          Expanded(child: _renderPageView()),
          _renderFooter(),
          XPaddingUtils.verticalPadding(height: AppPadding.p12)
        ],
      ),
    ));
  }

  Widget _renderPageView() {
    return PageView.builder(
      controller: _controller,
      itemCount: 2,
      itemBuilder: (context, index) => Container(),
    );
  }

  Widget _renderFooter() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _renderIndicator(),
        _renderNextButton(),
      ],
    );
  }

  Widget _renderIndicator() {
    return SmoothPageIndicator(
      controller: _controller,
      count: 5,
      effect: const ScrollingDotsEffect(
          activeStrokeWidth: AppSize.s20,
          activeDotScale: AppSize.s2,
          maxVisibleDots: 5,
          radius: 8,
          spacing: AppPadding.p8,
          dotHeight: AppSize.s6,
          dotWidth: AppSize.s6,
          activeDotColor: AppColors.primary),
    );
  }

  Widget _renderNextButton() {
    return TextButton(
        onPressed: () {
          _controller.animateToPage((_controller.page! + 1).toInt(),
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        child: Text(
          S.of(context).next.toUpperCase(),
          style: const TextStyle(
              fontSize: AppFontSize.f16,
              color: AppColors.black,
              fontFamily: FontFamily.raleway),
        ));
  }
}
