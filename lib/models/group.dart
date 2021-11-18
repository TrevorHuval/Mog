class GroupModel {
  final String? id;
  final String? admin;
  final String groupImageUrl;
  final String? groupName;

  GroupModel(
      {this.id, this.admin, required this.groupImageUrl, this.groupName});

  factory GroupModel.fromMap(map) {
    return GroupModel(
        id: map['id'],
        admin: map['admin'],
        groupImageUrl: map['groupImageUrl'],
        groupName: map['groupName']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'admin': admin,
      'groupImageUrl': groupImageUrl,
      'groupName': groupName
    };
  }
}
