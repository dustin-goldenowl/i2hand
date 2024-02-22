enum AppRouteNames {
  home(path: '/'),
  onBoarding(path: '/onBoarding'),
  start(path: '/start'),
  loginEmail(path: '/loginEmail'),
  loginPass(path: '/loginPass'),
  forgotPassword(path: '/forgotPassword'),
  sendMailSuccess(path: '/sendMailSuccess'),
  signUp(path: '/signUp');

  const AppRouteNames({
    required this.path,
    this.param,
  });

  final String path;
  final String? param;

  String get name => path;

  String get subPath {
    if (path == '/') {
      return path;
    }
    return path.replaceFirst('/', '');
  }

  String get buildPathParam => '$path:$param';
  String get buildSubPathParam => '$subPath:$param';
}
