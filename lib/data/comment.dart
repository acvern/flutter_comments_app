class Comment {
  int id;
  String text;
  DateTime date;
  int? parentId;

  Comment(
      {required this.id,
      required this.text,
      required this.date,
      required this.parentId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        text: json['text'],
        date: json['date'],
        parentId: json['parentId']);
  }
}
