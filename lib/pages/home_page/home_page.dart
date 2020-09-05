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
        itemCount: itineraries.length,
        itemBuilder: (BuildContext buildContext, int index) {
          final df = new DateFormat('MMMM dd, yyyy EEE');
          var icons = getIcons(itineraries[index].documents);
          var title = itineraries[index].itineraryName;
          var endDate = itineraries[index].travelEndDate;
          var startDate = itineraries[index].travelStartDate;
          var itineraryId = itineraries[index].id;
          var documents = itineraries[index].documents;
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
        // child: ListView.builder(
        //   itemCount: pastData.length,
        //   itemBuilder: (BuildContext ctxt, int index) {
        //     var icons = pastData[index]['icon'];
        //     return HomeCard(
        //         icons: icons,
        //         color: Colors.grey,
        //         textColor: Colors.white,
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => Itinerary(data: icons)));
        //         });
        //   },
        // ),
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
          // data: {"customer_id": 859});
      if (response.statusCode == 200) {
        if (response.data.contains("error") || response.data.toString().length == 0) {
          setState(() {
            _isLoading = false;
          });
          //alert box
        } else {
          //success
          final res = json.decode(response.data);
          itineraries = new List<Itinerary>.from(res.map((x) => Itinerary.fromJson(x)));
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
      //alertbox
    }
  }

  List<String> getIcons(List<ItineraryDocument> documents) {
    List<String> icons = new List();

    documents.forEach((element) {
      icons.add(element.documentType.toLowerCase());
    });

    return icons;
  }
}
