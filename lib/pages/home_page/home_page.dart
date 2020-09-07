import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:itinerary_wallet/common/home_card.dart';
import 'package:itinerary_wallet/models/itinerary.dart';
import 'package:itinerary_wallet/models/itineraryDocument.dart';
import 'package:itinerary_wallet/pages/itinerary_page/itinerary_page.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool _isLoading = false;

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<Itinerary> itineraries = [];
  List<Itinerary> upComingItineraries = [];
  List<Itinerary> pastItineraries = [];

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    getItineraries();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: false,
        ),
        body: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                      DefTitle(
                        title: 'ITINERARIES',
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        color: Theme.of(context).primaryColor,
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.grey,
                          tabs: [
                            Align(
                              alignment: Alignment.center,
                              child: Tab(
                                text: "Upcoming",
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Tab(
                                text: "Past",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey[100],
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[upComing(), past()],
                          ),
                        ),
                      ),
                      BottomTabs()
                    ]),
        ),
      ),
    );
  }

  Container upComing() {
    return Container(
      child: ListView.builder(
        itemCount: upComingItineraries.length,
        itemBuilder: (BuildContext buildContext, int index) {
          final df = new DateFormat('MMMM dd, yyyy EEE');
          var icons = getIcons(upComingItineraries[index].documents);
          var title = upComingItineraries[index].itineraryName;
          var endDate = upComingItineraries[index].travelEndDate;
          var startDate = upComingItineraries[index].travelStartDate;
          var itineraryId = upComingItineraries[index].id;
          var documents = upComingItineraries[index].documents;
          return HomeCard(
              icons: icons,
              color: (index.isEven) ? Color(0xFF61AAE6) : Colors.transparent,
              textColor: (index.isEven) ? Colors.white : Colors.blue,
              title: title.toString(),
              date: df.format(DateTime.parse(endDate)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItineraryPage(
                              title: title,
                              endDate: endDate,
                              startDate: startDate,
                              itineraryId: itineraryId,
                              itineraryDetails: documents
                            )));
                //builder: (context) => Itinerary()));
              });
        },
      ),
    );
  }

  Container past() {
    return Container(
        child: ListView.builder(
          itemCount: pastItineraries.length,
          itemBuilder: (BuildContext buildContext, int index) {
            final df = new DateFormat('MMMM dd, yyyy EEE');
            var icons = getIcons(pastItineraries[index].documents);
            var title = pastItineraries[index].itineraryName;
            var endDate = pastItineraries[index].travelEndDate;
            var startDate = pastItineraries[index].travelStartDate;
            var itineraryId = pastItineraries[index].id;
            var documents = pastItineraries[index].documents;
            return HomeCard(
                icons: icons,
                color: Colors.grey,
                textColor: Colors.white,
                title: title.toString(),
                date: df.format(DateTime.parse(endDate)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItineraryPage(
                              title: title,
                              endDate: endDate,
                              startDate: startDate,
                              itineraryId: itineraryId,
                              itineraryDetails: documents
                          )));
                });
          },
        ),
        );
  }

  getItineraries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerId = prefs.getString('customerId');
    try {
      setState(() {
        _isLoading = true;
      });
      Response response =
      await Dio().post("https://www.travezl.com/mobile/api/itinerary.php",
          data: {"customer_id": customerId});
          // data: {"customer_id": 858});
      if (response.statusCode == 200) {
        if (response.data.contains("error")) {
          final res = json.decode(response.data);
          showAlertDialog(context, res['message']);
        } else {
          //success
          if(response.data.toString().length != 0) {
            final res = json.decode(response.data);
            itineraries = new List<Itinerary>.from(res.map((x) => Itinerary.fromJson(x)));
            populateLists();
          }
        }
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
      // showAlertDialog(context, error.message);
    }
  }

  List<String> getIcons(List<ItineraryDocument> documents) {
    List<String> icons = new List();

    documents.forEach((element) {
      icons.add(element.documentType.toLowerCase());
    });

    return icons;
  }

  populateLists() {
    for(var item in itineraries){
      var now = new DateTime.now();
      var endDate = DateTime.parse(item.travelEndDate);
      bool isPast = endDate.isAfter(now);

      upComingItineraries.clear();
      pastItineraries.clear();
      if(item.status != "1" || isPast) {
        pastItineraries.add(item);
      } else {
        upComingItineraries.add(item);
      }
    }
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
