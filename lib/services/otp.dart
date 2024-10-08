/*import 'dart:math';
import 'package:flutter_sms/flutter_sms.dart';

class FlutterOtp {
  late int _otp, _minOtpValue, _maxOtpValue; //Generated OTP

  /// This function is used to generate a Random OTP in the range [1000, 9999]
  /// which can be used to send and verify. The [Random.nexInt] function is been
  /// used to do the same.
  ///
  /// UPDATE: OTP can be generated in the range desired by passing min and max
  /// params to sendOTP() function. Otherwise the Range [1000, 9999] is taken as
  /// default.

  void generateOtp([int min = 1000, int max = 9999]) {
    //Generates four digit OTP by default
    _minOtpValue = min;
    _maxOtpValue = max;
    _otp = _minOtpValue + Random().nextInt(_maxOtpValue - _minOtpValue);
  }

  /// This function should be called with [phoneNumber] as a Parameter and
  /// [messageText] as a optional parameter. If [messageText] is not passed it is
  /// taken as 'You OTP is : <Generated OTP>'.
  /// You can also pass [countryCode] (optional) as a parameter to sendtOtp function
  /// Otherwise +91 is taken as default country code (INDIA)

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void sendOtp(String phoneNumber,
      [String? messageText,
      int min = 1000,
      int max = 9999,
      String countryCode = '+91']) {
    //function parameter 'message' is optional.
    generateOtp(min, max);

    String address =
        (countryCode) + phoneNumber; // +1 for USA. Change it according to use.

    /// Use country code as per your requirement.
    /// +1 : USA / Canada
    /// +91: India
    /// +44: UK
    /// For other countries, please refer https://countrycode.org/

    _sendSMS((messageText ?? 'Your OTP is : ') + _otp.toString(), [address]);
  }

  /// This function is used to validate the OTP entered by the user, by comparing
  /// it with the generated value [_otp]. If validates to be true then bool value
  /// true is returned. Else, false is returned.

  bool resultChecker(int enteredOtp) {
    //To validate OTP
    return enteredOtp == _otp;
  }
}
*/