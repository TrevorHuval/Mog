import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Post extends StatefulWidget {
  String name;
  String username;
  String caption;
  bool media;
  String mediaURL;
  String profileImage;

  Post(
      {required this.name,
      required this.username,
      required this.caption,
      required this.media,
      required this.mediaURL,
      required this.profileImage});

  @override
  _Post createState() => _Post(
      name: name,
      username: username,
      caption: caption,
      media: media,
      mediaURL: mediaURL,
      profileImage: profileImage);
}

class _Post extends State<Post> {
  String name;
  String username;
  String caption;
  bool media;
  String mediaURL;
  String profileImage;
  _Post(
      {required this.name,
      required this.username,
      required this.caption,
      required this.media,
      required this.mediaURL,
      required this.profileImage});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(" | "),
          Text(
            username,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(caption, style: TextStyle(color: Colors.black)),
          media == false
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(image: AssetImage(mediaURL)),
                  ))
        ],
      ),
    );
  }
}
