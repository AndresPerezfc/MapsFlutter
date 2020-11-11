import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CenteredMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            constraints: BoxConstraints(maxWidth: 250),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AutoSizeText(
                  "Google maps con Flutter",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4)
                ]),
              ),
              Container(
                width: 10,
                height: 10,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ],
          )
        ],
      ),
    );
  }
}
