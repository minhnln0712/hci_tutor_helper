import 'package:flutter/material.dart';

class ActiveProjectsCard extends StatelessWidget {
  final Color cardColor;
  final String name;
  final String subject;
  final String grade;

  ActiveProjectsCard({
    this.cardColor,
    this.name,
    this.subject,
    this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
        height: 120,
        width: 400,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  grade,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
