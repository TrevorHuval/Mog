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
      message: caption,
      media: media,
      mediaURL: mediaURL,
      profileImage: profileImage);
}

class _Post extends State<Post> {
  String name;
  String username;
  String message;
  bool media;
  String mediaURL;
  String profileImage;
  _Post(
      {required this.name,
      required this.username,
      required this.message,
      required this.media,
      required this.mediaURL,
      required this.profileImage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (media == false) {
        return Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(" | "),
                          Text(
                            username,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          message,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container(
          height: 300,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(" | "),
                          Text(
                            username,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          message,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                        child: Container(
                          height: 200,
                          width: 275,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(mediaURL),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
