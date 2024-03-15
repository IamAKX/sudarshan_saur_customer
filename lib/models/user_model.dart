import 'dart:convert';

import 'package:saur_customer/models/address_model.dart';

class UserModel {
  int? customerId;
  String? customerName;
  String? mobileNo;
  String? status;
  String? email;
  AddressModel? installationAddress;
  AddressModel? address;
  String? lastLogin;
  String? image;
  String? installerMobile;
  UserModel({
    this.customerId,
    this.customerName,
    this.mobileNo,
    this.status,
    this.email,
    this.installationAddress,
    this.address,
    this.lastLogin,
    this.image,
    this.installerMobile,
  });

  UserModel copyWith({
    int? customerId,
    String? customerName,
    String? mobileNo,
    String? status,
    String? email,
    AddressModel? installationAddress,
    AddressModel? address,
    String? lastLogin,
    String? image,
    String? installerMobile,
  }) {
    return UserModel(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      mobileNo: mobileNo ?? this.mobileNo,
      status: status ?? this.status,
      email: email ?? this.email,
      installationAddress: installationAddress ?? this.installationAddress,
      address: address ?? this.address,
      lastLogin: lastLogin ?? this.lastLogin,
      image: image ?? this.image,
      installerMobile: installerMobile ?? this.installerMobile,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (customerId != null) {
      result.addAll({'customerId': customerId});
    }
    if (customerName != null) {
      result.addAll({'customerName': customerName});
    }
    if (mobileNo != null) {
      result.addAll({'mobileNo': mobileNo});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (installationAddress != null) {
      result.addAll({'installationAddress': installationAddress!.toMap()});
    }
    if (address != null) {
      result.addAll({'address': address!.toMap()});
    }
    if (lastLogin != null) {
      result.addAll({'lastLogin': lastLogin});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (installerMobile != null) {
      result.addAll({'installerMobile': installerMobile});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      customerId: map['customerId']?.toInt(),
      customerName: map['customerName'],
      mobileNo: map['mobileNo'],
      status: map['status'],
      email: map['email'],
      installationAddress: map['installationAddress'] != null
          ? AddressModel.fromMap(map['installationAddress'])
          : null,
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      lastLogin: map['lastLogin'],
      image: map['image'],
      installerMobile: map['installerMobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(customerId: $customerId, customerName: $customerName, mobileNo: $mobileNo, status: $status, email: $email, installationAddress: $installationAddress, address: $address, lastLogin: $lastLogin, image: $image, installerMobile: $installerMobile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.mobileNo == mobileNo &&
        other.status == status &&
        other.email == email &&
        other.installationAddress == installationAddress &&
        other.address == address &&
        other.lastLogin == lastLogin &&
        other.image == image &&
        other.installerMobile == installerMobile;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        customerName.hashCode ^
        mobileNo.hashCode ^
        status.hashCode ^
        email.hashCode ^
        installationAddress.hashCode ^
        address.hashCode ^
        lastLogin.hashCode ^
        image.hashCode ^
        installerMobile.hashCode;
  }
}
