class GetNotificationAll {
  int? statusCode;
  String? message;
  List<DataNotification>? data;

  GetNotificationAll({this.statusCode, this.message, this.data});

  GetNotificationAll.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataNotification>[];
      json['data'].forEach((v) {
        data!.add(new DataNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNotification {
  int? id;
  String? name;
  int? notificationFromId;
  String? notificationFormModal;
  int? notificationToId;
  String? notificationToModal;
  String? message;
  var jobId;
  var readByJob;
  String? createdAt;
  String? updatedAt;
  var isRead;

  DataNotification(
      {this.id,
        this.name,
        this.notificationFromId,
        this.notificationFormModal,
        this.notificationToId,
        this.notificationToModal,
        this.message,
        this.jobId,
        this.readByJob,
        this.createdAt,
        this.updatedAt,
        this.isRead});

  DataNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    notificationFromId = json['notification_from_id'];
    notificationFormModal = json['notification_form_modal'];
    notificationToId = json['notification_to_id'];
    notificationToModal = json['notification_to_modal'];
    message = json['message'];
    jobId = json['job_id'];
    readByJob = json['read_by_job'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['notification_from_id'] = this.notificationFromId;
    data['notification_form_modal'] = this.notificationFormModal;
    data['notification_to_id'] = this.notificationToId;
    data['notification_to_modal'] = this.notificationToModal;
    data['message'] = this.message;
    data['job_id'] = this.jobId;
    data['read_by_job'] = this.readByJob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_read'] = this.isRead;
    return data;
  }
}
