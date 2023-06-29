

import 'package:developscreens/messenger/messageContainers/custom_tri.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key, required this.message, required this.time,this.isSelected = false})
      : super(key: key);
  final String message;
  final String time;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final containerColor = isSelected ? Colors.blue : Colors.transparent;
    return Container(
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8,3,0,3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: Triangle(Colors.grey.shade400),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(19),
                    bottomLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 60,
                    minWidth: 100,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 45,
                          top: 5,
                          bottom: 20,
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 10,
                        child: Row(
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.done_all,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
