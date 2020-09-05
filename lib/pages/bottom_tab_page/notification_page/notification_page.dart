import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:itinerary_wallet/common/document_card.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DefTitle(title: 'BOOKINGS'),
            documentSections(),
            BottomTabs(active: 'notify')
          ],
        ),
      ),
    );
  }

  Expanded documentSections() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(30),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return documentCard(index);
          },
        ),
      ),
    );
  }

  Container documentCard(index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: DocumentCard(
        title: '5 HR BUDAPEST IDEAL CITY TOUR & EVENING CRUISE',
        icon: 'transfers',
        startDate: 'May 22, 2020',
        endDate: 'May 22, 2020',
        document: '5hr-BUD-CTour_EveningCruise_Confirmation.pdf',
        backColor: (index.isOdd) ? Color(0xFF61AAE6) : Colors.white,
      ),
    );
  }
}
