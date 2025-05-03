
class GroupChatMember {
  final String name;
  final String? profilePicture;
  final String email;

  GroupChatMember({
    required this.name,
    this.profilePicture,
    required this.email,
  });

  factory GroupChatMember.fromJson(Map<String, dynamic> json) {
    return GroupChatMember(
      name: json['name'],
      profilePicture: json['profilePicture'],
      email: json['email'],
    );
  }
}

class GroupChatResponse {
  final List<GroupChatMember> doctors;
  final List<GroupChatMember> students;

  GroupChatResponse({
    required this.doctors,
    required this.students,
  });

  factory GroupChatResponse.fromJson(Map<String, dynamic> json) {
    final members = json['groupMembers'];
    return GroupChatResponse(
      doctors: List<GroupChatMember>.from(
        members['doctors'].map((d) => GroupChatMember.fromJson(d)),
      ),
      students: List<GroupChatMember>.from(
        members['students'].map((s) => GroupChatMember.fromJson(s)),
      ),
    );
  }
}
