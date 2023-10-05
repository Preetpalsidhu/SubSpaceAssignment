import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sub_space/blogDetail.dart';
import 'package:sub_space/model/blog.dart';

var blogs;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeData(
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = [];

  void fetchBlogs() async {
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
        blogs = rest.map<Blog>((json) => Blog.fromJson(json)).toList();
        print(blogs.length);
        setState(() {
          list = blogs;
        });
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () async {
      fetchBlogs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(51, 51, 51, 1),
          title: Text("SubSpace"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ListView.builder(itemBuilder: (context, position) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlogDetail(
                              blog: list[position],
                            ))),
                child: Card(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          '${list[position].imageUrl}',
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          title: Text(
                            '${list[position].title}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
