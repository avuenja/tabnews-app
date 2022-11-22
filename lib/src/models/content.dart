class Content {
  String? id;
  String? ownerId;
  String? parentId;
  String? slug;
  String? title;
  String? status;
  String? sourceUrl;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? deletedAt;
  int? tabcoins;
  String? ownerUsername;
  int? childrenDeepCount;

  Content({
    this.id,
    this.ownerId,
    this.parentId,
    this.slug,
    this.title,
    this.status,
    this.sourceUrl,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.deletedAt,
    this.tabcoins,
    this.ownerUsername,
    this.childrenDeepCount,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'];
    status = json['status'];
    sourceUrl = json['source_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    deletedAt = json['deleted_at'];
    tabcoins = json['tabcoins'];
    ownerUsername = json['owner_username'];
    childrenDeepCount = json['children_deep_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['owner_id'] = ownerId;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['title'] = title;
    data['status'] = status;
    data['source_url'] = sourceUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['published_at'] = publishedAt;
    data['deleted_at'] = deletedAt;
    data['tabcoins'] = tabcoins;
    data['owner_username'] = ownerUsername;
    data['children_deep_count'] = childrenDeepCount;

    return data;
  }
}
