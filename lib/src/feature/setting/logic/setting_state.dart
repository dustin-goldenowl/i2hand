import 'package:equatable/equatable.dart';

enum SettingScreenStatus { init, loading, failed, succeeded }

class SettingState with EquatableMixin {
  SettingState({this.status = SettingScreenStatus.init});

  final SettingScreenStatus status;

  SettingState copyWith({SettingScreenStatus? status}) {
    return SettingState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];

  @override
  String toString() {
    return 'SettingState{status=$status}';
  }
}
