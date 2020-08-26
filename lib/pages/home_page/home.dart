import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:itinerary_wallet/common/home_card.dart';
import 'package:itinerary_wallet/pages/itinerary_page/itinerary.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

bool _isLoading = false;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // final List<Tab> myTabs = <Tab>[
  //   Tab(text: 'LEFT'),
  //   Tab(text: 'RIGHT'),
  // ];
  var upcommingData = [
    {
      'icon': ['island', 'trolley']
    },
    {
      'icon': ['train', 'noodles']
    },
    {
      'icon': ['boat', 'car', 'noodles']
    },
    {
      'icon': [
        'airplane',
        'boat',
        'island',
        'car',
        'trolley',
        'noodles',
        'train',
        'camera'
      ]
    }
  ];

  var pastData = [
    {
      'icon': ['train', 'noodles']
    },
    {
      'icon': ['airplane', 'boat', 'island', 'car']
    }
  ];

  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    // getCustomer();
    getItineraries();
    super.initState();
  }

  void main() {}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // getCustomer() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // print(prefs.getString('customerId'));
  //   // print(prefs.getString('firstName'));
  //   // print(prefs.getString('lastName'));
  //   // print(prefs.getString('email'));
  // }

  List itineraries = [];
  getItineraries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerId = prefs.getString('customerId');
    try {
      setState(() {
        _isLoading = true;
      });
      Response response =
          await Dio().post("https://www.travezl.com/mobile/api/itinerary.php",
              //data: {"customer_id": customerId});
              data: {"customer_id": 856});
      // print(response);
      if (response.statusCode == 200) {
        final res = json.decode(response.data);
        print(res);
        if (response.data.contains("error")) {
          //alert box
        } else {
          //success
          itineraries = res;
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      print(error);
      //alertbox
    }
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
                            children: <Widget>[upComming(), past()],
                          ),
                        ),
                      ),
                      BottomTabs()
                    ]),
        ),
      ),
    );
  }

  Container upComming() {
    return Container(
      child: ListView.builder(
        itemCount: itineraries.length,
        itemBuilder: (BuildContext ctxt, int index) {
          var icons = upcommingData[index]['icon'];
          //var icons = itineraries[index]['document_type'.toLowerCase()];
          var title = itineraries[index]['itinerary_name'];
          var endDate = itineraries[index]['travel_end_date'];
          var startDate = itineraries[index]['travel_start_date'];
          var itineraryId = itineraries[index]['id'];
//var itineraryDetails = itineraries[index];
          return HomeCard(
              icons: icons,
              color: (index.isEven) ? Color(0xFF61AAE6) : Colors.transparent,
              textColor: (index.isEven) ? Colors.white : Colors.blue,
              title: title.toString(),
              date: endDate.toString(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Itinerary(
                              data: icons,
                              title: title,
                              endDate: endDate,
                              startDate: startDate,
                              itineraryId: itineraryId,
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
}
