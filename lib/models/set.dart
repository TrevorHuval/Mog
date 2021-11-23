class SetModel {
  final String? id;
  final int? numOfSets;
  final int? numOfReps;
  final int? weight;

  SetModel({this.id, this.numOfSets, this.numOfReps, this.weight});

  factory SetModel.fromMap(map) {
    return SetModel(
        id: map['id'],
        numOfSets: map['numOfSets'],
        numOfReps: map['numOfReps'],
        weight: map['weight']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numOfSets': numOfSets,
      'numOfReps': numOfReps,
      'weight': weight
    };
  }
}
