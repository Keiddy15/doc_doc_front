import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.fullName,
        required this.age,
        required this.email,
        required this.photoUrl,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String fullName;
    int age;
    String email;
    String photoUrl;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        age: json["age"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "age": age,
        "email": email,
        "photoUrl": photoUrl,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
