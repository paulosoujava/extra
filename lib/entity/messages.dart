class Message{
  String id;
  String message;
  String dateCreate;


  Message({this.id, this.message,  this.dateCreate});

  @override
  String toString() {
    return 'Message{message: $message, dateCreate: $dateCreate}';
  }
  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    dateCreate = json['dateCreate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['dateCreate'] = this.dateCreate;
    return data;
  }
}