enum AccountRole {
  user,
  admin;

  String getText() {
    switch (this) {
      case AccountRole.admin:
        return 'admin';
      case AccountRole.user:
        return 'user';
    }
  }

  AccountRole getRole(String roleText) {
    switch (roleText) {
      case 'admin':
        return AccountRole.admin;
      case 'user':
      default:
        return AccountRole.user;
    }
  }
}
