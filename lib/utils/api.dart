class Api {
  static const String baseUrl = 'https://icrmonline.in:8084';
  // static const String baseUrl = 'http://10.0.2.2:8084';

  static const String users = '$baseUrl/saur/customers';
  static const String login = '$baseUrl/saur/customers/authenticate';

  static const String dealers = '$baseUrl/saur/dealers';

  static const String requestWarranty = '$baseUrl/saur/warrantyDetails/';

  static const String warrantyByCustomer =
      '$baseUrl/saur/warrantyDetails/customer/';
}
