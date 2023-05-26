class Comment {
  int? id;
  String text;
  String dateText;
  DateTime? date;
  int? parentId;

  Comment(
      {required this.id,
      required this.text,
      required this.dateText,
      required this.parentId})
      : date = _parseCommentDate(dateText);

  static DateTime? _parseCommentDate(String date) {
    date = date.replaceAll(RegExp(r'/'), '-');
    return DateTime.tryParse(date);
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: int.tryParse(json['id']),
        text: json['text'],
        dateText: json['date'],
        parentId: int.tryParse(json['parentId'] ?? ""));
  }
}
