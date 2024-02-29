import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/config/enum/account.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/account/bloc/account_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';

class SyncDataScreen extends StatefulWidget {
  const SyncDataScreen({super.key});

  @override
  State<SyncDataScreen> createState() => _SyncDataScreenState();
}

class _SyncDataScreenState extends State<SyncDataScreen> {
  @override
  void initState() {
    super.initState();
    _syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _renderBackground(),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderSyncDataLottie(),
              _renderProgressBar(context),
            ],
          )),
        ],
      ),
    );
  }

  Widget _renderSyncDataLottie() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Assets.jsons.loading.lottie(),
    );
  }

  Widget _renderProgressBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).loadingData,
          style: AppTextStyle.contentTexStyleBold.copyWith(
            fontSize: AppFontSize.f20,
            fontFamily: FontFamily.raleway,
          ),
        ),
      ],
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles1.svg(fit: BoxFit.cover);
  }

  void _syncData() {
    _checkUserToken();
  }

  Future<void> _checkUserToken() async {
    final token = SharedPrefs.I.getToken();
    if (StringUtils.isNullOrEmpty(token)) {
      await Future.delayed(Duration.zero, () {
        AppCoordinator.showStartScreen();
      });
      return;
    }
    try {
      final result = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (result != null && result == token) {
        await _syncDataFromFirebase();
        return;
      }
      if (!context.mounted) return;
      XToast.error(S.of(context).yourSignInIsSInvalid);
      AppCoordinator.showStartScreen();
    } catch (e) {
      xLog.e(e);
      XToast.error(S.of(context).yourSignInIsSInvalid);
      AppCoordinator.showStartScreen();
    }
  }

  Future<void> _syncDataFromFirebase() async {
    await GetIt.I.get<DatabaseApp>().deleteAll();
    await _getListCategories();
    await _getListNewProducts();
    await _syncingUserAvatar();
    await _syncingUserData();
  }

  Future<void> _syncingUserData() async {
    var sharePrefUser = SharedPrefs.I.getUser();
    var sharePrefUserAvatar = SharedPrefs.I.getUserAvatar();
    if (sharePrefUser == null) {
      try {
        sharePrefUser = await GetIt.I<UserRepository>()
            .getUser()
            .then((value) => value.data);
        SharedPrefs.I.setUser(sharePrefUser);
      } catch (e) {
        xLog.e(e);
        sharePrefUser = MUser.empty();
      }
    }
    final userData = sharePrefUser!.copyWith(
        avatar: sharePrefUserAvatar.toList().map((e) => e.toString()).toList());
    if (!context.mounted) return;
    await context.read<AccountBloc>().inital(context, userData);
    if (userData.role == AccountRole.admin) {
      AppCoordinator.showAdminHomeScreen();
      return;
    }
    AppCoordinator.showHomeScreen();
  }

  Future<void> _syncingUserAvatar() async {
    var sharePrefUserAvatar = SharedPrefs.I.getUserAvatar();
    var sharePrefUser = SharedPrefs.I.getUser();
    if (sharePrefUserAvatar.isEmpty) {
      try {
        sharePrefUserAvatar = await GetIt.I<UserRepository>()
            .getImage(sharePrefUser?.id ?? '')
            .then((value) => value.data ?? Uint8List(0));
        SharedPrefs.I.setUserAvatar(sharePrefUserAvatar);
      } catch (e) {
        xLog.e(e);
      }
    }
  }

  Future<void> _getListCategories() async {
    await context.read<GlobalBloc>().getListCategories();
  }

  Future<void> _getListNewProducts() async {
    await GetIt.I.get<ProductRepository>().getProducts();
  }
}
