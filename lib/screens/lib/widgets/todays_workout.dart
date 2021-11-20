import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/screens/diary.dart';
import 'package:intl/intl.dart';


class todaysWorkout extends StatefulWidget {
  const todaysWorkout({Key? key}) : super(key: key);

  @override
  _todaysWorkout createState() => _todaysWorkout();
}

class _todaysWorkout extends State<todaysWorkout> {

  DateTime day = DateTime.now();
  String? userSet;

  // class getDay(){
  //   String dayFormat = DateFormat('EEEE').format(day);
  //   setState(() {
  //     if (dayFormat == 'Monday'){
  //       if (userSet == 'Arnold'){
  //         Widget build(BuildContext context){
  //           return Container(
  //            child: Row(
  //                 children: [
  //                   Container(
  //                       width: 75,
  //                       height: 75,
  //                       margin: EdgeInsets.symmetric(horizontal: 5),
  //                       decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: Colors.white,
  //                           image: DecorationImage(
  //                               fit: BoxFit.cover,
  //                               image: AssetImage(
  //                                   'assets/images/chestTargetMuscle.jpg')))),
  //                   Container(
  //                       width: 75,
  //                       height: 75,
  //                       margin: EdgeInsets.symmetric(horizontal: 5),
  //                       decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: Colors.white,
  //                           image: DecorationImage(
  //                               fit: BoxFit.cover,
  //                               image: AssetImage(
  //                                   'assets/images/backTargetMuscle.jpg')))),
  //                   Container(
  //                     height: 50,
  //                     width: 150,
  //                     child: FittedBox(
  //                       fit: BoxFit.fitWidth,
  //                       child: Text("Chest and Back",
  //                           style: TextStyle(fontWeight: FontWeight.bold)))),
  //                 ],
  //               ),
  //         );
  //         }
          
  //       }
  //     } 
  //     else if (dayFormat == 'Tuesday'){
  //       return Text('Tuesday');
  //     }
  //     else if (dayFormat == 'Wednesday'){
  //       return Text('Tuesday');
  //     }
  //     else if (dayFormat == 'Thursday'){
  //       return Text('Tuesday');
  //     }
  //     else if (dayFormat == 'Friday'){
  //       return Text('Tuesday');
  //     }
  //     else if (dayFormat == 'Saturday'){
  //       return Text('Tuesday');
  //     }
  //     else (){
  //       return Text('Tuesday');};

  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 500,
      color: Colors.transparent,
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 75.0,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => diary(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                // Row(
                //   children: [
                    
                //     Container(
                //         width: 75,
                //         height: 75,
                //         margin: EdgeInsets.symmetric(horizontal: 5),
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: Colors.white,
                //             image: DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: AssetImage(
                //                     'assets/images/bicepTargetMuscle.jpg')))),
                //   ],
                // ),
                // Container(
                //     height: 50,
                //     width: 150,
                //     child: FittedBox(
                //         fit: BoxFit.fitWidth,
                //         child: Text("Back & Biceps",
                //             style: TextStyle(fontWeight: FontWeight.bold))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
