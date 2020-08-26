import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/itinerary_card.dart';
import 'package:itinerary_wallet/pages/itinerary_page/document.dart';

class Itinerary extends StatefulWidget {
  final List itineraryDetails;
  final List data;
  final String title;
  final String startDate;
  final String endDate;
  final String itineraryId;

  //Itinerary({this.data, this.ItineraryDetails});

  Itinerary(
      {this.data,
      this.title,
      this.itineraryDetails,
      this.endDate,
      this.startDate,
      this.itineraryId});

  @override
  _ItineraryState createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  var icons = [
    'airplane',
    'trolley',
    'boat',
    'island',
    'camera',
    'car',
    'train',
    'noodles'
  ];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(widget.itineraryDetails);
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
    bool active = widget.data.contains(icons[index].toString());
    return Container(
      child: ItineraryCard(
        onPressed: (active)
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Document(
                              icon: icons[index].toString(),
                              itineraryId: this.widget.itineraryId,
                            )));
              }
            : null,
        iconName: icons[index],
        active: active,
      ),
    );
  }
}
