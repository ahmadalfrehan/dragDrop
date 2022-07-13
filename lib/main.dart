import 'package:drag_and_drop/anotheDragDrop/AnotherDragDrop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = ScrollController();

  void scroll() {
    if (controller.hasClients) {
      controller.animateTo(
          duration: Duration(seconds: 2),
          controller.position.maxScrollExtent,
          curve: Curves.easeIn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    final showDraggable = color == Colors.black;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Draggable<Color>(
                data: Colors.green,
                onDragCompleted: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AnotherDragDrop(),
                    ),
                  );
                },
                childWhenDragging: Container(
                  color: Colors.red,
                  height: 200,
                  width: 200,
                ),
                feedback: Container(
                  color: Colors.green,
                  height: 200,
                  width: 200,
                ),
                child: Container(
                  color: Colors.orange,
                  height: 200,
                  width: 200,
                ),
              ),
              DragTarget<Color>(
                onAccept: (data) => setState(() {
                  color = data;
                }),
                builder: (context, _, __) => Container(
                  color: Colors.red,
                  height: 200,
                  width: 200,
                ),
              ),
              IgnorePointer(
                ignoring: !showDraggable,
                child: Opacity(
                  opacity: showDraggable ? 1 : 0,
                  child: Draggable<Color>(
                    data: Colors.green,
                    childWhenDragging: Container(
                      color: Colors.red,
                      height: 200,
                      width: 200,
                    ),
                    feedback: Container(
                      color: Colors.orange,
                      height: 200,
                      width: 200,
                    ),
                    child: Container(
                      color: Colors.green,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
