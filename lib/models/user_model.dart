import 'dart:convert';

import 'package:saur_customer/models/address_model.dart';

class UserModel {
  int? customerId;
  String? customerName;
  String? mobileNo;
  String? status;
  String? email;
  AddressModel? address;
  String? createdOn;
  String? updatedOn;
  String? lastLogin;
  String? image;
  String? lastPurchaseDate;
  String? password;
  UserModel({
    this.customerId,
    this.customerName,
    this.mobileNo,
    this.status,
    this.email,
    this.address,
    this.createdOn,
    this.updatedOn,
    this.lastLogin,
    this.image,
    this.lastPurchaseDate,
    this.password,
  });

  UserModel copyWith({
    int? customerId,
    String? customerName,
    String? mobileNo,
    String? status,
    String? email,
    AddressModel? address,
    String? createdOn,
    String? updatedOn,
    String? lastLogin,
    String? image,
    String? lastPurchaseDate,
    String? password,
  }) {
    return UserModel(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      mobileNo: mobileNo ?? this.mobileNo,
      status: status ?? this.status,
      email: email ?? this.email,
      address: address ?? this.address,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      lastLogin: lastLogin ?? this.lastLogin,
      image: image ?? this.image,
      lastPurchaseDate: lastPurchaseDate ?? this.lastPurchaseDate,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'mobileNo': mobileNo,
      'status': status,
      'email': email,
      'address': address?.toMap(),
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'lastLogin': lastLogin,
      'image': image,
      'lastPurchaseDate': lastPurchaseDate,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      customerId: map['customerId']?.toInt(),
      customerName: map['customerName'],
      mobileNo: map['mobileNo'],
      status: map['status'],
      email: map['email'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      lastLogin: map['lastLogin'],
      image: map['image'],
      lastPurchaseDate: map['lastPurchaseDate'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(customerId: $customerId, customerName: $customerName, mobileNo: $mobileNo, status: $status, email: $email, address: $address, createdOn: $createdOn, updatedOn: $updatedOn, lastLogin: $lastLogin, image: $image, lastPurchaseDate: $lastPurchaseDate, password: $password)';
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
        other.address == address &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.lastLogin == lastLogin &&
        other.image == image &&
        other.lastPurchaseDate == lastPurchaseDate &&
        other.password == password;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        customerName.hashCode ^
        mobileNo.hashCode ^
        status.hashCode ^
        email.hashCode ^
        address.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        lastLogin.hashCode ^
        image.hashCode ^
        lastPurchaseDate.hashCode ^
        password.hashCode;
  }
}
