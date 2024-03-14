import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/setting/feature/detail_account/logic/detail_account_state.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/src/utils/validated.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailAccountBloc extends BaseCubit<DetailAccountState> {
  DetailAccountBloc(MUser user) : super(DetailAccountState(user: user));

  void resetStatus() {
    emit(state.copyWith(status: DetailAccountStatus.init));
  }

  void _setFailStatus() {
    emit(state.copyWith(status: DetailAccountStatus.fail));
  }

  void _setLoadingStatus() {
    emit(state.copyWith(status: DetailAccountStatus.loading));
  }

  void _setSuccessStatus() {
    emit(state.copyWith(status: DetailAccountStatus.success));
  }

  void changedAvatar(Uint8List image) {
    final user = state.user.copyWith();
    final userAfterChangeAvatar =
        user.copyWith(avatar: image.map((e) => e.toString()).toList());
    emit(state.copyWith(user: userAfterChangeAvatar, isChanged: true));
  }

  void setUserName(String userName) {
    final user = state.user.copyWith();
    final userAfterChangeName = user.copyWith(name: userName);
    emit(state.copyWith(
        user: userAfterChangeName, isChanged: true, errorName: ''));
  }

  void setUserPhone(String userPhone) {
    final user = state.user.copyWith();
    final userAfterChangePhone = user.copyWith(phone: userPhone);
    emit(state.copyWith(
        user: userAfterChangePhone, isChanged: true, errorPhone: ''));
  }

  Future<void> saveChanges(BuildContext context) async {
    if (state.status == DetailAccountStatus.loading) return;
    final userAvatar = !isNullOrEmpty(state.user.avatar)
        ? state.user.avatar!.convertToUint8List()
        : null;
    final user = state.user.copyWith(avatar: []);

    _setLoadingStatus();

    if (_invalidInput(context)) {
      _setFailStatus();
      return;
    }

    try {
      final upsertUserResult =
          await GetIt.I.get<UserRepository>().upsertUser(user);
      final upsertUserAvatar = await GetIt.I
          .get<UserRepository>()
          .addImage(user.id, userAvatar ?? Uint8List(0));
      if (upsertUserResult.data != true || upsertUserAvatar.data != true) {
        _setFailStatus();
        return;
      }
      await _syncToSharedRef(user: user, avatar: userAvatar);
      _setSuccessStatus();
    } catch (e) {
      xLog.e(e);
      _setFailStatus();
    }
  }

  bool _invalidInput(BuildContext context) {
    final errorName =
        AppValidator.emptyFieldValidated(state.user.name, context);
    final errorPhone =
        AppValidator.emptyFieldValidated(state.user.phone, context);
    if (errorPhone != null) emit(state.copyWith(errorPhone: errorPhone));
    if (errorName != null) emit(state.copyWith(errorName: errorName));
    return errorName != null || errorPhone != null;
  }

  Future<void> _syncToSharedRef(
      {required MUser user, Uint8List? avatar}) async {
    await _syncUserData(user);
    _syncUserAvatar(avatar);
  }

  Future<void> _syncUserData(MUser user) async {
    await SharedPrefs.I.setUser(user);
  }

  Future<void> _syncUserAvatar(Uint8List? avatar) async {
    await SharedPrefs.I.setUserAvatar(avatar);
  }

  Future<void> onTapEKYCAccount(BuildContext context) async {
    XToast.showLoading();
    final result = await GetIt.I.get<UserRepository>().eKYCAccount();
    if (StringUtils.isNullOrEmpty(result.data)) return;
    if (!context.mounted) return;
    XToast.hideLoading();
    _showEKYCWeb(context, result.data!);
  }

  Future<void> _showEKYCWeb(BuildContext context, String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
