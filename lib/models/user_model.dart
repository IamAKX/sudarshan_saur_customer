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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'mobileNo': mobileNo,
      'status': status,
      'email': email,
      'installationAddress': installationAddress?.toMap(),
      'address': address?.toMap(),
      'lastLogin': lastLogin,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      customerId: map['customerId']?.toInt(),
      customerName: map['customerName'],
      mobileNo: map['mobileNo'],
      status: map['status'],
      email: map['email'],
      installationAddress: map['installationAddress'] != null ? AddressModel.fromMap(map['installationAddress']) : null,
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      lastLogin: map['lastLogin'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(customerId: $customerId, customerName: $customerName, mobileNo: $mobileNo, status: $status, email: $email, installationAddress: $installationAddress, address: $address, lastLogin: $lastLogin, image: $image)';
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
      other.image == image;
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
      image.hashCode;
  }
}
