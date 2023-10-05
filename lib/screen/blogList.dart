import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sub_space/screen/blogDetail.dart';
import 'package:sub_space/screen/favorite.dart';
import 'package:sub_space/model/blog.dart';
import 'package:sub_space/widget/blogTile.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});
  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List<Blog> blogs = [];
  bool isLoading = true;

  apiCall() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        var data = json.decode(response.body);
        var rest = data["blogs"] as List;
        List<Blog> blogsData =
            rest.map<Blog>((json) => Blog.fromJson(json)).toList();
        setState(() {
          isLoading = false;
          blogs = blogsData;
        });
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        "Server Error. Please try again later",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () =>
                              {apiCall(), Navigator.of(context).pop()},
                          child: Text("Retry"))
                    ]);
                  }));
            });
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      "Error!!!!    Please Check your internet connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                        onPressed: () =>
                            {apiCall(), Navigator.of(context).pop()},
                        child: Text("Retry"))
                  ]);
                }));
          });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    apiCall();
    // Provider<>().func
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 51, 51, 1),
        title: Image.asset(
          'assets/logo.PNG',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Favorite())),
              child: Text("Favorite"))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, position) =>
                      BlogTile(blog: blogs[position])),
            ),
    );
  }
}
