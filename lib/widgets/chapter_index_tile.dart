import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:linear_gradient/linear_gradient.dart';

class IndexTile extends StatelessWidget {
  final String chapterText;
  final Color chapterColor;
  IndexTile({this.chapterText, this.chapterColor});

  //Get a color options as a String from FireBase, turn it into Color class
  Color createColor(String color) {
    if (color == 'blue') {
      return Colors.blue;
    } else if (color == 'yellow') {
      return Colors.yellow;
    } else if (color == 'green') {
      return Colors.green;
    } else if (color == 'red') {
      return Colors.red;
    } else if (color == 'pink') {
      return Colors.pink;
    } else if (color == 'black') {
      return Colors.black;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FlatButton(
        onPressed: () {},
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              chapterText,
              style: Body1TextStyle.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}

// return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         //Title Card
//         GestureDetector(
//           onTap: () {
//             print('Clicked chapter');
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 left: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//                 top: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//                 bottom: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//               ),
//             ),
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: 40,
//             alignment: Alignment.centerLeft,
//             padding: EdgeInsets.only(left: 20.0),
//             child: Text(
//               chapterText,
//               style: Body1TextStyle.copyWith(color: Colors.black),
//             ),
//           ),
//         ),
//         //Gradient color
//         Container(
//           decoration: BoxDecoration(
//               border: Border(
//                 right: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//                 top: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//                 bottom: BorderSide(
//                     width: 2.0, color: Theme.of(context).primaryColor),
//               ),
//               gradient: LinearGradient(
//                   colors: [Colors.white, chapterColor], stops: [0.4, 0.7])),
//           width: MediaQuery.of(context).size.width * 0.1,
//           height: 40,
//         ),
//       ],
//     );
