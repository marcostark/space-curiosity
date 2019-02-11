import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        title: Text(post.title),
        subtitle: Text(post.body + "\n\n" + post.date),
        onTap: () {
          launch(
            post.url,
            forceSafariVC: true,
            forceWebView: true,
            statusBarBrightness: Theme.of(context).brightness,
          );
        },
      ),
    );
  }
}
