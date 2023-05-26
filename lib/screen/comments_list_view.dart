import 'package:flutter/material.dart';
import 'package:flutter_comments_app/data/comment_display_info.dart';

class CommentsListView extends StatelessWidget {
  final List<CommentDisplayInfo> commentDisplayInfo;
  const CommentsListView({super.key, required this.commentDisplayInfo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: commentDisplayInfo.length,
      itemBuilder: (context, index) {
        var comment = commentDisplayInfo[index];
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: (comment.depth == 0 ? 16 : 0)),
          Text("${"-" * comment.depth} ${comment.text} ${comment.date}"),
        ]);
      },
    );
  }
}
