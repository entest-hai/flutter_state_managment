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
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      'Top Rate',
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w700),
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
                            fontFamily: "Roboto",
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1"),
                    demoTopRateDr(Assets.doctors.dr1.path, "Dr. Hai Tran",
                        "Heart Surgeon", "4.1")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoTopRateDr(
      String image, String name, String speciality, String rating) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemDetailsPage()));
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset(image),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Color(0xff363636),
                            fontSize: 17,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              speciality,
                              style: TextStyle(
                                  color: Color(0xffababab),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 3, left: size.width * 0.25),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  "Rating",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'),
                                )),
                                Container(
                                  child: Text(
                                    rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))
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

class ItemDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemDetailsState();
  }
}

class _ItemDetailsState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [],
    ));
  }
}
