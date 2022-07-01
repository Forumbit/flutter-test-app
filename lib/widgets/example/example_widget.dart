import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/example/example_model.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final _model = ExampleModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),
        centerTitle: true,
      ),
      body: ExampleWidgetProvider(
        model: _model,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Посты',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => ExampleWidgetProvider.read(context)?.model.getPosts(),
              child: const Text('Обновить посты'),
            ),
            const Expanded(child: _PostsWidget()),
          ],
        ),
      ),
    );
  }
}

class _PostsWidget extends StatelessWidget {
  const _PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: ExampleWidgetProvider.watch(context)?.model.posts.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _PostsRowWidget(index: index);
      },
    );
  }
}

class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleWidgetProvider.watch(context)!.model.posts[index];
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${post.id}'),
          Text(post.title),
          Text(post.body),
        ],
      ),
    );
  }
}
