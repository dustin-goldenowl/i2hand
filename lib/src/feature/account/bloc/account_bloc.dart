import 'package:flutter/widgets.dart';
import 'package:i2hand/src/feature/account/bloc/account_state.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class AccountBloc extends BaseCubit<AccountState> {
  AccountBloc() : super(AccountState());

  Future<void> inital(BuildContext context, MUser user) async {
    _getUser(user);
  }

  void _getUser(MUser user) async {
    emit(state.copyWith(account: user));
  }
}
