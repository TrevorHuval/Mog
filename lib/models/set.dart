class SetModel {
  final String? id;
  final String? sets;
  final String? reps;
  final String? weight;

  SetModel({this.id, this.sets, this.reps, this.weight});

  factory SetModel.fromMap(map) {
    return SetModel(
        id: map['id'],
        sets: map['sets'],
        reps: map['reps'],
        weight: map['weight']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'sets': sets, 'reps': reps, 'weight': weight};
  }
}
