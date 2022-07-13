import 'package:flutter/material.dart';

class AnotherDragDrop extends StatefulWidget {
  const AnotherDragDrop({Key? key}) : super(key: key);

  @override
  State<AnotherDragDrop> createState() => _AnotherDragDropState();
}

class _AnotherDragDropState extends State<AnotherDragDrop> {
  double height = 70, width = 70, x = 0, y = 0.1;
  AppBar? appBar;

  Widget draggable(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Draggable(
        feedback: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
          child: const Center(
            child:  Text(''),
          ),
        ),
        onDragCompleted: () {
          if (x == y) {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: const Text('You Win'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text('undo'),
                  ),
                ],
              ),
            );
            x = 0;
            y = 1;
          } else {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: const Text('Game Over Try Again'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text('undo'),
                  ),
                ],
              ),
            );
            x = 0;
            y = 1;
          }
        },
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(
            () {
              x = dragDetails.offset.dx;
              y = dragDetails.offset.dy -
                  appBar!.preferredSize.height -
                  MediaQuery.of(context).padding.top;
            },
          );
        },
        child: circle(),
      ),
    );
  }

  Widget circle() {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange,
      ),
      child: const Center(
        child:  Text('Drag'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appBar = AppBar(
      elevation: 0,
      title: const Text('Drag'),
    );
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          draggable(context),
          Positioned(
            left: y,
            bottom: x,
            child: circle(),
          )
        ],
      ),
    );
  }
}
