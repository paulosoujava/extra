import 'package:extra/entity/messages.dart';
import 'package:extra/entity/talks.dart';

class Profile {
  String id;
  String name;
  String email;
  String phone;
  String city;
  String state;
  String urlPhoto;
  String mainFunction;
  List<String> othersFunctions;
  List<Talks> talks;
  String description;

  bool isReported;
  String month;
  int limit;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.state,
      this.urlPhoto,
      this.mainFunction,
      this.othersFunctions,
      this.talks,
      this.description,
      this.isReported,
      this.month,
      this.limit});

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, email: $email, phone: $phone, city: $city, state: $state, urlPhoto: $urlPhoto, mainFunction: $mainFunction, othersFunctions: $othersFunctions, talks: $talks, description: $description, isReported: $isReported, month: $month, limit: $limit}';
  }


}
