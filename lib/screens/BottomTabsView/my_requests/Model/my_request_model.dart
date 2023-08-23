// To parse this JSON data, do
//
//     final allRequestResponse = allRequestResponseFromJson(jsonString);

import 'dart:convert';

AllRequestResponse allRequestResponseFromJson(String str) => AllRequestResponse.fromJson(json.decode(str));

String allRequestResponseToJson(AllRequestResponse data) => json.encode(data.toJson());


class AllRequestResponse {
  int? statusCode;
  String? message;
  Data? data;

  AllRequestResponse({this.statusCode, this.message, this.data});

  AllRequestResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<All>? all;
  List<All>? inactive;
  List<All>? active;
  List<All>? completed;

  Data({this.all, this.inactive, this.active, this.completed});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
    if (json['Inactive'] != null) {
      inactive = <All>[];
      json['Inactive'].forEach((v) {
        inactive!.add(new All.fromJson(v));
      });
    }
    if (json['Active'] != null) {
      active = <All>[];
      json['Active'].forEach((v) {
        active!.add(new All.fromJson(v));
      });
    }
    if (json['Completed'] != null) {
      completed = <All>[];
      json['Completed'].forEach((v) {
        completed!.add(new All.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.map((v) => v.toJson()).toList();
    }
    if (this.inactive != null) {
      data['Inactive'] = this.inactive!.map((v) => v.toJson()).toList();
    }
    if (this.active != null) {
      data['Active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['Completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class All {
  var id;
  var subId;
  var providerId;
  var postId;
  var cusId;
  String? description;
  var budget;
  String? address;
  var image;
  var selectProvider;
  String? date;
  var status;
  var userStatus;
  String? phoneNo;
  var prove;
  String? createdAt;
  String? updatedAt;
  String? subCategoryName;
  var postCount;
  List<Posts>? posts;
  Provider? provider;

  All(
      {this.id,
        this.subId,
        this.providerId,
        this.postId,
        this.cusId,
        this.description,
        this.budget,
        this.address,
        this.image,
        this.selectProvider,
        this.date,
        this.status,
        this.userStatus,
        this.phoneNo,
        this.prove,
        this.createdAt,
        this.updatedAt,
        this.subCategoryName,
        this.postCount,
        this.posts,
        this.provider});

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    providerId = json['provider_id'];
    postId = json['post_id'];
    cusId = json['cus_id'];
    description = json['description'];
    budget = json['budget'];
    address = json['address'];
    image = json['image'];
    selectProvider = json['select_provider'];
    date = json['date'];
    status = json['status'];
    userStatus = json['user_status'];
    phoneNo = json['phone_no'];
    prove = json['prove'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategoryName = json['subCategory_name'];
    postCount = json['post_count'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['provider_id'] = this.providerId;
    data['post_id'] = this.postId;
    data['cus_id'] = this.cusId;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['address'] = this.address;
    data['image'] = this.image;
    data['select_provider'] = this.selectProvider;
    data['date'] = this.date;
    data['status'] = this.status;
    data['user_status'] = this.userStatus;
    data['phone_no'] = this.phoneNo;
    data['prove'] = this.prove;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subCategory_name'] = this.subCategoryName;
    data['post_count'] = this.postCount;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Posts {
  int? id;
  var subId;
  var providerId;
  var customerId;
  var jobId;
  var address;
  var image;
  String? description;
  var price;
  var status;
  var reason;
  var agree;
  var createdAt;
  var updatedAt;
  var providerName;
  var ratingCount;
  var avgRating;


  Posts(
      {this.id,
        this.subId,
        this.providerId,
        this.customerId,
        this.jobId,
        this.address,
        this.image,
        this.description,
        this.price,
        this.status,
        this.reason,
        this.agree,
        this.createdAt,
        this.updatedAt,
        this.providerName,
        this.ratingCount,
        this.avgRating,
       });

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    providerId = json['provider_id'];
    customerId = json['customer_id'];
    jobId = json['job_id'];
    address = json['address'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    reason = json['reason'];
    agree = json['agree'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    providerName = json['provider_name'];
    ratingCount = json['ratingCount'];
    avgRating = json['avgRating'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['provider_id'] = this.providerId;
    data['customer_id'] = this.customerId;
    data['job_id'] = this.jobId;
    data['address'] = this.address;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['agree'] = this.agree;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['provider_name'] = this.providerName;
    data['ratingCount'] = this.ratingCount;
    data['avgRating'] = this.avgRating;

    return data;
  }
}

class Services {
  var id;
  String? name;
  String? description;
  String? image;
  var price;
  var parentId;
  var subId;
  var status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Services(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.parentId,
        this.subId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    parentId = json['parent_id'];
    subId = json['sub_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['parent_id'] = this.parentId;
    data['sub_id'] = this.subId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  var providerId;
  var serviceId;

  Pivot({this.providerId, this.serviceId});

  Pivot.fromJson(Map<String, dynamic> json) {
    providerId = json['provider_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider_id'] = this.providerId;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class Provider {
  var id;


  String? image;



  Provider(
      {this.id,

        this.image,
       });

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['image'] = this.image;

    return data;
  }
}

