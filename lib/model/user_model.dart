class UsersModel {
  List<UserModel>? userModel;

  UsersModel({this.userModel});

  UsersModel.fromJson(Map<String, dynamic> json) {
    if (json['userModel'] != null) {
      userModel = <UserModel>[];
      json['userModel'].forEach((v) {
        userModel!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userModel != null) {
      data['userModel'] = userModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  String? key;
  String? name;
  String? email;
  dynamic location;
  dynamic embeddings;
  dynamic distance;
  String? checkIn;
  String? checkOut;

  UserModel(
      {this.key,
      this.name,
      this.email,
      this.location,
      this.embeddings,
      this.distance,
      this.checkIn,
      this.checkOut});

  UserModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    embeddings = json['embeddings'];
    distance = json['distance'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key ?? "";
    data['name'] = this.name ?? "";
    data['email'] = this.email ?? "";
    data['location'] = this.location;
    data['embeddings'] = this.embeddings ?? [];
    data['distance'] = this.distance ?? 0.0;
    data['checkIn'] = this.checkIn ?? "";
    data['checkOut'] = this.checkOut ?? "";
    return data;
  }
}
