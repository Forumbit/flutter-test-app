import 'dart:convert';

import 'package:flutter_test_app/entities/post.dart';
import 'package:http/http.dart' as http;
class ApiClient{
  
  Future<List<Post>> getPosts() async {
    final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);
    
    try {
      final jsonList = json.decode(response.body) as List<dynamic>;
      final posts = jsonList.map((e) => Post.fromJson(e)).toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}