class DroneModel {
  String? id;
  String? batteryLevel;
  dynamic lat;
  dynamic long;
  String? state;
  String? weather;
  String? streamUrl;

  DroneModel({this.id, this.state, this.lat, this.long, this.batteryLevel, this.streamUrl, this.weather});

  DroneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batteryLevel = json['batteryLevel'];
    lat = json['lat'];
    long = json['long'];
    state = json['state'];
    weather = json['weather'];
    streamUrl = json['streamUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batteryLevel'] = batteryLevel;
    data['lat'] = lat;
    data['long'] = long;
    data['state'] = state;
    data['weather'] = weather;
    data['streamUrl'] = streamUrl;

    return data;
  }
}