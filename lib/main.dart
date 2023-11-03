import 'package:drivinglicensedetails/screens/userdetailsscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CupertinoSearchTextField(
            onChanged: (value) {
              setState(() {
                searchName = value;
              });
            },
          ),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              return StreamBuilder<QuerySnapshot>(
                  stream: (FirebaseFirestore.instance)
                      .collection('contacts')
                      .orderBy('Name')
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
                            return Card(
                                child: ListTile(
                              title: Text(data['Name']),
                              subtitle: Text(data['Employee Code']),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetails(
                                            details: data['Employee Code'])));
                              },
                            ));
                          });
                    }
                  });
            }),
      ),
    );
  }
}
