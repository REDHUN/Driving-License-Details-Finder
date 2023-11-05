import 'package:drivinglicensedetails/widgets/fourlicense.dart';
import 'package:drivinglicensedetails/widgets/licensecard.dart';
import 'package:drivinglicensedetails/widgets/threelicensecard.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  UserDetails(
      {super.key,
      required this.name,
      required this.empcode,
      required this.twolicenseno,
      required this.twolicensfrom,
      required this.twolicensto,
      required this.threelicenseno,
      required this.threelicensfrom,
      required this.threelicensto,
      required this.fourlicenseno,
      required this.fourlicensfrom,
      required this.fourlicensto});
  final String name;
  final String empcode;

  final String twolicenseno;
  final String twolicensfrom;
  final String twolicensto;

  final String threelicenseno;
  final String threelicensfrom;
  final String threelicensto;

  final String fourlicenseno;
  final String fourlicensfrom;
  final String fourlicensto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                    )
                  ]),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.bar_chart),
                        Icon(Icons.more_vert),
                      ],
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/profile.png",
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: ((MediaQuery.of(context).size.width) - 40) * 0.6,
                      child: Column(children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          empcode,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "License Details",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LicenseCard(
                twolicenseno: twolicenseno,
                twolicensefrom: twolicensfrom,
                twolicenseto: twolicensto),
            SizedBox(
              height: 10,
            ),
            ThreeLicenseCard(
                threelicenseno: threelicenseno,
                threelicensfrom: threelicensfrom,
                threelicensto: threelicensto),
            SizedBox(
              height: 10,
            ),
            FourLiceseCard(
                fourlicenseno: fourlicenseno,
                fourlicensfrom: fourlicensfrom,
                fourlicensto: fourlicensto),
          ],
        ),
      )),
    );
  }
}
