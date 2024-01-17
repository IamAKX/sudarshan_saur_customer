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
  String? lat;
  String? lon;
  bool? photoChecked;
  bool? otherInfoChecked;
  String? verifiedBy;
  String? verifiedDate;
  bool? paymentDone;
  int? requestId;
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
    this.lat,
    this.lon,
    this.photoChecked,
    this.otherInfoChecked,
    this.verifiedBy,
    this.verifiedDate,
    this.paymentDone,
    this.requestId,
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
    String? lat,
    String? lon,
    bool? photoChecked,
    bool? otherInfoChecked,
    String? verifiedBy,
    String? verifiedDate,
    bool? paymentDone,
    int? requestId,
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
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      photoChecked: photoChecked ?? this.photoChecked,
      otherInfoChecked: otherInfoChecked ?? this.otherInfoChecked,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      verifiedDate: verifiedDate ?? this.verifiedDate,
      paymentDone: paymentDone ?? this.paymentDone,
      requestId: requestId ?? this.requestId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(customers != null){
      result.addAll({'customers': customers!.toMap()});
    }
    if(mobile2 != null){
      result.addAll({'mobile2': mobile2});
    }
    if(installationAddress != null){
      result.addAll({'installationAddress': installationAddress!.toMap()});
    }
    if(ownerAddress != null){
      result.addAll({'ownerAddress': ownerAddress!.toMap()});
    }
    if(warrantyDetails != null){
      result.addAll({'warrantyDetails': warrantyDetails!.toMap()});
    }
    if(dealerInfo != null){
      result.addAll({'dealerInfo': dealerInfo!.toMap()});
    }
    if(technicianInfo != null){
      result.addAll({'technicianInfo': technicianInfo!.toMap()});
    }
    if(plumberInfo != null){
      result.addAll({'plumberInfo': plumberInfo!.toMap()});
    }
    if(answers != null){
      result.addAll({'answers': answers!.map((x) => x?.toMap()).toList()});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(images != null){
      result.addAll({'images': images!.toMap()});
    }
    if(createdOn != null){
      result.addAll({'createdOn': createdOn});
    }
    if(updatedOn != null){
      result.addAll({'updatedOn': updatedOn});
    }
    if(initUserType != null){
      result.addAll({'initUserType': initUserType});
    }
    if(initiatedBy != null){
      result.addAll({'initiatedBy': initiatedBy});
    }
    if(approvedBy != null){
      result.addAll({'approvedBy': approvedBy});
    }
    if(installationDate != null){
      result.addAll({'installationDate': installationDate});
    }
    if(invoiceDate != null){
      result.addAll({'invoiceDate': invoiceDate});
    }
    if(invoiceNumber != null){
      result.addAll({'invoiceNumber': invoiceNumber});
    }
    if(lat != null){
      result.addAll({'lat': lat});
    }
    if(lon != null){
      result.addAll({'lon': lon});
    }
    if(photoChecked != null){
      result.addAll({'photoChecked': photoChecked});
    }
    if(otherInfoChecked != null){
      result.addAll({'otherInfoChecked': otherInfoChecked});
    }
    if(verifiedBy != null){
      result.addAll({'verifiedBy': verifiedBy});
    }
    if(verifiedDate != null){
      result.addAll({'verifiedDate': verifiedDate});
    }
    if(paymentDone != null){
      result.addAll({'paymentDone': paymentDone});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
  
    return result;
  }

  factory WarrantyRequestModel.fromMap(Map<String, dynamic> map) {
    return WarrantyRequestModel(
      customers: map['customers'] != null ? UserModel.fromMap(map['customers']) : null,
      mobile2: map['mobile2'],
      installationAddress: map['installationAddress'] != null ? AddressModel.fromMap(map['installationAddress']) : null,
      ownerAddress: map['ownerAddress'] != null ? AddressModel.fromMap(map['ownerAddress']) : null,
      warrantyDetails: map['warrantyDetails'] != null ? WarrantyModel.fromMap(map['warrantyDetails']) : null,
      dealerInfo: map['dealerInfo'] != null ? DealerModel.fromMap(map['dealerInfo']) : null,
      technicianInfo: map['technicianInfo'] != null ? TechnicianModel.fromMap(map['technicianInfo']) : null,
      plumberInfo: map['plumberInfo'] != null ? PlumberModel.fromMap(map['plumberInfo']) : null,
      answers: map['answers'] != null ? List<QuestionAnswerModel>.from(map['answers']?.map((x) => QuestionAnswerModel.fromMap(x))) : null,
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
      lat: map['lat'],
      lon: map['lon'],
      photoChecked: map['photoChecked'],
      otherInfoChecked: map['otherInfoChecked'],
      verifiedBy: map['verifiedBy'],
      verifiedDate: map['verifiedDate'],
      paymentDone: map['paymentDone'],
      requestId: map['requestId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyRequestModel.fromJson(String source) => WarrantyRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyRequestModel(customers: $customers, mobile2: $mobile2, installationAddress: $installationAddress, ownerAddress: $ownerAddress, warrantyDetails: $warrantyDetails, dealerInfo: $dealerInfo, technicianInfo: $technicianInfo, plumberInfo: $plumberInfo, answers: $answers, status: $status, images: $images, createdOn: $createdOn, updatedOn: $updatedOn, initUserType: $initUserType, initiatedBy: $initiatedBy, approvedBy: $approvedBy, installationDate: $installationDate, invoiceDate: $invoiceDate, invoiceNumber: $invoiceNumber, lat: $lat, lon: $lon, photoChecked: $photoChecked, otherInfoChecked: $otherInfoChecked, verifiedBy: $verifiedBy, verifiedDate: $verifiedDate, paymentDone: $paymentDone, requestId: $requestId)';
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
      other.invoiceNumber == invoiceNumber &&
      other.lat == lat &&
      other.lon == lon &&
      other.photoChecked == photoChecked &&
      other.otherInfoChecked == otherInfoChecked &&
      other.verifiedBy == verifiedBy &&
      other.verifiedDate == verifiedDate &&
      other.paymentDone == paymentDone &&
      other.requestId == requestId;
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
      invoiceNumber.hashCode ^
      lat.hashCode ^
      lon.hashCode ^
      photoChecked.hashCode ^
      otherInfoChecked.hashCode ^
      verifiedBy.hashCode ^
      verifiedDate.hashCode ^
      paymentDone.hashCode ^
      requestId.hashCode;
  }
}
