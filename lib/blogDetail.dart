import 'package:flutter/material.dart';
import 'package:sub_space/model/blog.dart';

class BlogDetail extends StatelessWidget {
  BlogDetail({super.key, required this.blog});
  @override
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.PNG'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.favorite))
        ],
      ),
      body: Column(
        children: [
          ListTile(title: Text(blog.title)),
          Image.network(blog.imageUrl)
        ],
      ),
    );
  }
}
