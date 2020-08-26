import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/document_card.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class Document extends StatelessWidget {
  final String icon;
  final String itineraryId;
  Document({this.icon, this.itineraryId});
  @override
  Widget build(BuildContext context) {
    getDocument();
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: true,
        ),
        body: Column(
          children: <Widget>[titleContainer(), documentSection(), BottomTabs()],
        ),
      ),
    );
  }

  List<dynamic> document = [];
  String title;
  String description;
  getDocument() async {
    try {
      Response response = await Dio()
          .post("https://www.travezl.com/mobile/api/itinerary_document.php",
              //data: {"customer_id": customerId});
              data: {"itinerary_id": 6});
      // print(response);
      if (response.statusCode == 200) {
        final res = json.decode(response.data);
        print(res);
        print("taas n2");
        //print(res);
        if (response.data.contains("error")) {
          //alert box
        } else {
          //success
          document = res;
          print('asdf');
        }
      }
    } catch (error) {
      print(error);
      //alertbox
    }
  }

  Container titleContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xffFFBE22),
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            document[0]['document_name'] ?? 'asdf',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          Text(
            'May 20, 2020 May 31, 2020',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Expanded documentSection() {
    return Expanded(
      child: Container(
          child: ListView.builder(
        padding: EdgeInsets.all(30),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return documentCard(index);
        },
      )),
    );
  }

  Container documentCard(index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: DocumentCard(
        title: '5 HR BUDAPEST IDEAL CITY TOUR & EVENING CRUISE',
        icon: icon,
        startDate: 'May 22, 2020',
        endDate: 'May 22, 2020',
        document: '5hr-BUD-CTour_EveningCruise_Confirmation.pdf',
        backColor: (index.isOdd) ? Color(0xFF61AAE6) : Colors.white,
      ),
    );
  }
}
