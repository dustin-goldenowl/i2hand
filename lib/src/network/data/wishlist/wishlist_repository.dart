import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

abstract class WishlistRepository {
  Future<MResult<MUserProduct>> getOrAddWishlist(MUserProduct wishlistProduct);

  Future<MResult<List<MUserProduct>>> getWishlistProducts();

  Future<MResult<bool>> deleteWishlistProduct(MUserProduct wishlistProduct);
}
