import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum DetailAccountStatus { init, loading, success, fail }

class DetailAccountState with EquatableMixin {
  DetailAccountState(
      {required this.user,
      this.status = DetailAccountStatus.init,
      this.isChanged = false,
      this.errorName ='',
      this.errorPhone = '',
    });

  final MUser user;
  final String errorName;
  final String errorPhone;
  final DetailAccountStatus status;
  final bool isChanged;

  DetailAccountState copyWith(
      {MUser? user, DetailAccountStatus? status, bool? isChanged, String? errorName, String? errorPhone}) {
    return DetailAccountState(
      user: user ?? this.user,
      status: status ?? this.status,
      isChanged: isChanged ?? this.isChanged,
      errorName: errorName ?? this.errorName,
      errorPhone: errorPhone ?? this.errorPhone,
    );
  }

  @override
  List<Object?> get props => [user, status, isChanged, errorName, errorPhone];
}
