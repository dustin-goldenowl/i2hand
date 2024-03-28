import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/recently_viewed/recently_viewed.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/icon_button.dart';

class XRecentlyViewedProductSection extends StatelessWidget {
  const XRecentlyViewedProductSection(
      {super.key, required this.listRecentlyVieweds});

  final List<MRecentlyViewedProduct> listRecentlyVieweds;

  @override
  Widget build(BuildContext context) {
    return _renderRecentlyViewed(context);
  }

  Widget _renderRecentlyViewed(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTitle(title: S.of(context).recentlyViewed),
          XPaddingUtils.verticalPadding(height: AppPadding.p12),
          _renderListRecentlyViewed(context),
        ],
      ),
    );
  }

  Widget _renderTitle({required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.titleTextStyle.copyWith(
            fontSize: AppFontSize.f21,
          ),
        ),
        XIconButton(
          bgColor: AppColors.primary,
          icon: Icons.arrow_forward,
          iconColor: AppColors.white,
          iconSize: AppSize.s20,
          onPressed: () => AppCoordinator.showRecentlyViewed(),
        )
      ],
    );
  }

  Widget _renderListRecentlyViewed(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getListRecently(),
      ),
    );
  }

  List<Widget> _getListRecently() {
    List<Widget> listRecently = [];
    for (MRecentlyViewedProduct product in listRecentlyVieweds) {
      listRecently.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
          child: GestureDetector(
            onTap: () => AppCoordinator.showProductDetailScreen(id: product.id),
            child: XAvatar(
              imageSize: AppSize.s50,
              borderColor: AppColors.white,
              imageType:
                  (product.image.isEmpty) ? ImageType.none : ImageType.memory,
              memoryData: (product.image.isEmpty)
                  ? null
                  : product.image.convertToUint8List(),
            ),
          ),
        ),
      );
    }
    if (listRecently.length > 5) return listRecently.sublist(0, 5);
    return listRecently;
  }
}
