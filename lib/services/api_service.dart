import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:saur_customer/models/list_models/customer_list_model.dart';
import 'package:saur_customer/models/list_models/dealer_last_model.dart';
import 'package:saur_customer/models/list_models/warranty_request_list.dart';
import 'package:saur_customer/models/otp_response.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/utils/api.dart';
import 'package:saur_customer/utils/enum.dart';
import 'package:saur_customer/utils/preference_key.dart';

import '../main.dart';
import '../models/warranty_request_model.dart';
import 'snakbar_service.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiProvider instance = ApiProvider();
  ApiProvider() {
    _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Future<bool> createUser(UserModel user) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> reqBody = {
        "customerName": user.customerName,
        "mobileNo": user.mobileNo,
        "status": user.status,
      };
      log(json.encode(reqBody));
      Response response = await _dio.post(
        Api.users,
        data: json.encode(reqBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, user.customerId ?? 0);
        if (user.status == UserStatus.ACTIVE.name) {
          status = ApiStatus.success;
          notifyListeners();
        } else {
          status = ApiStatus.failed;
          notifyListeners();
        }
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<UserModel?> getUserByPhone(String phone) async {
    status = ApiStatus.loading;
    UserModel? userModel;
    notifyListeners();
    log('${Api.getUserByMobile}$phone');
    try {
      Response response = await _dio.get(
        '${Api.getUserByMobile}$phone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        userModel = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, userModel.customerId ?? 0);
        status = ApiStatus.success;
        notifyListeners();
        return userModel;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      log(e.toString());
    }
    return userModel;
  }

  Future<UserModel?> getUserByPhoneSilent(String phone) async {
    status = ApiStatus.loading;
    UserModel? userModel;
    notifyListeners();
    log('${Api.getUserByMobile}$phone');
    try {
      Response response = await _dio.get(
        '${Api.getUserByMobile}$phone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        userModel = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, userModel.customerId ?? 0);
        status = ApiStatus.success;
        notifyListeners();
        return userModel;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      log(e.toString());
    }
    return userModel;
  }

  Future<bool> updateUser(Map<String, dynamic> user, int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Response response = await _dio.put(
        '${Api.users}/$id',
        data: json.encode(user),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, user.customerId ?? 0);
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<bool> updateWarrantyRequest(
      Map<String, dynamic> warrantyReq, int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    log(json.encode(warrantyReq));
    log('id : $id');
    try {
      Response response = await _dio.put(
        '${Api.requestWarranty}$id',
        data: json.encode(warrantyReq),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<UserModel?> getCustomerById(int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    UserModel? userModel;
    try {
      Response response = await _dio.get(
        '${Api.users}/$id',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        userModel = UserModel.fromMap(response.data['data']);
        status = ApiStatus.success;
        notifyListeners();
        return userModel;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      // SnackBarService.instance
      //     .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return userModel;
  }

  Future<CustomerListModel?> getAllCustomer() async {
    status = ApiStatus.loading;
    notifyListeners();
    CustomerListModel? list;
    try {
      Response response = await _dio.get(
        Api.users,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = CustomerListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
        return list;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<CustomerListModel?> getCustomerMobileNumber(String phone) async {
    status = ApiStatus.loading;
    notifyListeners();
    CustomerListModel? list;
    try {
      Response response = await _dio.get(
        '${Api.users}/?mobileNo=$phone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = CustomerListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
        return list;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<DealerListModel?> getAllDealers() async {
    status = ApiStatus.loading;
    notifyListeners();
    DealerListModel? list;
    try {
      Response response = await _dio.get(
        Api.dealers,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = DealerListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
        return list;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<bool> createNewWarrantyRequest(
      WarrantyRequestModel requestModel) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> reqMap = requestModel.toMap();
      reqMap['customers'] = {"customerId": requestModel.customers?.customerId};
      reqMap['warrantyDetails'] = {
        "warrantySerialNo": requestModel.warrantyDetails?.warrantySerialNo
      };
      log(
        json.encode(reqMap),
      );
      Response response = await _dio.post(
        Api.requestWarranty,
        data: json.encode(reqMap),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      log('resp code : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance.showSnackBarError('Error : $resBody');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<WarrantyRequestList?> getWarrantyRequestListByCustomerId(
      int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    WarrantyRequestList? list;
    log('${Api.requestWarranty}customer/$id');
    try {
      Response response = await _dio.get(
        '${Api.requestWarranty}customer/$id',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = WarrantyRequestList.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<bool> sendOtp(String phone, String otp) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Response response = await _dio.get(
        Api.buildOtpUrl(phone, otp),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        SnackBarService.instance.showSnackBarInfo('OTP sent');
        OTPResponse optresponse = OTPResponse.fromJson(response.data);
        prefs.setString(SharedpreferenceKey.otpMessageId,
            optresponse.data?.messageid ?? 'MTMyNzQ1MzY=');
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<WarrantyModel?> getDeviceBySerialNo(String serialNo,
      {bool? showAlerts}) async {
    status = ApiStatus.loading;
    WarrantyModel? device;
    log('${Api.exernalWarranty}$serialNo');
    notifyListeners();
    try {
      Response response = await _dio.get(
        '${Api.exernalWarranty}$serialNo',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        device = WarrantyModel.fromMap(response.data['data']);

        status = ApiStatus.success;
        notifyListeners();
        return device;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      if (showAlerts ?? true) {
        SnackBarService.instance
            .showSnackBarError('Error : ${resBody['message']}');
      }
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      if (showAlerts ?? true) {
        SnackBarService.instance.showSnackBarError(e.toString());
      }
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return device;
  }

  Future<bool> createTicket(Map<String, dynamic> map) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      var formData = FormData.fromMap({
        'pass': 'admin',
        'url': 'https://icrmondemand.com/sudarshan',
        'module': 'Cases',
        'jsonParam': map
      });

      Response response = await _dio.post(
        'https://icrmondemand.com/sudarshan/index.php?entryPoint=CreateTicketAPI',
        data: formData,
      );
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;

      notifyListeners();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }
}
