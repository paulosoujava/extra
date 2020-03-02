import 'package:extra/entity/profile.dart';
import 'package:extra/utils/event_bus.dart';

class ExtraJob extends Event {
  String description;
  String where;
  String actionEvent;

  ExtraJob({this.description, this.where, this.actionEvent } );



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['where'] = this.where;
    return data;
  }

  ExtraJob.fromJson(Map<String, dynamic> json) {
    description =json['description'];
    where = json['where'];
  }

  @override
  String toString() {
    return 'ExtraJob{description: $description, where: $where, actionEvent: $actionEvent}';
  }

}
