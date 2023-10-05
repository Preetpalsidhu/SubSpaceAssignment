import 'package:flutter/material.dart';
import 'package:sub_space/screen/blogDetail.dart';
import 'package:sub_space/model/blog.dart';

class BlogTile extends StatelessWidget {
  const BlogTile({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogDetail(
                      blog: blog,
                    ))),
        child: Card(
          color: Color.fromRGBO(51, 51, 51, 1),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  blog.imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .25,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: Text(
                    blog.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
