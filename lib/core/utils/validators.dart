import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email validator
  static final email = EmailValidator(errorText: "Enter a valid email address");

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);

  /// Phone Number Validator
  static final phoneNumber = MultiValidator([
    RequiredValidator(errorText: 'Phone Number is required'),
    MinLengthValidator(10,
        errorText: 'Phone Number must be at least 10 digits long'),
    MaxLengthValidator(10,
        errorText: 'Phone Number must be at least 10 digits long'),
    PatternValidator(r'^[0-9]+$',
        errorText: 'Phone Number must contain only digits'),
  ]);

  // Required Validator with Optional Field Name
  static RequiredValidator requirdWithFieldName(String? fielName) =>
      RequiredValidator(errorText: '${fielName ?? 'Field'} is required');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'Field is required');
}
