import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfmc_holoapp/localizations.dart';

import 'drawer.dart';
import 'slider.dart';

class Home extends StatefulWidget {

  final Function interactionstudioLogEvent;
  final Function registerTap;
  final Function returnMessage;

  Home(this.interactionstudioLogEvent, this.registerTap, this.returnMessage);

  @override
  _HomeState createState() => _HomeState(interactionstudioLogEvent, registerTap, returnMessage);
}


class Product 
{
  String productName;
  String productImage;
  String productId;
  
  Product(this.productName, this.productImage, this.productId);
}


class _HomeState extends State<Home> {

  final List<Product> imgList = [
      Product('Citi PremierMiles Card','https://www.citibank.com.sg/gcb/credit_cards/images/creditcards-all-cards/card-premiermiles-visa.jpg', 'Citi PremierMiles Card'),
      Product('Life Insurance Solutions','https://www.citibank.com.sg/gcb/insurance/images/thumbnails/life_insurance_solutions.jpg', 'Life Insurance Solutions'),
      Product('Citibank Premium Account','https://www.citibank.com.sg/citi-priority/images/home/create_wealth.jpg', 'Citibank Premium Account'),
  ];

  final List<String> imgList2 = [
      'https://cumulus-fs.s3.amazonaws.com/images/banking-checking.png',
      'https://cumulus-fs.s3.amazonaws.com/images/banking-checking.png',
      'https://cumulus-fs.s3.amazonaws.com/images/banking-checking.png',
      'https://cumulus-fs.s3.amazonaws.com/images/banking-checking.png',
      'https://cumulus-fs.s3.amazonaws.com/images/banking-checking.png',
  ];

  final List<String> imgList3 = [
      'Banking',
      'Borrowing',
      'Credit Cards',
      'Investing',
  ];

  final Function _interactionstudioLogEvent;
  final Function _registerTap;
  final Function _returnMessage; 

  @override
  _HomeState(this._interactionstudioLogEvent, this._registerTap, this._returnMessage);

  @override
  void initState(){

    _registerTap('trackAction','App: Homepage Visit', _interactionstudioLogEvent, 'zone1');

   super.initState();

  }

  @override
  Widget build(BuildContext context) {


    // Initial images for banner 1 and banner 2
    String banner1Path = 'https://www.citibank.com.sg/gcb/credit_cards/images/overviewBanner/citibank-supplementary-card.jpg';
    String banner2Path = 'https://www.citibank.com.sg/gcb/credit_cards/images/overviewBanner/citibank-supplementary-card.jpg';

    // Lets see if a campaign from IS needs to replace the images
    String jsonString = "";
    String strName = "";
    String strImage = "";
    String strUrl = ""; 
    List<dynamic> imageList = [];

    if(_returnMessage() != "No Campaign"){
        jsonString = AppLocalizations.of(context).convertToJson(_returnMessage());
        //jsonString = convertToJson(_returnMessage());

        //List<dynamic> jsonObj = jsonDecode(jsonString);
        AppLocalizations.of(context).zone1Campaign = jsonDecode(jsonString);

        //jsonObj.forEach((element) {
        AppLocalizations.of(context).zone1Campaign.forEach((element) {
          strName = element["name"].toString();
          imageList = element["images"];   
          strImage = imageList[0]["url"];   
        });        

        banner1Path = strImage;
        //banner2Path = strImage;
    }
    else{
      jsonString = _returnMessage();
      print('Here in Home.dart: ' + jsonString.toString());
    }

    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        
        child: CustomScrollView(
            // Add the app bar and list of items as slivers in the next steps.
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blue,
                // Provide a standard title.
                // title: Text('asdas'),
                // pinned: true,
                //actions: <Widget>[
                //  IconButton(
                //    icon: Icon(Icons.shopping_cart),
                //    onPressed: () {},
                //  )
                //],
                
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                // floating: true,
                // Display a placeholder widget to visualize the shrinking size.
                //flexibleSpace: HomeSlider(),

                flexibleSpace: HomeSlider(),

                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 230,
              ),
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                        child: Text(
                            AppLocalizations.of(context)
                                .translate('NEW_ARRIVALS'),
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        height: 240.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: imgList.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: 140.0,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                      onTap: () {
                                        _registerTap('viewItem',i.productId, _interactionstudioLogEvent, 'zone1'); // View Item
                                        _registerTap('viewTag',"Fixed Income Securities|3", _interactionstudioLogEvent, 'zone1'); //View Tag
                                       // _registerTap('viewCategory',"Credit Cards", _interactionstudioLogEvent); //View Category

                                        Navigator.pushNamed(
                                            context, '/products',
                                            arguments: i.productImage);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 110,
                                            child: Hero(
                                              tag: i.productImage,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fitWidth,
                                                imageUrl: i.productImage,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              i.productName,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            subtitle: Text('\Find out more!',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                          child: new Image.network(banner1Path),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text('Shop By Category',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, top: 8.0, left: 8.0),
                            child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                child: Text('View All',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/categorise');
                                }),
                          )
                        ],
                      ),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          padding: EdgeInsets.only(
                              top: 8, left: 6, right: 6, bottom: 12),
                          children: List.generate(4, (index) {
                            return Container(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    print('Card tapped.');
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                70,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitWidth,
                                          imageUrl: imgList2[index],
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                      ),
                                      ListTile(
                                          title: Text(
                                        imgList3[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 6.0, left: 8.0, right: 8.0, bottom: 10),
                          child: new Image.network(banner2Path),
                        ),
                      )
                    ],
                  ),
                  // Builds 1000 ListTiles
                  childCount: 1,
                ),
              )
            ]),
      ),
    );
  }
