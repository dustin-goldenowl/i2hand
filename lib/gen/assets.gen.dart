/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ecommerce_shop.png
  AssetGenImage get ecommerceShop =>
      const AssetGenImage('assets/images/ecommerce_shop.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/shopping_cart_3d.png
  AssetGenImage get shoppingCart3d =>
      const AssetGenImage('assets/images/shopping_cart_3d.png');

  /// File path: assets/images/splash_logo.png
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/splash_logo.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [ecommerceShop, logo, shoppingCart3d, splashLogo];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/air_pod.svg
  SvgGenImage get airPod => const SvgGenImage('assets/svg/air_pod.svg');

  /// File path: assets/svg/devices.svg
  SvgGenImage get devices => const SvgGenImage('assets/svg/devices.svg');

  /// File path: assets/svg/headphone.svg
  SvgGenImage get headphone => const SvgGenImage('assets/svg/headphone.svg');

  /// File path: assets/svg/laptop.svg
  SvgGenImage get laptop => const SvgGenImage('assets/svg/laptop.svg');

  /// File path: assets/svg/on_boarding_bg.svg
  SvgGenImage get onBoardingBg =>
      const SvgGenImage('assets/svg/on_boarding_bg.svg');

  /// File path: assets/svg/onboarding_illustration.svg
  SvgGenImage get onboardingIllustration =>
      const SvgGenImage('assets/svg/onboarding_illustration.svg');

  /// File path: assets/svg/remote.svg
  SvgGenImage get remote => const SvgGenImage('assets/svg/remote.svg');

  /// File path: assets/svg/speaker.svg
  SvgGenImage get speaker => const SvgGenImage('assets/svg/speaker.svg');

  /// File path: assets/svg/switch_device.svg
  SvgGenImage get switchDevice =>
      const SvgGenImage('assets/svg/switch_device.svg');

  /// File path: assets/svg/thunder_sale.svg
  SvgGenImage get thunderSale =>
      const SvgGenImage('assets/svg/thunder_sale.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        airPod,
        devices,
        headphone,
        laptop,
        onBoardingBg,
        onboardingIllustration,
        remote,
        speaker,
        switchDevice,
        thunderSale
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
