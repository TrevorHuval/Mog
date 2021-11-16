import 'package:firstapp/screens/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class groupPreview extends StatefulWidget {
  const groupPreview({Key? key}) : super(key: key);

  @override
  _groupPreview createState() => _groupPreview();
}

class _groupPreview extends State<groupPreview> {
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        color: Colors.transparent,
        child: Card(
          elevation: 0,
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Group()));
            },
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height:
                      15, // Creates margin inside the card for the group pic and name
                ),
                Expanded(
                    child: Row(children: <Widget>[
                  // Group Image
                  Container(
                      width: 125,
                      height: 125,
                      margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/images/gooberGroupPFP.jpg')))),
                  // Group Name
                  Container(
                    width: 175,
                    height: 75,
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Goober",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                ])),
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  separatorBuilder: (context, _) => SizedBox(width: 12),
                  itemBuilder: (context, index) => buildProfilePics(),
                )),
              ],
            ),
          ),
        ));
  }
}
