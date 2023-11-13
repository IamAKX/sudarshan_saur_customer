import 'dart:convert';

class ImagesModel {
  String? imgLiveSystem;
  String? imgSystemSerialNo;
  String? imgAadhar;
  ImagesModel({
    this.imgLiveSystem,
    this.imgSystemSerialNo,
    this.imgAadhar,
  });

  ImagesModel copyWith({
    String? imgLiveSystem,
    String? imgSystemSerialNo,
    String? imgAadhar,
  }) {
    return ImagesModel(
      imgLiveSystem: imgLiveSystem ?? this.imgLiveSystem,
      imgSystemSerialNo: imgSystemSerialNo ?? this.imgSystemSerialNo,
      imgAadhar: imgAadhar ?? this.imgAadhar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imgLiveSystem': imgLiveSystem,
      'imgSystemSerialNo': imgSystemSerialNo,
      'imgAadhar': imgAadhar,
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      imgLiveSystem: map['imgLiveSystem'],
      imgSystemSerialNo: map['imgSystemSerialNo'],
      imgAadhar: map['imgAadhar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) => ImagesModel.fromMap(json.decode(source));

  @override
  String toString() => 'ImagesModel(imgLiveSystem: $imgLiveSystem, imgSystemSerialNo: $imgSystemSerialNo, imgAadhar: $imgAadhar)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImagesModel &&
      other.imgLiveSystem == imgLiveSystem &&
      other.imgSystemSerialNo == imgSystemSerialNo &&
      other.imgAadhar == imgAadhar;
  }

  @override
  int get hashCode => imgLiveSystem.hashCode ^ imgSystemSerialNo.hashCode ^ imgAadhar.hashCode;
}
