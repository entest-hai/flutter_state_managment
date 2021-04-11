import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

class WellComeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Auth",
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home: WellComeView(),);
  }
}

class WellComeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Background(child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("WELLCOME TO EDU", style: TextStyle(
          fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03,),
          SvgPicture.asset("assets/icons/chat.svg", height: size.height * 0.45,),
          SizedBox(height: size.height * 0.03,),
          RoundedButton(
            text: "LOGIN",
            press: (){},
          ),
          RoundedButton(
            color: kPrimaryLightColor,
            text: "LOGIN",
            press: (){},
            textColor: Colors.black,
          )
      ],),
    ),);
  }
}

class RoundedButton extends StatelessWidget {
  final String text; 
  final Function press; 
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
                child: FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40
          ),
          color: color,
          onPressed: press, child: Text(text, style: TextStyle(color: textColor),)),
      ),
    );
  }
}

class Background extends StatelessWidget {

  final Widget child;
  Background({
    Key key,
    @required this.child
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/images/main_top.png", width: size.width * 0.3),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images/main_bottom.png", width: size.width * 0.2,),
          ),
          child,
        ],
      ),
    );
  }
}