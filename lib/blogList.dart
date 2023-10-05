import 'package:flutter/material.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key, required blog});
  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  var blog = [];

  apiCall() async {
    //var res = await
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, position) {
      return Card(
        child: Column(
          children: [
            ListTile(title: Text('${blog[position].title}')),
            Image.network('${blog[position].image_url}')
          ],
        ),
      );
    });
  }
}
