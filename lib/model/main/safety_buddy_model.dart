class SafetyBuddySuccessModel {
  bool? status;
  String? message;
  List<SafetyBuddyData>? data;
  int? totalObject;
  String? token;

  SafetyBuddySuccessModel(
      {this.status, this.message, this.data, this.totalObject, this.token});

  SafetyBuddySuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SafetyBuddyData>[];
      json['data'].forEach((v) {
        data!.add(new SafetyBuddyData.fromJson(v));
      });
    }
    totalObject = json['total_object'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_object'] = this.totalObject;
    data['token'] = this.token;
    return data;
  }
}

class SafetyBuddyData {
  int? id;
  String? image;
  String? response;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? user;
  int? tenant;

  SafetyBuddyData(
      {this.id,
      this.image,
      this.response,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.tenant});

  SafetyBuddyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    response = json['response'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
    tenant = json['tenant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['response'] = this.response;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    data['tenant'] = this.tenant;
    return data;
  }
}
