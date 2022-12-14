class ApiSetting{
  static const String _baseUri='http://demo-api.mr-dev.tech/api/';
  static const users= '${_baseUri}users';
  static const login= '${_baseUri}students/auth/login';
  static const register= '${_baseUri}students/auth/register';
  static const forgetPassword= '${_baseUri}students/auth/forget-password';
  static const resetPassword= '${_baseUri}students/auth/reset-password';
  static const images= '${_baseUri}student/images/{id}';
  static const logout= '${_baseUri}students/auth/logout';
}