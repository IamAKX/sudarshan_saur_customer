class Api {
  static const String baseUrl = 'https://51.21.120.88:8084';
  // static const String baseUrl = 'https://icrmonline.in:8084';
  // static const String baseUrl = 'http://10.0.2.2:8084';

  static const String users = '$baseUrl/saur/customers';
  static const String getUserByMobile = '$baseUrl/saur/customers/mobileNo/';
  static const String login = '$baseUrl/saur/customers/authenticate';

  static const String dealers = '$baseUrl/saur/dealers';

  static const String requestWarranty = '$baseUrl/saur/warrantyRequests/';

  // static const String warrantyByCustomer =
  //     '$baseUrl/saur/warrantyDetails/customer/';

  static const String exernalWarranty = '$baseUrl/saur/warrantyDetails/crm/';

  static String buildOtpUrl(String phone, String otp) {
    return 'http://14.97.212.62/api/SmsApi/SendSingleApi?UserID=Sudarshanbiz&Password=zdqx9664ZD&SenderID=SSSPLM&Phno=$phone&Msg=Sudarshan%20Saur%20Gurantee%20Registartion%20OTP-$otp&EntityID=1701160630405660648&TemplateID=1707171168816531737';
  }
}

// https://sms.voicesoft.in/vb/apikey.php?apikey=UaOLHBZP2GxUy3ZN&senderid=SSSPLM&number=9804945122&unicode=2&message=Your%20OTP%20for%20phone%20verification%20on%20Sudarshan%20Saur%20Application%20is%201234