/*
  String convertToJson(strToConvert){

    String strToConvert1 = strToConvert;

    if(strToConvert1.isNotEmpty){

      // Strip out all non json characters and replace them with JSON equivalents where possible
      strToConvert1 = strToConvert1.replaceAll(new RegExp(r'\('), '[');
      strToConvert1 = strToConvert1.replaceAll(new RegExp(r'\)'), ']');
      strToConvert1 = strToConvert1.replaceAll(new RegExp(r';'), ',');
      strToConvert1 = strToConvert1.replaceAll(new RegExp(r'<'), '');
      strToConvert1 = strToConvert1.replaceAll(new RegExp(r'>'), '');
      String newStr = strToConvert1;

      // Remove any commas that come immediately preceeding a close brace.
      String newStr1 = newStr.replaceAllMapped(RegExp(r'(,\s+\})'), (match) {
        return '}';
      });

      // There is no equals sign in json so replace them with colon
      newStr1 = newStr1.replaceAll(new RegExp(r'='), ':');

      // Leading code in the data that needs to be removed
      var pos3 = newStr1.indexOf("[");           
      var pos4 = newStr1.indexOf("[", pos3 + 1);

      newStr1 = newStr1.substring(pos4, newStr1.length - 1);

      // Make sure we wrap every string with double quotes that currently isnt wrapped 
      String newStr2 = newStr1.replaceAllMapped(RegExp(r'[\s]{2}[a-zA-Z0-9]+'), (match) {
        return '"${match.group(0).trim()}"';
      });

      // Make sure we wrap every string with double quotes that currently isnt wrapped     
      String newStr3 = newStr2.replaceAllMapped(RegExp(r'[:][\s][a-zA-Z0-9]+'), (match) {
        if(match.group(0).trim().contains(": ")){
          return ': "${match.group(0).trim().replaceFirst(new RegExp(r':\s'), '')}"';

        }
        return '"${match.group(0).trim().replaceFirst(new RegExp(r':\s'), '')}"';
      });

      //Data sometimes contains a trailing userId var. Need to remove this.
      String newStr4 = "";

      if(newStr3.contains(", \"userId\"")){
        var pos1 = newStr3.indexOf(", \"userId\"");           
        newStr4 = newStr3.substring(0, pos1);
      }else{
        newStr4 = newStr3;
      }
      
      return newStr4;
    }
    return "{}";

  }
  */
}
