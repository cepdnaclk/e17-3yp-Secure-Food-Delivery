// ignore: camel_case_extensions
extension extString on String {
  String get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{2,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    if (isEmpty) {
      return 'Name cannot be empty';
    } else if (contains(" ")) {
      if (length >= 4) {
        if (nameRegExp.hasMatch(this)) {
          return "valid";
        } else {
          return 'Please enter a valid name';
        }
      } else {
        return 'Name must be more than 4 characters';
      }
    } else {
      return 'Please enter first name and last name';
    }
  }

  String get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?07[0-9]{8}$");
    if (phoneRegExp.hasMatch(this)) {
      return "valid";
    } else if (isEmpty) {
      return 'Contact number cannot be empty';
    } else {
      return 'Please enter a valid contact number';
    }
  }

  String get isValidOTP {
    final otpRegExp = RegExp(r"^\+?[0-9]{6}$");
    if (otpRegExp.hasMatch(this)) {
      return "valid";
    } else if (isEmpty) {
      return 'OTP cannot be empty';
    } else if (length != 6) {
      return 'OTP should be 6 integers';
    } else {
      return 'Please enter a valid OTP';
    }
  }

  String get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailRegExp.hasMatch(this)) {
      return "valid";
    } else if (isEmpty) {
      return 'Email cannot be empty';
    } else {
      return 'Please enter a valid email';
    }
  }

  String get isValidAddress {
    final addressRegExp = RegExp(r"^[a-zA-Z0-9]+[a-zA-Z0-9/,]+");
    if (addressRegExp.hasMatch(this)) {
      if (length >= 4) {
        return "valid";
      } else {
        return 'Address must be more than 4 characters';
      }
    } else if (isEmpty) {
      return 'Address cannot be empty';
    } else {
      return 'Please enter a valid address';
    }
  }

  String get isValidOrderId {
    final orderRegExp = RegExp(r"^[a-zA-Z0-9]+[a-zA-Z0-9]");
    if (orderRegExp.hasMatch(this)) {
      if (length >= 4) {
        return "valid";
      } else {
        return 'Order ID must be more than 4 characters';
      }
    } else if (isEmpty) {
      return 'Order ID cannot be empty';
    } else {
      return 'Please enter a valid Order ID';
    }
  }

  String get isValidDeviceId {
    final deviceRegExp = RegExp(r"^[a-zA-Z0-9]+[a-zA-Z0-9]");
    if (deviceRegExp.hasMatch(this)) {
      if (length >= 4) {
        return "valid";
      } else {
        return 'Device ID must be more than 4 characters';
      }
    } else if (isEmpty) {
      return 'Device ID cannot be empty';
    } else {
      return 'Please enter a valid Device ID';
    }
  }

  String get isValidPassword {
    final passwordRegExp = RegExp(
        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$');
        r"[A-Za-z0-9,.:;!<>?=@#$%&*()_+/-[]");
    if (passwordRegExp.hasMatch(this)) {
      if (length >= 5) {
        return "valid";
      } else {
        return 'Password must be more than 5 characters';
      }
    } else if (isEmpty) {
      return 'Password cannot be empty';
    } else {
      return 'Please enter a valid Password';
    }
  }
}
