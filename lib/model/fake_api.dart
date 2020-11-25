// To parse this JSON data, do
//
//     final fakeApi = fakeApiFromJson(jsonString);

import 'dart:convert';

FakeApi fakeApiFromJson(String str) => FakeApi.fromJson(json.decode(str));

String fakeApiToJson(FakeApi data) => json.encode(data.toJson());

class FakeApi {
  FakeApi({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Ad ad;

  factory FakeApi.fromJson(Map<String, dynamic> json) => FakeApi(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        ad: Ad.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "ad": ad.toJson(),
      };
}

class Ad {
  Ad({
    this.company,
    this.url,
    this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        company: json["company"],
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "url": url,
        "text": text,
      };
}

class Datum {
  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
