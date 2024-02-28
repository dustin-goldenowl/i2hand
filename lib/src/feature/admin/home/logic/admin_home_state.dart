enum AdminHomeStatus { init, loading, success, fail }

class AdminHomeState {
  AdminHomeState({this.status = AdminHomeStatus.init});

  final AdminHomeStatus status;

  AdminHomeState copyWith({AdminHomeStatus? status}) {
    return AdminHomeState(status: status ?? this.status);
  }
}
