import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactUsMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context: context, title: 'رسائل اتصل بنا', isHomeScreen: false),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('contact_us')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما!'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا توجد رسائل.'));
          }

          final messages = snapshot.data!.docs;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final messageData = messages[index].data() as Map<String, dynamic>;
              final message = messageData['message'] ?? '';
              final email = messageData['email'] ?? '';
              final timestamp = messageData['timestamp'] as Timestamp;
              final formattedDate =
              DateFormat('yyyy/MM/dd HH:mm').format(timestamp.toDate());

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الرسالة: $message',
                        style: titilliumRegular.copyWith(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'البريد الإلكتروني: $email',
                        style: titilliumRegular.copyWith(fontSize: 14.0, color: Colors.grey),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'التاريخ: $formattedDate',
                        style: titilliumRegular.copyWith(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
