class UserModel {
  final String? id;
  final String? username;
  final String profileImageUrl;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? feet;
  final int? inches;
  final int? weight;
  final String? sex;
  final int? benchPR;
  final int? squatPR;
  final int? deadliftPR;
  bool? inGroup;

  UserModel(
      {this.id,
      this.username,
      required this.profileImageUrl,
      this.firstName,
      this.lastName,
      this.email,
      this.feet,
      this.inches,
      this.weight,
      this.sex,
      this.benchPR,
      this.squatPR,
      this.deadliftPR,
      this.inGroup});

  factory UserModel.fromMap(map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      profileImageUrl: map['profileImageUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      feet: map['feet'],
      inches: map['inches'],
      weight: map['weight'],
      sex: map['sex'],
      inGroup: map['inGroup'],
      benchPR: map['benchPR'],
      squatPR: map['squatPR'],
      deadliftPR: map['deadliftPR'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'feet': feet,
      'inches': inches,
      'weight': weight,
      'sex': sex,
      'inGroup': inGroup,
      'benchPR': benchPR,
      'squatPR': squatPR,
      'deadliftPR': deadliftPR,
    };
  }
}
