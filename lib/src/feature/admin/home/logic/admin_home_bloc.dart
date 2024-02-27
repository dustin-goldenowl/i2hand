import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/options.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_state.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/bottomsheet/modal_bottomsheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AdminHomeBloc extends Cubit<AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeState());

  void onTappedCategoryButton(BuildContext context,
      {required MCategory category}) {
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (context) => XOptionsBottomSheet(
        listOptions: AppConstantData.categorysOptions,
      ),
      barrierColor: Colors.transparent.withOpacity(0.5),
      enableDrag: false,
    ).then((valueCallback) {
      if (isNullOrEmpty(valueCallback) ||
          valueCallback.runtimeType != OptionsEnum) return;
      _onChangedCategory(context, option: valueCallback, category: category);
    });
  }

  void _onChangedCategory(BuildContext context,
      {required OptionsEnum option, required MCategory category}) {
    switch (option) {
      case OptionsEnum.edit:
        // _editCategoryBottomSheet(valueCallback);
        break;
      case OptionsEnum.remove:
        _removeCategory(context, category);
        break;
      default:
        break;
    }
  }

  Future<void> _removeCategory(BuildContext context, MCategory category) async {
    try {
      emit(state.copyWith(status: AdminHomeStatus.loading));
      final result =
          await GetIt.I.get<CategoryRepository>().deleteCategory(category);
      if (result.data == true) {
        if (!context.mounted) return;
        final listCategories = context.read<GlobalBloc>().state.listCategories;
        listCategories.removeWhere((element) => element.name == category.name);
        context.read<GlobalBloc>().updateListCategories(listCategories);
        emit(state.copyWith(status: AdminHomeStatus.success));
        return;
      }
      emit(state.copyWith(status: AdminHomeStatus.fail));
    } catch (e) {
      emit(state.copyWith(status: AdminHomeStatus.fail));
      xLog.e(e);
    }
  }
}
