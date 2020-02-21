import 'package:extra/entity/messages.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/entity/talks.dart';
import 'package:extra/pages/chat.dart';
import 'package:extra/pages/tab_rede.dart';
import 'package:extra/pages/tab_conversation.dart';

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

  Profile getProfile() {
    return Profile(
        name: "Ricardo ",
        city: "Florianópolis",
        state: "SC",
        mainFunction:
            "Análista de sistemas e tecnólogias afins teste teste teste",
        urlPhoto: "assets/images/avatar.png",
        description:
            "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker");
  }
}
