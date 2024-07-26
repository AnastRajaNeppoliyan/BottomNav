import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Blog({required this.scaffoldKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.cyan,
        child: Center(
          child: Text("Blog"),
        ),
      ),
    );
  }
}