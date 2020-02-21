class Message{
  String message;
  String dateCreate;

  Message({this.message,  this.dateCreate});

  @override
  String toString() {
    return 'Message{message: $message, dateCreate: $dateCreate}';
  }


}