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
import 'package:lottie/lottie.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/devices.png
  AssetGenImage get devices => const AssetGenImage('assets/images/devices.png');

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

  /// File path: assets/images/thunder_sale.png
  AssetGenImage get thunderSale =>
      const AssetGenImage('assets/images/thunder_sale.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [devices, ecommerceShop, logo, shoppingCart3d, splashLogo, thunderSale];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/account.json
  LottieGenImage get account =>
      const LottieGenImage('assets/jsons/account.json');

  /// File path: assets/jsons/cart.json
  LottieGenImage get cart => const LottieGenImage('assets/jsons/cart.json');

  /// File path: assets/jsons/female-avatar.json
  LottieGenImage get femaleAvatar =>
      const LottieGenImage('assets/jsons/female-avatar.json');

  /// File path: assets/jsons/home.json
  LottieGenImage get home => const LottieGenImage('assets/jsons/home.json');

  /// File path: assets/jsons/loading.json
  LottieGenImage get loading =>
      const LottieGenImage('assets/jsons/loading.json');

  /// File path: assets/jsons/male-avatar.json
  LottieGenImage get maleAvatar =>
      const LottieGenImage('assets/jsons/male-avatar.json');

  /// File path: assets/jsons/post.json
  LottieGenImage get post => const LottieGenImage('assets/jsons/post.json');

  /// File path: assets/jsons/product.json
  LottieGenImage get product =>
      const LottieGenImage('assets/jsons/product.json');

  /// List of all assets
  List<LottieGenImage> get values =>
      [account, cart, femaleAvatar, home, loading, maleAvatar, post, product];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/account.svg
  SvgGenImage get account => const SvgGenImage('assets/svg/account.svg');

  /// File path: assets/svg/bubbles_1.svg
  SvgGenImage get bubbles1 => const SvgGenImage('assets/svg/bubbles_1.svg');

  /// File path: assets/svg/bubbles_2.svg
  SvgGenImage get bubbles2 => const SvgGenImage('assets/svg/bubbles_2.svg');

  /// File path: assets/svg/bubbles_3.svg
  SvgGenImage get bubbles3 => const SvgGenImage('assets/svg/bubbles_3.svg');

  /// File path: assets/svg/bubbles_4.svg
  SvgGenImage get bubbles4 => const SvgGenImage('assets/svg/bubbles_4.svg');

  /// File path: assets/svg/cart.svg
  SvgGenImage get cart => const SvgGenImage('assets/svg/cart.svg');

  /// File path: assets/svg/devices.svg
  SvgGenImage get devices => const SvgGenImage('assets/svg/devices.svg');

  /// File path: assets/svg/edit.svg
  SvgGenImage get edit => const SvgGenImage('assets/svg/edit.svg');

  /// File path: assets/svg/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svg/google.svg');

  /// File path: assets/svg/home.svg
  SvgGenImage get home => const SvgGenImage('assets/svg/home.svg');

  /// File path: assets/svg/on_boarding_bg.svg
  SvgGenImage get onBoardingBg =>
      const SvgGenImage('assets/svg/on_boarding_bg.svg');

  /// File path: assets/svg/onboarding_illustration.svg
  SvgGenImage get onboardingIllustration =>
      const SvgGenImage('assets/svg/onboarding_illustration.svg');

  /// File path: assets/svg/post.svg
  SvgGenImage get post => const SvgGenImage('assets/svg/post.svg');

  /// File path: assets/svg/product.svg
  SvgGenImage get product => const SvgGenImage('assets/svg/product.svg');

  /// File path: assets/svg/thunder_sale.svg
  SvgGenImage get thunderSale =>
      const SvgGenImage('assets/svg/thunder_sale.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        account,
        bubbles1,
        bubbles2,
        bubbles3,
        bubbles4,
        cart,
        devices,
        edit,
        google,
        home,
        onBoardingBg,
        onboardingIllustration,
        post,
        product,
        thunderSale
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
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

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
