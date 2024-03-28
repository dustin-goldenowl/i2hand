import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/cart/cart_reference.dart';
import 'package:i2hand/src/network/data/cart/cart_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/utils/utils.dart';

class CartRepositoryImpl extends CartRepository {
  final cartProductRef = CartReference();

  @override
  Future<MResult<MUserProduct>> getOrAddCartProduct(
      MUserProduct product) async {
    return await cartProductRef.getOrAddCartProduct(product);
  }

  @override
  Future<MResult<List<MUserProduct>>> getCartProducts() async {
    try {
      final result = await cartProductRef.getCartProducts();
      if (isNullOrEmpty(result.data)) return MResult.success([]);
      await _syncCartProductToLocal(result.data!);
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> deleteCartProduct(MUserProduct product) async {
    return await cartProductRef.deleteCartProduct(product);
  }

  Future<void> _syncCartProductToLocal(List<MUserProduct> listProducts) async {
    for (MUserProduct product in listProducts) {
      await GetIt.I.get<CartLocalRepo>().upsert(
            product.convertToCartLocalData(),
          );
    }
  }
}
