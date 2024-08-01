import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tesr_app/homepage2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Future<void> turnOnMyLamp(int value) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "led1": value,
    });
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
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref();
    starCountRef.child('led1').onValue.listen((DatabaseEvent event) {
      setState(() {
        data = event.snapshot.value as int;
      });
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
                showButton(250),
                
                showButtonnav(100)

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
                showButton(250),
                showButtonnav(100)
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

  Positioned showButtonnav(double width) {
    return Positioned(
        bottom: width,
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage2() ));
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
              child: Center(
                child: Text(
                  "Next Led",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(235, 215, 120, 12)),
                ),
              ),
            )));
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
}
