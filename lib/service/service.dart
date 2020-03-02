import 'package:extra/entity/messages.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/entity/talks.dart';
import 'package:extra/pages/chat.dart';
import 'package:extra/pages/tab_rede.dart';
import 'package:extra/pages/tab_conversation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Service {
  load() {
    List<Message> message = List();
    message.add(
        Message(message: "Oi paulo", dateCreate: DateTime.now().toString()));
    message.add(Message(
        message:
            "ola jose, blz mano, tudo certo? como estas, quando vens aqui, vem logo pow, chega ai ta todo mundo aqui vem vem vem vem",
        dateCreate: DateTime.now().toString()));
    message.add(
        Message(message: "tudo bem? ", dateCreate: DateTime.now().toString()));
    message.add(Message(
        message: "tudo sim e com vc?", dateCreate: DateTime.now().toString()));
    message.add(
        Message(message: "bem tbm", dateCreate: DateTime.now().toString()));

    return message;
  }


  Chat getChats() {
    return Chat(Talks(profile: getProfile(), message: load() ) );
  }

   getProfile() {
     Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
   }
}
