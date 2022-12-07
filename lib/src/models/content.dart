class Content {
  String? id;
  String? ownerId;
  String? parentId;
  String? slug;
  String? title;
  String? body;
  String? status;
  String? sourceUrl;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? deletedAt;
  String? ownerUsername;
  int? tabcoins;
  int? childrenDeepCount;
  Content? parent;

  Content({
    this.id,
    this.ownerId,
    this.parentId,
    this.slug,
    this.title,
    this.body,
    this.status,
    this.sourceUrl,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.deletedAt,
    this.ownerUsername,
    this.tabcoins,
    this.childrenDeepCount,
    this.parent,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'];
    body = json['body'];
    status = json['status'];
    sourceUrl = json['source_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    deletedAt = json['deleted_at'];
    tabcoins = json['tabcoins'];
    ownerUsername = json['owner_username'];
    childrenDeepCount = json['children_deep_count'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['owner_id'] = ownerId;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['title'] = title;
    data['body'] = body;
    data['status'] = status;
    data['source_url'] = sourceUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['published_at'] = publishedAt;
    data['deleted_at'] = deletedAt;
    data['tabcoins'] = tabcoins;
    data['owner_username'] = ownerUsername;
    data['children_deep_count'] = childrenDeepCount;
    data['parent'] = parent;

    return data;
  }
}
