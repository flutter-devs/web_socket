import 'package:flutter/material.dart';

class BubbleWidget extends StatefulWidget {
  final dynamic text;

  const BubbleWidget({Key? key, required this.text}) : super(key: key);

  @override
  BubbleWidgetState createState() => BubbleWidgetState();
}

class BubbleWidgetState extends State<BubbleWidget> {
  String? _currentData;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Data${widget.text.toString()}");
    _currentData = widget.text.toString();
    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      // bottom: _currentData != null ? 50.0 : -100.0,
      // right: _currentData != null ? 50.0 : -100.0,
      child: Opacity(
        opacity: _currentData != null ? 1.0 : 0.0,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(spreadRadius: 0, offset: Offset(3, 3))
            ],
            gradient: const LinearGradient(colors: [
              Color(0xff675b26),
              Color(0xffbea748),
              Color(0xff675b26)
            ]),

            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(_currentData ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
