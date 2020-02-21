import 'package:extra/entity/profile.dart';
import 'package:extra/entity/messages.dart';

class Talks{
  List<Message> message;
  Profile profile;

  Talks({this.message, this.profile});

  @override
  String toString() {
    return 'Talks{message: $message, profile: $profile}';
  }


}