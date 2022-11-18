import 'dart:convert';

List<SubmissionModel> submissionModelFromJson(String str) =>
    List<SubmissionModel>.from(
        json.decode(str).map((x) => SubmissionModel.fromJson(x)));

String submissionModelToJson(List<SubmissionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubmissionModel {
  SubmissionModel({
    this.id,
    this.taskNumber,
    this.userId,
    this.nik,
    this.name,
    this.title,
    this.description,
    this.complaintVillage,
    this.hp,
    this.latitude,
    this.longtitude,
    this.images,
    this.status,
  });

  int? id;
  String? taskNumber;
  String? userId;
  String? nik;
  String? name;
  String? title;
  String? description;
  String? complaintVillage;
  String? hp;
  String? latitude;
  String? longtitude;
  String? status;
  List<Image>? images;

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      SubmissionModel(
        id: json["id"],
        taskNumber: json["task_number"],
        userId: json["user_id"],
        nik: json["nik"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        complaintVillage: json["complaint_village"],
        hp: json["hp"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        status: json["status"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_number": taskNumber,
        "user_id": userId,
        "nik": nik,
        "name": name,
        "title": title,
        "description": description,
        "complaint_village": complaintVillage,
        "hp": hp,
        "latitude": latitude,
        "longtitude": longtitude,
        "status": status,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.taskId,
    this.url,
  });

  String? taskId;
  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        taskId: json["task_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "url": url,
      };
}
