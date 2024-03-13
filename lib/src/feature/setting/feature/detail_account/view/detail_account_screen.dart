import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/setting/feature/detail_account/logic/detail_account_bloc.dart';
import 'package:i2hand/src/feature/setting/feature/detail_account/logic/detail_account_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/image_handler.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/card/card_item_with_icon.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class DetailAccountScreen extends StatelessWidget {
  const DetailAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: BlocListener<DetailAccountBloc, DetailAccountState>(
        listener: (context, state) {
          switch (state.status) {
            case DetailAccountStatus.loading:
              XToast.showLoading();
              break;
            case DetailAccountStatus.fail:
              XToast.hideLoading();
              XToast.error(S.of(context).someThingWentWrong);
              context.read<DetailAccountBloc>().resetStatus();
              break;
            case DetailAccountStatus.success:
              XToast.hideLoading();
              AppCoordinator.pop();
              context.read<DetailAccountBloc>().resetStatus();
              break;
            default:
              break;
          }
        },
        child: DismissKeyBoard(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderAppBar(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderAvatar(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderInformationSection(context),
                _renderEKYCAccount(context),
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: _renderSaveButton(context),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).setting,
      subTitlePage: S.of(context).yourProfile,
    );
  }

  Widget _renderAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: BlocBuilder<DetailAccountBloc, DetailAccountState>(
        buildWhen: (previous, current) =>
            previous.user.avatar != current.user.avatar,
        builder: (context, state) {
          final isHasAvatar = !isNullOrEmpty(state.user.avatar);
          return XAvatar(
            onEdit: () => ImageHandler.pickImagehandler(
              context,
              image: isHasAvatar
                  ? state.user.avatar!.convertToUint8List()
                  : Uint8List(0),
              setImage: (image) =>
                  context.read<DetailAccountBloc>().changedAvatar(image),
            ),
            imageSize: AppSize.s105,
            isEditable: true,
            imageType: isHasAvatar ? ImageType.memory : ImageType.none,
            memoryData: isHasAvatar
                ? state.user.avatar!.convertToUint8List()
                : Uint8List(0),
          );
        },
      ),
    );
  }

  Widget _renderInformationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          _renderNameField(context),
          _renderMailField(context),
          _renderPhoneField(context),
        ],
      ),
    );
  }

  Widget _renderNameField(BuildContext context) {
    return BlocBuilder<DetailAccountBloc, DetailAccountState>(
      buildWhen: (previous, current) =>
          previous.user.name != current.user.name ||
          previous.errorName != current.errorName,
      builder: (context, state) {
        return XTextField(
          filledColor: AppColors.textFieldBackground,
          errorText: StringUtils.isNullOrEmpty(state.errorName)
              ? null
              : state.errorName,
          initText: state.user.name ?? '',
          hintText: S.of(context).name,
          onChanged: (text) =>
              context.read<DetailAccountBloc>().setUserName(text),
          cursorColor: AppColors.primary,
        );
      },
    );
  }

  Widget _renderMailField(BuildContext context) {
    return BlocBuilder<DetailAccountBloc, DetailAccountState>(
      buildWhen: (previous, current) =>
          previous.user.email != current.user.email,
      builder: (context, state) {
        return XTextField(
          filledColor: AppColors.textFieldBackground,
          initText: state.user.email ?? '',
          hintText: S.of(context).email,
          onChanged: (text) {},
          isEnable: false,
          cursorColor: AppColors.primary,
        );
      },
    );
  }

  Widget _renderPhoneField(BuildContext context) {
    return BlocBuilder<DetailAccountBloc, DetailAccountState>(
      buildWhen: (previous, current) =>
          previous.user.phone != current.user.phone ||
          previous.errorPhone != current.errorPhone,
      builder: (context, state) {
        return XTextField(
          filledColor: AppColors.textFieldBackground,
          errorText: StringUtils.isNullOrEmpty(state.errorPhone)
              ? null
              : state.errorPhone,
          initText: state.user.phone ?? '',
          hintText: S.of(context).phoneLine,
          onChanged: (text) =>
              context.read<DetailAccountBloc>().setUserPhone(text),
          cursorColor: AppColors.primary,
          keyboardType: TextInputType.phone,
        );
      },
    );
  }

  Widget _renderEKYCAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: BlocBuilder<DetailAccountBloc, DetailAccountState>(
        buildWhen: (previous, current) =>
            previous.user.eKYC != current.user.eKYC,
        builder: (context, state) {
          return XCardItemWithIcon(
            text: S.of(context).verifyYourAccount,
            firstItem: true,
            lastItem: true,
            iconPath: state.user.eKYC
                ? Icons.check_circle_rounded
                : Icons.error_rounded,
            backgroundColor: AppColors.backgroundButton,
            iconColor: AppColors.errorColor,
            onTap: () =>
                context.read<DetailAccountBloc>().onTapEKYCAccount(context),
          );
        },
      ),
    );
  }

  Widget _renderSaveButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p16),
        child: BlocSelector<DetailAccountBloc, DetailAccountState, bool>(
          selector: (state) {
            return state.isChanged;
          },
          builder: (context, isChanged) {
            return XFillButton(
              bgColor:
                  isChanged ? AppColors.primary : AppColors.backgroundButton,
              onPressed: () => isChanged
                  ? context.read<DetailAccountBloc>().saveChanges(context)
                  : {},
              label: Text(
                S.of(context).saveChanges,
                style: AppTextStyle.buttonTextStylePrimary,
              ),
            );
          },
        ));
  }
}
