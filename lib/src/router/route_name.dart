enum AppRouteNames {
  home(path: '/'),
  adminHome(path: '/adminHome'),
  adminAccount(path: '/adminAccount'),
  adminVerified(path: '/adminVerified'),
  post(path: '/post'),
  cart(path: '/cart'),
  account(path: '/account'),
  wishlist(path: '/wishlist'),
  onBoarding(path: '/onBoarding'),
  start(path: '/start'),
  loginEmail(path: '/loginEmail'),
  loginPass(path: '/loginPass'),
  syncingData(path: '/syncingData'),
  forgotPassword(path: '/forgotPassword'),
  sendMailSuccess(path: '/sendMailSuccess'),
  signUp(path: '/signUp'),
  search(path: '/search'),
  productDetail(path: '/productDetail', param: 'id'),
  selectLocation(path: 'selectLocation', param: 'address');

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
