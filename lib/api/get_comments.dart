import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/comment.dart';
import 'dart:async';

const endpointUrl =
    "https://73gkrtj6czzvfstwuslm2ipayi0zjotu.lambda-url.ca-central-1.on.aws/";

Future<Map<int, Comment>> getComments() async {
  var response = await http.get(Uri.parse(endpointUrl));
  Map<int, Comment> responseMap = {};
  if (response.statusCode == 200) {
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    responseJson.forEach((key, value) {
      responseMap.putIfAbsent(
          value['id'], () => Comment.fromJson(value as Map<String, dynamic>));
    });
  }
  debugPrint(response.body);
  return responseMap;
}
