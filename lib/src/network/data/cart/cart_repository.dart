import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

abstract class CartRepository {
  Future<MResult<MUserProduct>> getOrAddCartProduct(MUserProduct product);

  Future<MResult<List<MUserProduct>>> getCartProducts();

  Future<MResult<bool>> deleteCartProduct(MUserProduct product);
}
