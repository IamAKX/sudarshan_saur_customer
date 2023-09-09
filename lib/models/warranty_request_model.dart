import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/address_model.dart';
import 'package:saur_customer/models/dealer_model.dart';
import 'package:saur_customer/models/images_model.dart';
import 'package:saur_customer/models/list_models/question_answer_model.dart';
import 'package:saur_customer/models/plumber_model.dart';
import 'package:saur_customer/models/technician_model.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';

class WarrantyRequestModel {
  UserModel? customers;
  String? mobile2;

  AddressModel? installationAddress;
  AddressModel? ownerAddress;
  WarrantyModel? warrantyDetails;
  DealerModel? dealerInfo;
  TechnicianModel? technicianInfo;
  PlumberModel? plumberInfo;
  List<QuestionAnswerModel>? answers;
  String? status;
  ImagesModel? images;
  String? createdOn;
  String? updatedOn;
  String? initUserType;
  String? initiatedBy;
  String? approvedBy;
  String? installationDate;
  String? invoiceDate;
  String? invoiceNumber;
  WarrantyRequestModel({
    this.customers,
    this.mobile2,
    this.installationAddress,
    this.ownerAddress,
    this.warrantyDetails,
    this.dealerInfo,
    this.technicianInfo,
    this.plumberInfo,
    this.answers,
    this.status,
    this.images,
    this.createdOn,
    this.updatedOn,
    this.initUserType,
    this.initiatedBy,
    this.approvedBy,
    this.installationDate,
    this.invoiceDate,
    this.invoiceNumber,
  });

  WarrantyRequestModel copyWith({
    UserModel? customers,
    String? mobile2,
    AddressModel? installationAddress,
    AddressModel? ownerAddress,
    WarrantyModel? warrantyDetails,
    DealerModel? dealerInfo,
    TechnicianModel? technicianInfo,
    PlumberModel? plumberInfo,
    List<QuestionAnswerModel>? answers,
    String? status,
    ImagesModel? images,
    String? createdOn,
    String? updatedOn,
    String? initUserType,
    String? initiatedBy,
    String? approvedBy,
    String? installationDate,
    String? invoiceDate,
    String? invoiceNumber,
  }) {
    return WarrantyRequestModel(
      customers: customers ?? this.customers,
      mobile2: mobile2 ?? this.mobile2,
      installationAddress: installationAddress ?? this.installationAddress,
      ownerAddress: ownerAddress ?? this.ownerAddress,
      warrantyDetails: warrantyDetails ?? this.warrantyDetails,
      dealerInfo: dealerInfo ?? this.dealerInfo,
      technicianInfo: technicianInfo ?? this.technicianInfo,
      plumberInfo: plumberInfo ?? this.plumberInfo,
      answers: answers ?? this.answers,
      status: status ?? this.status,
      images: images ?? this.images,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      initUserType: initUserType ?? this.initUserType,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      installationDate: installationDate ?? this.installationDate,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customers': customers?.toMap(),
      'mobile2': mobile2,
      'installationAddress': installationAddress?.toMap(),
      'ownerAddress': ownerAddress?.toMap(),
      'warrantyDetails': warrantyDetails?.toMap(),
      'dealerInfo': dealerInfo?.toMap(),
      'technicianInfo': technicianInfo?.toMap(),
      'plumberInfo': plumberInfo?.toMap(),
      'answers': answers?.map((x) => x?.toMap())?.toList(),
      'status': status,
      'images': images?.toMap(),
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'initUserType': initUserType,
      'initiatedBy': initiatedBy,
      'approvedBy': approvedBy,
      'installationDate': installationDate,
      'invoiceDate': invoiceDate,
      'invoiceNumber': invoiceNumber,
    };
  }

  factory WarrantyRequestModel.fromMap(Map<String, dynamic> map) {
    return WarrantyRequestModel(
      customers:
          map['customers'] != null ? UserModel.fromMap(map['customers']) : null,
      mobile2: map['mobile2'],
      installationAddress: map['installationAddress'] != null
          ? AddressModel.fromMap(map['installationAddress'])
          : null,
      ownerAddress: map['ownerAddress'] != null
          ? AddressModel.fromMap(map['ownerAddress'])
          : null,
      warrantyDetails: map['warrantyDetails'] != null
          ? WarrantyModel.fromMap(map['warrantyDetails'])
          : null,
      dealerInfo: map['dealerInfo'] != null
          ? DealerModel.fromMap(map['dealerInfo'])
          : null,
      technicianInfo: map['technicianInfo'] != null
          ? TechnicianModel.fromMap(map['technicianInfo'])
          : null,
      plumberInfo: map['plumberInfo'] != null
          ? PlumberModel.fromMap(map['plumberInfo'])
          : null,
      answers: map['answers'] != null
          ? List<QuestionAnswerModel>.from(
              map['answers']?.map((x) => QuestionAnswerModel.fromMap(x)))
          : null,
      status: map['status'],
      images: map['images'] != null ? ImagesModel.fromMap(map['images']) : null,
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      initUserType: map['initUserType'],
      initiatedBy: map['initiatedBy'],
      approvedBy: map['approvedBy'],
      installationDate: map['installationDate'],
      invoiceDate: map['invoiceDate'],
      invoiceNumber: map['invoiceNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyRequestModel.fromJson(String source) =>
      WarrantyRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyRequestModel(customers: $customers, mobile2: $mobile2, installationAddress: $installationAddress, ownerAddress: $ownerAddress, warrantyDetails: $warrantyDetails, dealerInfo: $dealerInfo, technicianInfo: $technicianInfo, plumberInfo: $plumberInfo, answers: $answers, status: $status, images: $images, createdOn: $createdOn, updatedOn: $updatedOn, initUserType: $initUserType, initiatedBy: $initiatedBy, approvedBy: $approvedBy, installationDate: $installationDate, invoiceDate: $invoiceDate, invoiceNumber: $invoiceNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyRequestModel &&
        other.customers == customers &&
        other.mobile2 == mobile2 &&
        other.installationAddress == installationAddress &&
        other.ownerAddress == ownerAddress &&
        other.warrantyDetails == warrantyDetails &&
        other.dealerInfo == dealerInfo &&
        other.technicianInfo == technicianInfo &&
        other.plumberInfo == plumberInfo &&
        listEquals(other.answers, answers) &&
        other.status == status &&
        other.images == images &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.initUserType == initUserType &&
        other.initiatedBy == initiatedBy &&
        other.approvedBy == approvedBy &&
        other.installationDate == installationDate &&
        other.invoiceDate == invoiceDate &&
        other.invoiceNumber == invoiceNumber;
  }

  @override
  int get hashCode {
    return customers.hashCode ^
        mobile2.hashCode ^
        installationAddress.hashCode ^
        ownerAddress.hashCode ^
        warrantyDetails.hashCode ^
        dealerInfo.hashCode ^
        technicianInfo.hashCode ^
        plumberInfo.hashCode ^
        answers.hashCode ^
        status.hashCode ^
        images.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        initUserType.hashCode ^
        initiatedBy.hashCode ^
        approvedBy.hashCode ^
        installationDate.hashCode ^
        invoiceDate.hashCode ^
        invoiceNumber.hashCode;
  }
}
