import 'package:flutter/material.dart';
import 'package:flutter_comments_app/api/get_comments.dart';

import 'comment.dart';
import 'comment_display_info.dart';

class CommentsController extends ChangeNotifier {
  final ValueNotifier<bool> _isLoaded = ValueNotifier(true);
  Map<int, Comment> _comments = {};
  Map<int, Set<int>> _commentsChildren = {};
  List<CommentDisplayInfo> _commentsDisplayInfo = [];

  ValueNotifier<bool> get isLoaded => _isLoaded;
  Map<int, Comment> get comments => _comments;
  Map<int, Set<int>> get commentsChildren => _commentsChildren;
  List<CommentDisplayInfo> get commentsDisplayInfo => _commentsDisplayInfo;

  CommentsController() {
    refresh();
  }

  void _findCommentsChildren() {
    var ids = comments.keys;
    _commentsChildren = {};
    for (var id in ids) {
      _commentsChildren.putIfAbsent(id, () => {});
      int? parentId = _comments[id]?.parentId;
      if (parentId != null) {
        _commentsChildren.putIfAbsent(parentId, () => {});
        _commentsChildren.update(parentId, (children) => children..add(id));
      }
    }
  }

  List<CommentDisplayInfo> _getCommentTree(
      {required int id, int depth = 0, List<CommentDisplayInfo>? resultList}) {
    resultList = resultList ?? [];
    resultList.add(CommentDisplayInfo(
      text: comments[id]?.text ?? "",
      date: comments[id]?.date ?? "",
      depth: depth,
    ));
    Set<int> children = commentsChildren[id] ?? {};
    if (children.isNotEmpty) {
      for (var childId in children) {
        resultList.addAll(_getCommentTree(
          id: childId,
          depth: depth + 1,
        ));
      }
    }
    return resultList;
  }

  void _getCommentsForDisplay() {
    _commentsDisplayInfo = [];
    var ids = commentsChildren.keys;
    for (var id in ids) {
      if (comments[id]?.parentId == null) {
        _commentsDisplayInfo.addAll(_getCommentTree(id: id));
      }
    }
  }

  Future<void> refresh() async {
    isLoaded.value = false;
    var commentsResponse = await getComments();
    if (commentsResponse.isNotEmpty) {
      _comments = commentsResponse;
    }
    _findCommentsChildren();
    _getCommentsForDisplay();
    isLoaded.value = true;
    notifyListeners();
  }
}
