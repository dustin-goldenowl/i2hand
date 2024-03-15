import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:i2hand/src/config/enum/picture_options_enum.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/bottomsheet/image_picker_bottom_sheet.dart';
import 'package:i2hand/widget/image/pick_image_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AssetHandler {
  static void pickImagehandler(BuildContext context,
      {Uint8List? image, required Function(Uint8List) setImage}) {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        barrierColor: AppColors.black.withOpacity(0.5),
        context: context,
        builder: (_) => XImagePickerBottomSheet(
            listOptionsEnum: PictureOptionsEnum.values,
            isPhotoExisted: !isNullOrEmpty(image),
            onSelectedValue: (value) async {
              AppCoordinator.pop();
              switch (value as PictureOptionsEnum) {
                case PictureOptionsEnum.takePhoto:
                  try {
                    final image =
                        await PickerAssetsApp.showImage(ImageSource.camera);
                    if (image != null) {
                      if (!context.mounted) return;
                      setImage(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case PictureOptionsEnum.choosePhoto:
                  try {
                    final image =
                        await PickerAssetsApp.showImage(ImageSource.gallery);
                    if (image != null) {
                      if (!context.mounted) return;
                      setImage(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case PictureOptionsEnum.removePhoto:
                  try {
                    setImage(Uint8List(0));
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
              }
            }));
  }

  static double getImageSize(Uint8List image) {
    // Get image size (unit: MBs)
    return image.lengthInBytes / 1000 / 1000;
  }

  static Future<Uint8List> compressImage(Uint8List image) async {
    var rawImage = image;
    while (getImageSize(rawImage) > 2.0) {
      rawImage =
          await FlutterImageCompress.compressWithList(image, quality: 85);
    }
    return rawImage;
  }

  static Future<void> pickVideoHandler(BuildContext context,
      {required Function(Uint8List) setVideoThumbnail, required Function setVideo}) async {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        barrierColor: AppColors.black.withOpacity(0.5),
        context: context,
        builder: (_) => XImagePickerBottomSheet(
            isPhotoExisted: true,
            listOptionsEnum: VideoOptionsEnum.values,
            onSelectedValue: (value) async {
              AppCoordinator.pop();
              switch (value as VideoOptionsEnum) {
                case VideoOptionsEnum.recordVideo:
                  try {
                    final video =
                        await PickerAssetsApp.showVideo(ImageSource.camera);
                    if (video != null) {
                      if (!context.mounted) return;
                      final data = await VideoThumbnail.thumbnailData(
                        video: video.path,
                        imageFormat: ImageFormat.JPEG,
                        maxWidth: 128,
                        quality: 50,
                      );
                      setVideoThumbnail(data ?? Uint8List(0));
                    }
                  } catch (error) {
                    xLog.e("pickVideoHandler $error");
                  }
                  break;
                case VideoOptionsEnum.chooseVideo:
                  try {
                    final video =
                        await PickerAssetsApp.showVideo(ImageSource.gallery);
                    if (video != null) {
                      if (!context.mounted) return;
                      final data = await VideoThumbnail.thumbnailData(
                        video: video.path,
                        imageFormat: ImageFormat.JPEG,
                        maxWidth: 128,
                        quality: 50,
                      );
                      setVideoThumbnail(data ?? Uint8List(0));
                    }
                  } catch (error) {
                    xLog.e("pickVideoHandler $error");
                  }
                  break;
              }
            }));
  }
}
