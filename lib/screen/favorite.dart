import 'package:flutter/material.dart';
import 'package:sub_space/model/blog.dart';
import 'package:sub_space/widget/blogTile.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Blog> blogs = [];

  readBlogs() async {
    sql.Database db = await sql.openDatabase('sub_space.db');
    try {
      var res = await db.query("favorite");
      List<Blog> blogsData =
          res.map<Blog>((json) => Blog.fromJson(json)).toList();
      setState(() {
        blogs = blogsData;
      });
    } catch (e) {
      print(e);
    }
    print(db);
  }

  @override
  void initState() {
    readBlogs();
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
        ),
        body: ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, position) =>
                BlogTile(blog: blogs[position])));
  }
}
