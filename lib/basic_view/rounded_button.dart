import 'package:flutter/material.dart';

class BasicViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasicView(),
    );
  }
}

class BasicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Views"),),
      body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        RoundedButtonElevated(),
        SizedBox(height: 20,),
        RoundedButton(),
        SizedBox(height: 20,),
        RoundedButtonClip()
      ],),
      ),
    );
  }
}

class RoundedButtonElevated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text("Click"),
          ),
          onPressed: (){
            print("clicked me");
          },
        ),
      ),
    );
  }
}


class RoundedButtonClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
                child: FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40
          ),
          color: Colors.blue,
          onPressed: (){}, child: Text("Click", style: TextStyle(color: Colors.white),)),
      ),
    );;
  }
}

class RoundedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(29.0),
      ),
      width: size.width * 0.8,
      child: TextButton(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
              "Click",
               style: TextStyle(
                 color: Colors.white,
                fontWeight: FontWeight.bold,
      ),
      ),
        ), onPressed: (){
        print("clicked me");
      },
      ),
    );
  }
}