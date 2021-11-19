class GroupModel {
  final String? id;
  final String? admin;
  final String groupImageUrl;
  final String? groupName;
  final int? memberCount;

  GroupModel(
      {this.id,
      this.admin,
      required this.groupImageUrl,
      this.groupName,
      this.memberCount});

  factory GroupModel.fromMap(map) {
    return GroupModel(
        id: map['id'],
        admin: map['admin'],
        groupImageUrl: map['groupImageUrl'],
        groupName: map['groupName'],
        memberCount: map['memberCount']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'admin': admin,
      'groupImageUrl': groupImageUrl,
      'groupName': groupName,
      'memberCount': memberCount,
    };
  }
}
