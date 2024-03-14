import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:uni_links/uni_links.dart';

class AppDeepLinks {
  static String _promoId = '';
  static String get promoId => _promoId;
  static bool get hasPromoId => _promoId.isNotEmpty;

  static void reset() => _promoId = '';

  static Future<void> init({checkActualVersion = false}) async {
    // This is used for cases when: APP is not running and the user clicks on a link.
    try {
      final Uri? uri = await getInitialUri();
      _uniLinkHandler(uri: uri);
    } on PlatformException {
      if (kDebugMode) {
        print("(PlatformException) Failed to receive initial uri.");
      }
    } on FormatException catch (error) {
      if (kDebugMode) {
        print(
            "(FormatException) Malformed Initial URI received. Error: $error");
      }
    }

    // This is used for cases when: APP is already running and the user clicks on a link.
    uriLinkStream.listen((Uri? uri) async {
      _uniLinkHandler(uri: uri);
    }, onError: (error) {
      if (kDebugMode) print('UniLinks onUriLink error: $error');
    });
  }

  static Future<void> _uniLinkHandler({required Uri? uri}) async {
    if (uri == null || uri.queryParameters.isEmpty) return;
    Map<String, String> params = uri.queryParameters;

    String isVerified = params['isVerified'] ?? '';
    if (isVerified == 'true') {
      await _verifiedAccountHandler(AppCoordinator.context, true);
    }
  }

  static _verifiedAccountHandler(BuildContext context, bool bool) async {
    final user = SharedPrefs.I.getUser();
    final verifiedUser = user?.copyWith(eKYC: true);
    await SharedPrefs.I.setUser(verifiedUser);
    if (!context.mounted) return;
    context.read<GlobalBloc>().setVerifiedAccount(true);
    await GetIt.I
        .get<UserRepository>()
        .upsertUser(verifiedUser ?? MUser.empty());
  }
}
