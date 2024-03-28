import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/locator.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/data/sign/sign_repository.dart';
import 'package:i2hand/src/network/firebase/helper/firebase_helper.dart';
import 'package:i2hand/src/network/model/common/error_code.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/domain_manager.dart';
import 'package:i2hand/src/network/model/social_user/social_user.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/utils/utils.dart';

class SignRepositoryImpl extends SignRepository {
  @override
  Future<MResult<MUser>> connectBEWithGoogle(MSocialUser user) async {
    try {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: user.accessToken, idToken: user.idToken);
      // Once signed in, return the UserCredential
      final UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = result.user;
      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: user.email,
        name: user.fullName,
      );
      final userResult = await DomainManager().user.getOrAddUser(newUser);

      // reset singleton database
      resetSingleton();

      // save sharepref
      SharedPrefs.I.setToken(await result.user?.getIdToken());
      SharedPrefs.I.setUser(userResult.data);

      return MResult.success(userResult.data ?? newUser);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<bool>> forgotPassword(String email) async {
    final result =
        await AuthenticationHelper().sendVerifyCodeThoughEmail(email: email);

    if (result == null) {
      return MResult.success(true);
    } else {
      xLog.e(result);
      return MResult.error(MErrorCode.unknown);
    }
  }

  @override
  Future<MResult> logOut(MUser user) async {
    try {
      await FirebaseAuth.instance.signOut();
      await _logOutHandler();
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> loginWithEmail(
      {required String email, required String password}) async {
    final result =
        await AuthenticationHelper().signIn(email: email, password: password);

    if (result != null) {
      final user = result.user;
      final token = await result.user?.getIdToken();
      final newUser = MUser(
        id: user?.uid ?? '',
        email: email,
        name: user?.displayName,
      );

      final userResult = await DomainManager().user.getOrAddUser(newUser);

      // reset singleton database
      resetSingleton();

      // save sharepref
      SharedPrefs.I.setToken(token);
      SharedPrefs.I.setUser(userResult.data);

      return MResult.success(userResult.data ?? newUser);
    } else {
      return MResult.error(MErrorCode.unknown);
    }
  }

  @override
  Future<MResult<MSocialUser>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final bool isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.signOut();
      }
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      if (googleUser != null && googleAuth != null) {
        return MResult.success(
            MSocialUser.fromGoogleAccount(googleUser, googleAuth));
      } else {
        return MResult.error(MErrorCode.unknown);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult> removeAccount(MUser account) async {
    try {
      final user = AuthenticationHelper().user;
      user?.delete();
      await _logOutHandler();
      await _clearAccountsProduct(account.id);
      return MResult.success(account);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> signUpWithEmail(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    final result =
        await AuthenticationHelper().signUp(email: email, password: password);

    if (result != null) {
      final user = result.user;
      final token = await result.user?.getIdToken();
      final newUser = MUser(
        id: user?.uid ?? '',
        email: email,
        name: name,
        phone: phone,
      );

      // reset singleton database
      resetSingleton();

      // save sharepref
      SharedPrefs.I.setUser(newUser);
      SharedPrefs.I.setToken(token);

      final userResult = await DomainManager().user.getOrAddUser(newUser);
      return MResult.success(userResult.data ?? newUser);
    } else {
      return MResult.error(MErrorCode.unknown);
    }
  }

  Future<void> _logOutHandler() async {
    // reset singleton database
    resetSingleton();
    // Clear user table database : Cart table, Wishlist table, Order table
    await GetIt.I.get<DatabaseApp>().clearUserDatabase();
    // Clear shared preference: AccountToken, User, UserAvatar
    await SharedPrefs.I.clearSharedPref();
  }

  Future<void> _clearAccountsProduct(String userId) async {
    final productsOwner = await GetIt.I
        .get<ProductsLocalRepo>()
        .getDetailByOwnerId(userId: userId)
        .get();
    for (ProductsEntityData product in productsOwner) {
      await GetIt.I
          .get<ProductRepository>()
          .deleteProduct([product].convertToProductData().first);
    }
  }
}
