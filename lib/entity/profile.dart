import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/talks.dart';
import 'package:extra/utils/consts.dart';
import 'dart:convert' as convert;

import 'package:extra/utils/prefs.dart';

class Profile {
  bool isDataOk;
  String id;
  String name;
  String email;
  String phone;
  String city;
  String state;
  String urlPhoto;
  String oldUrlPhoto;
  String pathPhoto;
  String mainFunction;
  String filter;
  List<Talks> talks;
  List<ExtraJob> extras;
  String description;

  bool isReported;
  String month;
  int limit;

  Profile(
      {this.id,
      this.isDataOk,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.state,
      this.urlPhoto,
      this.oldUrlPhoto,
      this.pathPhoto,
      this.mainFunction,
      this.talks,
      this.description,
      this.filter,
      this.isReported,
      this.month,
      this.limit});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDataOk = json['isDataOk'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    filter = json['filter'];
    state = json['state'];
    urlPhoto = json['urlPhoto'];
    oldUrlPhoto = json['oldUrlPhoto'];
    pathPhoto = json['pathPhoto'];
    mainFunction = json['mainFunction'];
    description = json['description'];
    month = json['month'];
    extras = json["extras"] != null
        ? json["extras"]
            .map<ExtraJob>((json) => ExtraJob.fromJson(json))
            .toList()
        : null;
    talks = json["talks"] != null
        ? json["talks"].map<Talks>((json) => Talks.fromJson(json)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isDataOk'] = this.isDataOk;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['state'] = this.state;
    data['filter'] = this.filter;
    data['urlPhoto'] = this.urlPhoto;
    data['oldUrlPhoto'] = this.oldUrlPhoto;
    data['pathPhoto'] = this.pathPhoto;
    data['mainFunction'] = this.mainFunction;
    data['description'] = this.description;
    data['month'] = this.month;
    data['talks'] = this.talks;
    data['extras'] = this.extras;
    print(data);
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString(Consts.KEY_PREFS_PROFILE, json);
  }

  static Future<Profile> get() async {
    String json = await Prefs.getString(Consts.KEY_PREFS_PROFILE);
    if (json.isEmpty) {
      return null;
    }
    Map map = convert.json.decode(json);
    Profile user = Profile.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'Profile{id: $id, isDataOk: $isDataOk, name: $name, email: $email, phone: $phone, city: $city, state: $state, urlPhoto: $urlPhoto, oldUrlPhoto: $oldUrlPhoto, pathPhoto: $pathPhoto, mainFunction: $mainFunction, filter: $filter, talks: $talks, extras: $extras, description: $description, isReported: $isReported, month: $month, limit: $limit}';
  }
}
