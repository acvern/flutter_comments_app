import 'dart:convert';

import 'package:http/http.dart' as http;
import '../data/comment.dart';
import 'dart:async';

const endpointUrl =
    "https://73gkrtj6czzvfstwuslm2ipayi0zjotu.lambda-url.ca-central-1.on.aws/";

Future<Map<int, Comment>> getComments() async {
  var response = await http.get(Uri.parse(endpointUrl));
  Map<int, Comment> responseMap = {};
  if (response.statusCode == 200) {
    var responseJson = jsonDecode(response.body);
    responseJson.forEach((entry) {
      var id = int.tryParse(entry['id']);
      if (id != null) {
        responseMap.putIfAbsent(
            id, () => Comment.fromJson(entry as Map<String, dynamic>));
      }
    });
  }
  return responseMap;
}
