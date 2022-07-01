import 'package:flutter/material.dart';

import '../../api_clients/api_client.dart';
import '../../entities/post.dart';

class ExampleModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> getPosts() async {

    _posts += await apiClient.getPosts();
    notifyListeners();
  }
}

class ExampleWidgetProvider extends InheritedNotifier {
  final ExampleModel model;
  const ExampleWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ExampleWidgetProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleWidgetProvider>();
  }

  static ExampleWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleWidgetProvider>()
        ?.widget;
    return widget is ExampleWidgetProvider ? widget : null;
  }
}
