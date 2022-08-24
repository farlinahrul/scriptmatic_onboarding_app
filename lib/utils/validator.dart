class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Email tidak valid";
    else
      return null;
  }

  String? phone(String? value) {
    String pattern =
        r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "No handphone tidak valid";
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Password tidak valid";
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Nama tidak valid";
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Inputan angka tidak valid";
    else
      return null;
  }

  String? notEmpty(String? value) {
    // String pattern = r'^\S+$';
    String pattern = r'^.{1,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Inputan kosong";
    else
      return null;
  }

  String? keyword(String? value) {
    // String pattern = r'^\S+$';
    if (!(value!.length >= 3 || value.length == 0))
      return "Keyword tidak valid";
    else
      return null;
  }
}
