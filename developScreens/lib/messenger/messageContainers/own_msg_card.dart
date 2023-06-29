

import 'package:flutter/material.dart';

import 'custom_tri.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.time,this.isSelected = false})
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
        padding: const EdgeInsets.fromLTRB(0,3,8,3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: const BoxDecoration(
                  color: Color(0xfffa5a50),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
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
            CustomPaint(painter: Triangle(const Color(0xfffa5a50))),
          ],
        ),
      ),
    );

  }
}