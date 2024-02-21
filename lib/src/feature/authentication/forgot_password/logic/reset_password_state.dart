import 'package:i2hand/src/network/model/user/user.dart';

enum ResetPasswordStatus { init, loading, failed, successed }

class ResetPasswordState {
  ResetPasswordState({
    this.status = ResetPasswordStatus.init,
    this.selectedOption = '',
    required this.user,
  });

  final ResetPasswordStatus status;
  final String selectedOption;
  final MUser user;

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? selectedOption,
    MUser? user,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      selectedOption: selectedOption ?? this.selectedOption,
      user: user ?? this.user,
    );
  }
}
