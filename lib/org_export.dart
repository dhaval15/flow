import 'package:flutter/material.dart';

class Project {
  final String name;
  final String outputPath;
  final List<Article> articles;

  const Project({
    required this.name,
    required this.outputPath,
    required this.articles,
  });
}

class Article {
  final OrgPath path;
  final List<String> tags;
  final DateTime date;
  final String author;

  const Article({
    required this.path,
    required this.tags,
    required this.date,
    required this.author,
  });
}

class OrgPath {}

class OrgExportEngine {
  String exportToHtml(Article article) {
    return '';
  }
}

class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
