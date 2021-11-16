class UserModel {
  final String? id;
  final String? profileImageUrl;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? feet;
  final int? inches;
  final int? weight;
  final String? sex;
  bool inGroup = false;

  UserModel(
      {this.id,
      this.profileImageUrl,
      this.firstName,
      this.lastName,
      this.email,
      this.feet,
      this.inches,
      this.weight,
      this.sex,
      this.inGroup = false});

  factory UserModel.fromMap(map) {
    return UserModel(
      id: map['id'],
      profileImageUrl: map['profileImageUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      feet: map['feet'],
      inches: map['inches'],
      weight: map['weight'],
      sex: map['sex'],
      inGroup: map['inGroup'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileImageUrl': profileImageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'feet': feet,
      'inches': inches,
      'weight': weight,
      'sex': sex,
      'inGroup': inGroup,
    };
  }
}
