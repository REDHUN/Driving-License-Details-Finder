import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drivinglicensedetails/screens/userdetailsscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "api key here",
      appId: "1:51324241117:android:3564eda7b3319cb7e34734",
      messagingSenderId: "51324241117",
      projectId: "driving-license-details-acb09",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var searchName = "";
  String? filePath;
  TextEditingController qrcontroller = TextEditingController();
  // This widget is the root of your application.

  Future<void> scanQr() async {
    try {
      FlutterWebQrcodeScanner(
        onGetResult: (result) {
          setState(() {
            searchName = result;
          });
        },
        stopOnFirstResult: true,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        onError: (error) {
          // print(error.message)
        },
        onPermissionDeniedError: () {
          //show alert dialog or something
        },
      );
    }

    //   FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
    //       .then((value) {
    //     setState(() {
    //       searchName = value;
    //       qrcontroller = TextEditingController(text: value);
    //     });
    //   });
    // }

    catch (e) {
      setState(() {
        searchName = "unable to read qr code";
      });
    }
  }

  void exportData() async {
    //Pick file
    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);
    if (csvFile != null) {
      //decode bytes back to utf8
      final bytes = utf8.decode(csvFile.files[0].bytes as List<int>);
      List<List<dynamic>> fields =
          const CsvToListConverter().convert(bytes).toList();
      final CollectionReference contacts =
          FirebaseFirestore.instance.collection("contacts");
      // final myData = await rootBundle.loadString(input as String);
      //List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

      for (int i = 0; i < fields.length; i++) {
//inside the 2nd dimension
        for (int j = 0; j < fields.elementAt(i).length; j++) {}
      }

      List<List<dynamic>> data = [];
      data = fields;

      for (var i = 0; i < data.length; i++) {
        var record = {
          "Name": data[i][0],
          "Employee Code": data[i][1].toString(),
          "PHONE NO": data[i][2].toString(),
          "Two License Number": data[i][3].toString(),
          "Two Vaild From": data[i][4].toString(),
          "Two Vaild To": data[i][5].toString(),
          "Three License Number": data[i][6].toString(),
          "Three Vaild From": data[i][7].toString(),
          "Three Vaild To": data[i][8].toString(),
          "Four License Number": data[i][9].toString(),
          "Four Vaild From": data[i][10].toString(),
          "Four Vaild To": data[i][11].toString(),
          "Fortlift License Number": data[i][12].toString(),
          "Fortlift Vaild From": data[i][13].toString(),
          "Fortlift Vaild To": data[i][14].toString(),
          "Mewp License Number": data[i][15].toString(),
          "Mewp Vaild From": data[i][16].toString(),
          "Mewp Vaild To": data[i][17].toString(),
        };
        contacts.add(record);
      }
    }
  }

  @override
  void dispose() {
    qrcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Driving License Details',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: exportData,
                child: Icon(
                  Icons.upload,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3)
                    ]),
                child: TextField(
                  controller: qrcontroller,
                  onChanged: (value) {
                    setState(() {
                      searchName = value;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    suffixIcon: Container(
                      margin: EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: scanQr,
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.black,
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: Firebase.initializeApp(),
                    builder: (context, snapshot) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: (FirebaseFirestore.instance)
                              .collection('contacts')
                              .orderBy('Employee Code')
                              .startAt([searchName]).endAt(
                                  [searchName + "\uf8ff"]).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.docs[index];
                                    return Container(
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                            right: 20),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.03),
                                                  spreadRadius: 10,
                                                  blurRadius: 3)
                                            ]),
                                        child: ListTile(
                                          leading: Text((index + 1).toString(),
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          title: Text(
                                            data['Name'],
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(data['Employee Code'],
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300)),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetails(
                                                          name: data['Name']
                                                              .toString(),
                                                          empcode: data[
                                                              'Employee Code'],
                                                          twolicenseno: data[
                                                              'Two License Number'],
                                                          twolicensfrom: data[
                                                              'Two Vaild From'],
                                                          twolicensto: data[
                                                              'Two Vaild To'],
                                                          threelicenseno: data[
                                                              'Three License Number'],
                                                          threelicensfrom: data[
                                                              'Three Vaild From'],
                                                          threelicensto: data[
                                                              'Three Vaild To'],
                                                          fourlicenseno: data[
                                                              'Four License Number'],
                                                          fourlicensfrom: data[
                                                              'Four Vaild From'],
                                                          fourlicensto: data[
                                                              'Four Vaild To'],
                                                        )));
                                          },
                                        ));
                                  });
                            }
                          });
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
