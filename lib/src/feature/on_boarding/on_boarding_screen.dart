import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/on_boarding/page/first_page.dart';
import 'package:i2hand/src/feature/on_boarding/page/second_page.dart';
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
      child: Stack(
        children: [
          _renderBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: _renderPageView()),
              _renderFooter(),
              XPaddingUtils.verticalPadding(height: AppPadding.p45)
            ],
          ),
        ],
      ),
    ));
  }

  Widget _renderPageView() {
    return PageView.builder(
      controller: _controller,
      itemCount: 2,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const FirstPageOnBoardingScreen();
          case 1:
          default:
            return const SecondPageOnBoardingScreen();
        }
      },
    );
  }

  Widget _renderFooter() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _renderIndicator(),
      ],
    );
  }

  Widget _renderIndicator() {
    return SmoothPageIndicator(
      controller: _controller,
      count: 2,
      effect: const ExpandingDotsEffect(
        radius: 8,
        spacing: AppPadding.p8,
        dotHeight: AppSize.s6,
        dotWidth: AppSize.s6,
        activeDotColor: AppColors.orange,
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.onBoardingBg.svg(fit: BoxFit.fill);
  }
}
