import 'dart:math';

import '../models/address_model.dart';

String getShortMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Request in review';
    case 'APPROVED':
      return 'Request is approved';
    case 'DECLINED':
      return 'Request is rejected';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}

String getDetailedMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Your request is under validation, you will be notified in 24 hours';
    case 'APPROVED':
      return 'Your guarantee card is generated.';
    case 'DECLINED':
      return 'Your request is rejected by admin';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}

String prepareAddress(AddressModel? address) {
  return '${address?.houseNo}, ${address?.area}, ${address?.street1}, ${address?.street2}, ${address?.landmark}, ${address?.taluk}, ${address?.town}, ${address?.state}, ${address?.zipCode}';
}

String getOTPCode() {
  return (Random().nextInt(900000) + 100000).toString();
}

bool isValidPhoneNumber(String number) {
  if (number.length != 10) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}

bool isValidZipcode(String number) {
  if (number.length != 6) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}

bool isValidSerialNumber(String number) {
  if (number.length != 6) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}

String getOtpMessageId(String response) {
  String pattern = r'Message ID : (\d+)';
  RegExp regExp = RegExp(pattern);
  Match? match = regExp.firstMatch(response);

  if (match != null) {
    String messageId = match.group(1)!;
    return messageId;
  } else {
    return '';
  }
}
