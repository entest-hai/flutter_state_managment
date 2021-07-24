import 'package:flutter/material.dart';
import 'package:flutter_provider/gen/assets.gen.dart';

class DoctorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xff053F5E)),
      home: DoctorHomePage(),
    );
  }
}

class DoctorHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DoctorState();
  }
}

class _DoctorState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications_rounded, color: Colors.white),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(Assets.doctors.profileImg.path),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Hi Hai Tran",
                style: TextStyle(color: Color(0xff363636), fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff14880),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 0,
                    )
                  ]),
              height: 60,
              width: size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        maxLines: 1,
                        autofocus: false,
                        style: TextStyle(
                          color: Color(0xff107163),
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff107163),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              width: size.width,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      "Category",
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 20, top: 1),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "See all",
                          style: TextStyle(
                              color: Color(0xff363636),
                              fontSize: 19,
                              fontFamily: "Roboto"),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              height: 130,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                  demoCategories(
                      Assets.doctors.tooth.path, "Tooth", "18 Doctors"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoCategories(String image, String name, String drQuality) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 100,
      decoration: BoxDecoration(
        color: Color(0xff187163),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(child: Image.asset(image)),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Color(0xffd9fffa).withOpacity(0.07),
            ),
            child: Text(
              drQuality,
              style: TextStyle(
                  color: Colors.white, fontSize: 8, fontFamily: "Roboto"),
            ),
          )
        ],
      ),
    );
  }
}
