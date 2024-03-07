import 'package:i2hand/src/feature/add_product/logic/add_product_state.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class AddProductBloc extends BaseCubit<AddProductState> {
  AddProductBloc()
      : super(AddProductState(selectedCategory: MCategory.empty()));

}
