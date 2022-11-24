class User {
  String? id;
  String? username;
  String? email;
  bool? notifications;
  List<String>? features;
  int? tabcoins;
  int? tabcash;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.notifications,
    this.features,
    this.tabcoins,
    this.tabcash,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    notifications = json['notifications'];
    features = json['features'].cast<String>();
    tabcoins = json['tabcoins'];
    tabcash = json['tabcash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['notifications'] = notifications;
    data['features'] = features;
    data['tabcoins'] = tabcoins;
    data['tabcash'] = tabcash;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
