class customer {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String roleId;
  String loginType;
  String type;
  String facebookReferenceId;
  String status;
  String partnerId;
  String createdBy;
  String isDeleted;
  String datetimeCreated;
  String datetimeModified;

  customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.roleId,
      this.loginType,
      this.type,
      this.facebookReferenceId,
      this.status,
      this.partnerId,
      this.createdBy,
      this.isDeleted,
      this.datetimeCreated,
      this.datetimeModified});

  customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    roleId = json['role_id'];
    loginType = json['login_type'];
    type = json['type'];
    facebookReferenceId = json['facebook_reference_id'];
    status = json['status'];
    partnerId = json['partner_id'];
    createdBy = json['created_by'];
    isDeleted = json['is_deleted'];
    datetimeCreated = json['datetime_created'];
    datetimeModified = json['datetime_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role_id'] = this.roleId;
    data['login_type'] = this.loginType;
    data['type'] = this.type;
    data['facebook_reference_id'] = this.facebookReferenceId;
    data['status'] = this.status;
    data['partner_id'] = this.partnerId;
    data['created_by'] = this.createdBy;
    data['is_deleted'] = this.isDeleted;
    data['datetime_created'] = this.datetimeCreated;
    data['datetime_modified'] = this.datetimeModified;
    return data;
  }
}
