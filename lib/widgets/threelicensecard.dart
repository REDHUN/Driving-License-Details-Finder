import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreeLicenseCard extends StatelessWidget {
  const ThreeLicenseCard({
    super.key,
    required this.threelicenseno,
    required this.threelicensfrom,
    required this.threelicensto,
  });

  final String threelicenseno;
  final String threelicensfrom;
  final String threelicensto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.03),
                            spreadRadius: 10,
                            blurRadius: 3)
                      ]),
                  margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 176, 198, 245),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(Icons.assignment),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Container(
                          width:
                              ((MediaQuery.of(context).size.width) - 90) * 0.7,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "THREE WHEELER LICENSE",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            threelicenseno,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                threelicensfrom,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Text(
                                                threelicensto,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
