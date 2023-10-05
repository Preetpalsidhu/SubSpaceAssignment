class Blog {
  String id;
  String imageUrl;
  String title;

  Blog({required this.id, required this.imageUrl, required this.title});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      imageUrl: json['image_url'],
      title: json['title'],
    );
  }
}
