import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide AppInfo;
import 'package:get_it/get_it.dart';
import 'package:i2hand/firebase_options.dart';
import 'package:i2hand/src/config/device/app_infor.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo_impl.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo_impl.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo_impl.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo_impl.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo_impl.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo_impl.dart';
import 'package:i2hand/src/network/data/attribute/attribute_repository.dart';
import 'package:i2hand/src/network/data/attribute/attribute_repository_impl.dart';
import 'package:i2hand/src/network/data/cart/cart_repository.dart';
import 'package:i2hand/src/network/data/cart/cart_repository_impl.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/data/category/category_repository_impl.dart';
import 'package:i2hand/src/network/data/payment_success/order_repo_impl.dart';
import 'package:i2hand/src/network/data/payment_success/order_repository.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/data/product/product_repository_impl.dart';
import 'package:i2hand/src/network/data/sign/sign_repository.dart';
import 'package:i2hand/src/network/data/sign/sign_repository_impl.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository_impl.dart';
import 'package:i2hand/src/network/data/wishlist/wishlist_repository.dart';
import 'package:i2hand/src/network/data/wishlist/wishlist_repository_impl.dart';
import 'package:i2hand/src/router/deep_link.dart';
import 'package:i2hand/src/router/router.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // setup dotenv
  await dotenv.load(fileName: "lib/.env");

  _initStripeKey();

  // catch error
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Future.wait([
    AppInfo.initialize(),
    SharedPrefs.instance.initialize(),
    AppDeepLinks.init(),
  ]);
  _locator();
}

void _initStripeKey() {
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC'] ?? '';
}

void _locator() {
  GetIt.I.registerLazySingleton(() => AppRouter());
  GetIt.I.registerLazySingleton<SignRepository>(() => SignRepositoryImpl());
  GetIt.I.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  GetIt.I.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl());
  GetIt.I
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  GetIt.I.registerLazySingleton<AttributeRepository>(
      () => AttributeRepositoryImpl());
  GetIt.I.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl());
  GetIt.I.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  GetIt.I.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  // Local database
  GetIt.I.registerLazySingleton<DatabaseApp>((() => DatabaseApp()));
  GetIt.I.registerLazySingleton<NewProductsLocalRepo>(
      (() => NewProductsLocalRepoImpl(GetIt.I())));
  GetIt.I.registerLazySingleton<MostViewedProductsLocalRepo>(
      (() => MostViewedProductsLocalRepoImpl(GetIt.I())));
  GetIt.I.registerLazySingleton<WishlistProductsLocalRepo>(
      (() => WishlistProductsLocalRepoImpl(GetIt.I())));
  GetIt.I.registerLazySingleton<ProductsLocalRepo>(
      (() => ProductsLocalRepoImpl(GetIt.I())));
  GetIt.I.registerLazySingleton<OrderLocalRepo>(
      (() => OrderLocalRepoImpl(GetIt.I())));
  GetIt.I.registerLazySingleton<CartLocalRepo>(
      (() => CartLocalRepoImpl(GetIt.I())));
}

void resetSingleton() {
  // Reset repository
  GetIt.I.resetLazySingleton<WishlistRepository>();
  GetIt.I.resetLazySingleton<OrderRepository>();
  GetIt.I.resetLazySingleton<CartRepository>();

  // Reset Table database
  GetIt.I.resetLazySingleton<WishlistProductsLocalRepo>();
  GetIt.I.resetLazySingleton<OrderLocalRepo>();
  GetIt.I.resetLazySingleton<CartLocalRepo>();
}
