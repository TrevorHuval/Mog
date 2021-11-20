class GroupModel {
  final String? id;
  final String groupImageUrl;
  final String? groupName;
  final int? memberCount;

  GroupModel(
      {this.id, required this.groupImageUrl, this.groupName, this.memberCount});

  factory GroupModel.fromMap(map) {
    return GroupModel(
        id: map['id'],
        groupImageUrl: map['groupImageUrl'],
        groupName: map['groupName'],
        memberCount: map['memberCount']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupImageUrl': groupImageUrl,
      'groupName': groupName,
      'memberCount': memberCount,
    };
  }
}
