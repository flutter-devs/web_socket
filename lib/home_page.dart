
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_flutter/widgets/bubble.dart';

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;

  const MyHomePage({super.key, required this.channel});

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  TextEditingController textController = TextEditingController();
  Color color = const Color(0xff675b26);
  String appTitle = "Web Socket Flutter";
  GlobalKey<BubbleWidgetState> _bubbleKey = GlobalKey<BubbleWidgetState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Image.asset("assets/images/bg-image.jpg", fit: BoxFit.fill)),
        Scaffold(
          appBar: AppBar(
            backgroundColor: color,
            title: Center(child: Text(appTitle)),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  child: TextFormField(
                    controller: textController,
                    cursorColor: color,
                    style: TextStyle(color: color, fontWeight: FontWeight.w700),
                    onChanged: (text) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Type your message here!",
                      labelStyle:
                      TextStyle(color: color, fontWeight: FontWeight.w500),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 2, offset: Offset(5, 5))
                          ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27, vertical: 13),
                      child: const Text('Send Message',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                    ),
                  ),
                ),
                const Spacer(),
                StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {
                    print(
                        "##################${snapshot.data}###########################");
                    return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Stack(
                            children: [
                              BubbleWidget(
                                key: _bubbleKey,
                                text: snapshot.data ?? '',
                              ),
                            ],
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _sendMessage() {
    if (textController.text.isNotEmpty) {
      try {
        widget.channel.sink.add(textController.text);
        print("${widget.channel.stream.length}");
      } catch (e) {
        print("Error: $e");
      }
      setState(() {});
      textController.clear();
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    _animationController.dispose();
    super.dispose();
  }
}
