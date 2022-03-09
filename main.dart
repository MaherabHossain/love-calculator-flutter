import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  return (runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myName = TextEditingController();
  final partnerName = TextEditingController();
  int? love;
  var loading = false;
  var myNameErr = false;
  var partnerNameErr = false;
  final formKey = GlobalKey<FormState>();
  void calculateLove() {
    // if (myName.text.isEmpty || partnerName.text.isEmpty) {
    //   if (myName.text.isEmpty) {
    //     setState(() {
    //       myNameErr = true;
    //     });
    //   }

    //   if (partnerName.text.isEmpty) {
    //     setState(() {
    //       partnerNameErr = true;
    //     });
    //   }
    //   if (myName.text.isEmpty == false) {
    //     setState(() {
    //       myNameErr = false;
    //     });
    //   }
    //   if (partnerName.text.isEmpty == false) {
    //     setState(() {
    //       partnerNameErr = false;
    //     });
    //   }
    //   return;
    // }
    // if (myName.text.isEmpty == false) {
    //   setState(() {
    //     myNameErr = false;
    //   });
    // }
    // if (partnerName.text.isEmpty == false) {
    //   setState(() {
    //     partnerNameErr = false;
    //   });
    // }
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        love = null;
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          loading = false;
          love = Random().nextInt(100);
        });
      });
      print(love);
    }
  }

  InputDecoration myInputDecoration(text, err) {
    return InputDecoration(
      hintText: text,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: myName,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'your name is required';
                    }
                    return null;
                  },
                  decoration: myInputDecoration('Your Name', myNameErr),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: partnerName,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'partner name is required';
                    }
                    return null;
                  },
                  decoration: myInputDecoration('Partner Name', partnerNameErr),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: calculateLove,
                  icon: Icon(Icons.favorite),
                  label: Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                ),
                if (loading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pink),
                  ),
                if (love != null)
                  Text(
                    '${myName.text} and ${partnerName.text} love percentage is $love %',
                    style: TextStyle(fontSize: 18),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
