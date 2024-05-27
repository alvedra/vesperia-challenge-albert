class Endpoint {
  static const baseUrl = 'http://develop-at.vesperia.id:1091/api/v1';

  static const getUser = '/user';
  static const updateUser = '/user/profile';

  static const getProductList = '/product';
  static get getProductDetail => (id) => '/product/$id';
  static const getRatingList = '/rating';

  static const signIn = '/sign-in';

  static const signOut = '/sign-out';
}
