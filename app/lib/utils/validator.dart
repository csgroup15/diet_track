import 'package:email_validator/email_validator.dart';

class UserInfoValidator {
  static RegExp passwordCharactersCheck =
      RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)');
  static RegExp phoneNumberCheck = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  //To validate entered password
//  static bool validatePassword(String pass) {
//     String password = pass.trim();
//     if (passwordCharactersCheck.hasMatch(password)) {
//       return true;
//     } else {
//       return false;
//     }
//   }
  static bool validatePhoneNumber(String phone) {
    String phoneNumber = phone.trim();
    if (phoneNumberCheck.hasMatch(phoneNumber)) {
      return true;
    } else {
      return false;
    }
  }

  static bool validateEmail(String email) {
    String userEmail = email.trim();
    bool isvalid = EmailValidator.validate(userEmail);
    return isvalid;
  }
}
