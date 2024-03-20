import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/wishlist/wishlist_reference.dart';
import 'package:i2hand/src/network/data/wishlist/wishlist_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/utils/utils.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final wishlistProductRef = WishlistReference();

  @override
  Future<MResult<MUserProduct>> getOrAddWishlist(
      MUserProduct wishlistProduct) async {
    return await wishlistProductRef.getOrAddWishlist(wishlistProduct);
  }

  @override
  Future<MResult<List<MUserProduct>>> getWishlistProducts() async {
    try {
      final result = await wishlistProductRef.getWishlistProducts();
      if (isNullOrEmpty(result.data)) return MResult.success([]);
      await _syncWishlistProductToLocal(result.data!);
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> deleteWishlistProduct(
      MUserProduct wishlistProduct) async {
    return await wishlistProductRef.deleteWishlist(wishlistProduct);
  }

  Future<void> _syncWishlistProductToLocal(
      List<MUserProduct> listProducts) async {
    for (MUserProduct product in listProducts) {
      await GetIt.I.get<WishlistProductsLocalRepo>().upsert(
            product.convertToWishlistProductLocalData(),
          );
    }
  }
}
