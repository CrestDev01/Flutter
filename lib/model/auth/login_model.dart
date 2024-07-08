import 'package:boilerplate/model/auth/user_model.dart';

class LoginSuccessModel {
  bool? status;
  String? message;
  LoginData? data;

  LoginSuccessModel({this.status, this.message, this.data});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? accessToken;
  String? refereshToken;
  User? user;
  Tenant? tenant;
  Plan? plan;
  bool? isTenantAdmin;

  LoginData(
      {this.accessToken,
      this.refereshToken,
      this.user,
      this.tenant,
      this.plan,
      this.isTenantAdmin});

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refereshToken = json['referesh_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tenant =
        json['tenant'] != null ? new Tenant.fromJson(json['tenant']) : null;
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    isTenantAdmin = json['is_tenant_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['referesh_token'] = this.refereshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tenant != null) {
      data['tenant'] = this.tenant!.toJson();
    }
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    data['is_tenant_admin'] = this.isTenantAdmin;
    return data;
  }
}

class Tenant {
  int? id;
  String? name;

  Tenant({this.id, this.name});

  Tenant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Plan {
  String? id;
  num? amount;
  num? amountDecimal;
  String? interval;
  String? productName;
  String? productDescription;
  String? planStartDate;
  String? planEndDate;

  Plan(
      {this.id,
      this.amount,
      this.amountDecimal,
      this.interval,
      this.productName,
      this.productDescription,
      this.planStartDate,
      this.planEndDate});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    amountDecimal = json['amount_decimal'];
    interval = json['interval'];
    productName = json['product__name'];
    productDescription = json['product__description'];
    planStartDate = json['plan_start_date'];
    planEndDate = json['plan_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['amount_decimal'] = this.amountDecimal;
    data['interval'] = this.interval;
    data['product__name'] = this.productName;
    data['product__description'] = this.productDescription;
    data['plan_start_date'] = this.planStartDate;
    data['plan_end_date'] = this.planEndDate;
    return data;
  }
}
