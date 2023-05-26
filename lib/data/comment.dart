class Comment {
  int? id;
  String text;
  String date;
  int? parentId;

  Comment(
      {required this.id,
      required this.text,
      required this.date,
      required this.parentId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: int.tryParse(json['id']),
        text: json['text'],
        date: json['date'],
        parentId: int.tryParse(json['parentId'] ?? ""));
  }
}
