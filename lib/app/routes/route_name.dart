abstract class RouteName {
  static const login = '/login';
  static const dashboard = "/dashboard";

  static const editProfile = '/profile/edit';

  static const splashScreen = '/';

  static const onboarding = '/onboarding';

  static const productDetail = '/product/:id';
  static get productDetailById => (id) => '/product/$id';
}
