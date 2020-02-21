import 'package:extra/entity/messages.dart';
import 'package:extra/entity/talks.dart';

class Profile {
  String id;
  String name;
  String city;
  String state;
  String urlPhoto;
  String mainFunction;
  List<String> othersFunctions;
  List<Talks> talks;
  String description;

  Profile({this.id, this.urlPhoto, this.name, this.city, this.state, this.mainFunction, this.othersFunctions, this.talks, this.description});

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, city: $city, state: $state, urlPhoto: $urlPhoto, mainFunction: $mainFunction, othersFunctions: $othersFunctions, talks: $talks, messageProfile: $description}';
  }


}
