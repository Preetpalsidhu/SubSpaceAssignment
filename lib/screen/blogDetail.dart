import 'package:flutter/material.dart';
import 'package:sub_space/screen/favorite.dart';
import 'package:sub_space/model/blog.dart';
import 'package:sqflite/sqflite.dart' as sql;

class BlogDetail extends StatefulWidget {
  BlogDetail({super.key, required this.blog});

  @override
  final Blog blog;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  favorite(String id, String title) async {
    sql.Database db = await sql.openDatabase('sub_space.db');

    String checkExistTable =
        "SELECT * FROM sqlite_master WHERE name ='favorite' and type='table'";
    List<dynamic> checkExist = await db.rawQuery(checkExistTable);
    if (checkExist.isEmpty) {
      await db.execute(
          'CREATE TABLE favorite (id TEXT PRIMARY KEY NOT NULL ,title TEXT, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    }

    try {
      var data = {
        'id': id,
        'title': title,
      };
      db.insert('favorite', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(51, 51, 51, 1),
          title: Image.asset(
            'assets/logo.PNG',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  favorite(widget.blog.id, widget.blog.title);
                },
                icon: Icon(Icons.favorite))
          ],
        ),
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
              child: Text(
                widget.blog.title,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(widget.blog.imageUrl),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Article text",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
