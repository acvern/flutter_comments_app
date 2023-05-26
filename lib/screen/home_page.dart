import 'package:flutter/material.dart';
import 'package:flutter_comments_app/data/comments_controller.dart';

import 'comments_list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  CommentsController commentsController;

  _MyHomePageState() : commentsController = CommentsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: commentsController.isLoaded,
          builder: (context, value, child) {
            return Visibility(
              visible: value,
              replacement: const CircularProgressIndicator(),
              child: CommentsListView(
                commentDisplayInfo: commentsController.commentsDisplayInfo,
              ),
            );
          },
        ),
      ),
    );
  }
}
