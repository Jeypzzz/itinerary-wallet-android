import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/itinerary_card.dart';
import 'package:itinerary_wallet/models/itineraryDocument.dart';
import 'package:itinerary_wallet/pages/itinerary_page/document_page.dart';

class ItineraryPage extends StatefulWidget {
  final List<ItineraryDocument> itineraryDetails;
  final String title;
  final String startDate;
  final String endDate;
  final String itineraryId;

  ItineraryPage(
      {this.title,
      this.itineraryDetails,
      this.endDate,
      this.startDate,
      this.itineraryId});

  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  var icons = [
    'flights',
    'accommodation',
    'cruises',
    'packages',
    'activities',
    'transfers',
    'rail',
    'others'
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: true,
        ),
        body: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    titleContainer(),
                    gridContainer(context),
                    BottomTabs()
                  ],
                ),
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
            this.widget.title.toString(),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          Text(
            this.widget.startDate.toString() +
                ' - ' +
                this.widget.endDate.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Expanded gridContainer(context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: MediaQuery.of(context).size.width /
            ((MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) /
                3.5),
        children: List.generate(8, (index) {
          return Center(
            child: itineraryCard(index, context),
          );
        }),
      ),
    );
  }

  Container itineraryCard(index, context) {
    final df = new DateFormat('MMMM dd, yyyy');
    String description = df.format(DateTime.parse(this.widget.startDate)) + ' - ' + df.format(DateTime.parse(this.widget.endDate));
    int count = getIconCount(icons[index].toString());
    bool active = count > 0;

    return Container(
      child: ItineraryCard(
        onPressed: (active)
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DocumentPage(
                          title: this.widget.title,
                          description: description,
                          icon: icons[index].toString(),
                          itineraryDocuments: this.widget.itineraryDetails,
                        )));
              }
            : null,
        iconName: icons[index],
        active: active,
        count: count,
      ),
    );
  }

  int getIconCount(String iconName) {
    int count = 0;
    this.widget.itineraryDetails.forEach((element) {
      if(element.documentType.toLowerCase().contains(iconName)) {
        count++;
      }
    });
    return count;
  }
}
