class Sensor {
  final int value;
  final String date;
  final String color;

  Sensor(this.value, this.date, this.color);

  Sensor.fromMap(Map<String, dynamic> map)
      : assert(map['value'] != null),
        assert(map['date'] != null),
        assert(map['color'] != null),
        value = map['value'],
        date = map['date'],
        color=map['color'];
}