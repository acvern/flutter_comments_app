import 'package:flutter/material.dart';
import 'package:flutter_comments_app/data/comment_display_info.dart';

class CommentsListView extends StatelessWidget {
  final List<CommentDisplayInfo> commentDisplayInfo;
  const CommentsListView({super.key, required this.commentDisplayInfo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(commentDisplayInfo[index].text);
      },
    );
  }
}
