import 'package:caffa/Models/Info.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoScreen extends StatefulWidget with Helpers {
  final String? title;
  final String? data;

  InfoScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Future<InfoModel> _loadInfoData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('info')
          .doc(widget.data)
          .get();

      InfoModel body = InfoModel.fromMap(doc.data() as Map<String, dynamic>);
      return body;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      throw error; // Rethrow the error to be caught by FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          context: context, title: widget.title!, isHomeScreen: false),
      body: FutureBuilder<InfoModel>(
        future: _loadInfoData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            InfoModel body = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: body.body.map((text) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Text(
                      text!,
                      textDirection: TextDirection.rtl,
                      style: titilliumRegular.copyWith(fontSize: 18.sp),
                      softWrap: true,
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
