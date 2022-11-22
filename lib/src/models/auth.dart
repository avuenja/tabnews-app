class Auth {
  String? id;
  String? token;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;

  Auth({
    this.id,
    this.token,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  Auth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    expiresAt = json['expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['token'] = token;
    data['expires_at'] = expiresAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
