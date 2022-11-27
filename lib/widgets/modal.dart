import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final String title;
  final Widget child;
  const Modal({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 8),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
