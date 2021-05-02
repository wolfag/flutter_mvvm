class Validation {
  static String validatePassword(String password) {
    if (password == null) {
      return 'Password innvalid';
    }
    if (password.length < 6) {
      return 'Password require minium 6 characters';
    }
    return null;
  }

  static String validateEmail(String email) {
    if (email == null) {
      return 'Email invalid';
    }
    var isValid =
        RegExp(r"[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!isValid) {
      return 'Email invalid';
    }
    return null;
  }
}
