class AppValidator{
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please Enter the email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return "Please Enter a phone number";
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  String? validateUserName(value) {
    if (value!.isEmpty) {
      return "Please Enter the username";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return "Please Enter the Password";
    }
    return null;
  }

  String? isEmptyCheck(value) {
    if (value!.isEmpty) {
      return "Please Fill Details";
    }
    return null;
  }
}