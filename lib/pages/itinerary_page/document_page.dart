
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/document_card.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:itinerary_wallet/models/itineraryDocument.dart';

class DocumentPage extends StatefulWidget {

  final String title;
  final String description;
  final String icon;
  final List<ItineraryDocument> itineraryDocuments;

  DocumentPage({
    this.title,
    this.description,
    this.icon,
    this.itineraryDocuments
  });

  @override
  _DocumentPageState createState() => _DocumentPageState();

}

class _DocumentPageState extends State<DocumentPage> {

  @override
  Widget build(BuildContext context) {
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
             this.widget.title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          Text(
            this.widget.description,
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
        itemCount: this.widget.itineraryDocuments.length,
        itemBuilder: (BuildContext context, int index) {
          return documentCard(index);
        },
      )),
    );
  }

  Container documentCard(index) {
    final df = new DateFormat('MMMM dd, yyyy');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: DocumentCard(
        title: this.widget.itineraryDocuments[index].documentName,
        icon: this.widget.icon,
        startDate: df.format(DateTime.parse(this.widget.itineraryDocuments[index].startDate)),
        endDate: df.format(DateTime.parse(this.widget.itineraryDocuments[index].endDate)),
        document: this.widget.itineraryDocuments[index].documentFileName,
        backColor: (index.isOdd) ? Color(0xFF61AAE6) : Colors.white,
      ),
    );
  }
}
