import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/value.dart';

enum ImageType { none, network, assest, file, memory }

class XAvatar extends StatefulWidget {
  final String? url;
  final bool isEditable;
  final Uint8List? memoryData;
  final VoidCallback? onEdit;
  final TextStyle? textStyle;
  final double? borderWidth;
  final double? imageSize;
  final Color? borderColor;
  final bool isShadow;
  const XAvatar({
    Key? key,
    this.url,
    this.isEditable = false,
    this.onEdit,
    this.textStyle,
    this.memoryData,
    this.borderWidth,
    this.imageSize,
    this.borderColor,
    this.isShadow = true,
  }) : super(key: key);

  @override
  State<XAvatar> createState() => _XAvatarState();
}

class _XAvatarState extends State<XAvatar> {
  ImageType _imageType = ImageType.none;

  bool isValidUrl(String? url) {
    if (url?.isEmpty ?? true) {
      return false;
    }
    return true;
  }

  Widget _renderImage(ImageType type) {
    if (widget.memoryData == null) return _renderDefaultImage();
    switch (type) {
      case ImageType.memory:
        return _renderMemoryImage(widget.memoryData ?? Uint8List(0));
      default:
        return _renderDefaultImage();
    }
  }

  Widget _renderDefaultImage() {
    return Container(
        width: widget.imageSize ?? AppSize.s70,
        height: widget.imageSize ?? AppSize.s70,
        decoration: BoxDecoration(
          color: AppColors.subPrimary,
          image: null,
          borderRadius: BorderRadius.all(
            Radius.circular((widget.imageSize ?? AppSize.s70) / 2),
          ),
          border: Border.all(
            color: widget.borderColor ?? Colors.transparent,
            width: widget.borderWidth ?? AppSize.s0,
          ),
          boxShadow: widget.isShadow ? AppDecorations.shadow : [],
        ),
        child: Center(child: Assets.jsons.maleAvatar.lottie()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _renderImage(_imageType),
        widget.isEditable
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p5),
                  decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(AppRadius.r20)),
                  child: IconButton(
                    onPressed: () {
                      widget.onEdit?.call();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      iconColor: MaterialStateProperty.all(AppColors.white),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.white),
                    ),
                    icon: Icon(Icons.edit),
                    color: AppColors.white,
                    alignment: Alignment.topRight,
                    constraints: const BoxConstraints(
                      minWidth: AppSize.s20,
                      minHeight: AppSize.s20,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderMemoryImage(Uint8List memoryData) {
    return Container(
      width: widget.imageSize ?? AppSize.s70,
      height: widget.imageSize ?? AppSize.s70,
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        image: DecorationImage(
          image: MemoryImage(memoryData),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) async {
            await Future.delayed(const Duration(milliseconds: 500));
            if (mounted) {
              setState(() {
                _imageType = ImageType.none;
              });
            }
          },
        ),
        borderRadius: BorderRadius.all(
          Radius.circular((widget.imageSize ?? AppSize.s70) / 2),
        ),
        border: Border.all(
          color: AppColors.primary,
          width: widget.borderWidth ?? AppSize.s4,
        ),
      ),
      child: null,
    );
  }
}
