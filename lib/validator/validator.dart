class Validations {
  static String validateName(String value) {
    if (value.isEmpty) return 'Username is Required.';
    final RegExp nameExp = new RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value))
      return 'Alfabetik Karakter Giriniz.';
    return 'Geçerli İsim Yazmadın';
  }

  static String validateEmail(String value, [bool isRequried = true]) {
    if (value.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid email address';
    return 'Geçerli Email Yazmadın';
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 6)
      return 'Please enter a valid password.';
    return 'Geçerli Şifre Yazmadın';
  }

}
