import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum ResetPasswordStatus { init, loading, failed, successed }

class ResetPasswordState {
  ResetPasswordState({
    this.status = ResetPasswordStatus.init,
    this.selectedOption = '',
    required this.user,
    this.avatar,
  });

  final ResetPasswordStatus status;
  final String selectedOption;
  final MUser user;
  final Uint8List? avatar;

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? selectedOption,
    MUser? user,
    Uint8List? avatar,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      selectedOption: selectedOption ?? this.selectedOption,
      user: user ?? this.user,
      avatar: avatar ?? this.avatar,
    );
  }
}
