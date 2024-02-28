import 'package:flutter/material.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/carousel/default_carousel.dart';
import 'package:i2hand/widget/text_field/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DismissKeyBoard(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderAppBar(),
              _renderNotificationBanner(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return XAppBar(
        titlePage: S.of(context).i2hand,
        actions: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: XSearchInput(
                onChanged: (searchText) {},
                bgColor: AppColors.grey8,
                suffix: const Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: AppSize.s24,
                      color: AppColors.blue,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r30),
                  borderSide: const BorderSide(
                      width: AppSize.s0, color: Colors.transparent),
                ),
                focusBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r30),
                  borderSide: const BorderSide(
                      width: AppSize.s0, color: Colors.transparent),
                ),
              ),
            )
          ],
        ));
  }

  Widget _renderNotificationBanner(BuildContext context) {
    return const XCarousel();
  }
}
