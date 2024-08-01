import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tesr_app/homepage.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  WebSocketChannel? channel;
  List<String> messages = [];
  bool isOn = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start fetching data every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        
      });
    });
  }

  final url = Uri.parse(
      'https://test2-4a122-default-rtdb.firebaseio.com/mydevice.json');
  Future<void> turnOnMyLamp(int value) async {
    var data = {'led2': value};

    var body = json.encode(data as Map<String, dynamic>);

    // Make the POST request
    var response = await http.patch(
      url,
      body: body,
    );
    if (value == 0) {
      setState(() {
        isOn = false;
      });
    } else {
      setState(() {
        isOn = true;
      });
    }
  }

  void onSwitch() {
    setState(() {
      if (isOn == false) {
        turnOnMyLamp(1);
      } else {
        turnOnMyLamp(0);
      }
    });
  }

  int? data;
  Future<int> fetchData() async {
    await http.get(url).then((response) {
      var data1 = json.decode(response.body);
      data = data1["led2"];
    });

    return data!;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<int>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.data == 0) {
            isOn = false;
            return Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                    top: 0,
                    child: Image.asset('assets/images/road.png', height: 120)),
                showBulb(width * 0.7),
                showButton(100),
              ],
            );
          } else {
            isOn = true;
            return Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                    top: 0,
                    child: Image.asset('assets/images/road.png', height: 120)),
                showBulb(width * 0.7),
                showButton(100),
              ],
            );
          }
        });
  }

  Positioned showButton(double width) {
    return Positioned(
        bottom: width,
        child: GestureDetector(
          onTap: onSwitch,
          child: Column(
            children: [
              Image.asset(
                isOn
                    ? 'assets/images/off_button.png'
                    : 'assets/images/on_button.png',
                width: 72,
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.transparent,
                child: Text(
                  isOn ? 'TURN OFF' : 'TURN ON',
                  style: TextStyle(
                      color: isOn ? Colors.grey : const Color(0xffffd600)),
                ),
              )
            ],
          ),
        ));
  }

  Positioned showBulb(double width) {
    return Positioned(
      top: 100,
      child: isOn
          ? Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 500,
                    spreadRadius: 1000,
                    offset: const Offset(0, 50),
                    color: const Color(0xffffd600).withOpacity(0.1)),
                BoxShadow(
                    blurRadius: 500,
                    spreadRadius: -10,
                    offset: const Offset(0, 50),
                    color: const Color(0xffffd600).withOpacity(0.3))
              ]),
              child: Image.asset('assets/images/on_bulb.png', width: width))
          : Image.asset('assets/images/off_bulb.png', width: width),
    );
  }

  Positioned showButtonnav(double width) {
    return Positioned(
        bottom: width,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              width: 150,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(
                      top: BorderSide(
                          width: 1.0, color: Color.fromARGB(235, 215, 120, 12)),
                      bottom: BorderSide(
                          width: 1.0, color: Color.fromARGB(235, 215, 120, 12)),
                      right: BorderSide(
                          width: 1.0, color: Color.fromARGB(235, 215, 120, 12)),
                      left: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(235, 215, 120, 12)))),
              child: Text(
                "pervious Led",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(235, 215, 120, 12)),
              ),
            )));
  }
}
