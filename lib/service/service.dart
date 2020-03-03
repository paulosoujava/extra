import 'package:extra/entity/messages.dart';
import 'package:extra/entity/profile.dart';

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

  getProfiles() async {
    List<Profile> list = [];
    list.add(await Profile.get());
    String url =
        "https://avatarfiles.alphacoders.com/130/thumb-130910.png";
    String url1 = "https://play.fiba3x3.com/static/ebdad75b-9fa5-4397-981f-045b76eceb2c/img/default-icons/profile-male.png";
    String url3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTJmGp7FtDK-a2cNE5zQJ2UcQ-TSrAw_L1fQXV4xpzYnmJ-Fies";
    list.add(Profile(
        name: "JOSE",
        urlPhoto: url,
        isMe: false,
        mainFunction: "Pedreiro",
        state: "RJ",
        email: "e@e.com",
        description: "teste",
        phone: "0000",
        city: "city",
        isDataOk: true));
    list.add(Profile(
        name: "Adailson",
        isMe: false,
        urlPhoto: url1,
        mainFunction: "Pintor",
        state: "SP",
        email: "e@e.com",
        description: "teste",
        phone: "0000",
        city: "city",
        isDataOk: true));
    list.add(Profile(
        name: "AMADEUS",
        isMe: false,
        urlPhoto: url3,
        mainFunction: "Custureiro",
        state: "RS",
        email: "e@e.com",
        description: "teste",
        phone: "0000",
        city: "city",
        isDataOk: true));
    list.add(Profile(
        name: "BERTOLDO",
        isMe: false,
        urlPhoto: url,
        mainFunction: "Servente",
        state: "PA",
        email: "e@e.com",
        description: "teste",
        phone: "0000",
        city: "city",
        isDataOk: true));
    list.add(Profile(
        name: "JUCELINO",
        isMe: false,
        urlPhoto: url1,
        mainFunction: "Carpinteiro",
        state: "ES",
        email: "e@e.com",
        description: "teste",
        phone: "0000",
        city: "city",
        isDataOk: true));
    return list;
  }
}
