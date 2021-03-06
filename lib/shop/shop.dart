import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sfmc_holoapp/localizations.dart';

import 'search.dart';

class Shop extends StatefulWidget {

  final Function interactionstudioLogEvent;
  final Function registerTap;
  final Function returnMessage;
  final Function setReturnMessage;

  Shop(this.interactionstudioLogEvent, this.registerTap, this.returnMessage, this.setReturnMessage);

  @override
  _ShopState createState() => _ShopState(interactionstudioLogEvent, registerTap, returnMessage, setReturnMessage);
}

class _ShopState extends State<Shop> {

  final Function _interactionstudioLogEvent;
  final Function _registerTap;
  final Function _returnMessage;
  final Function _setReturnMessage;
/*
  final List<Map<dynamic, dynamic>> products = [
    {'name': 'IPhone', 'rating': 3.0, 'image': 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'},
    {'name': 'IPhone X 2', 'rating': 3.0, 'image': 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 11', 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'},
    {'name': 'IPhone 12', 'rating': 5.0, 'image': 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80'},
  ];
*/

  final List<Map<dynamic, dynamic>> products = [
    {'name': 'Cumulus Freedom Card', 'rating': 5.0, 'image': 'https://cumulus-fs.s3.amazonaws.com/images/credit-card-freedom-no-logo.png'},
    {'name': 'Cloud Travel Card', 'rating': 5.0, 'image': 'https://cumulus-fs.s3.amazonaws.com/images/credit-card-travel-no-logo.png'},
    {'name': 'Cloud Plus Card', 'rating': 5.0, 'image': 'https://cumulus-fs.s3.amazonaws.com/images/credit-card-cloud-plus-no-logo.png'},
    {'name': 'Student Rewards Card', 'rating': 5.0, 'image': 'https://cumulus-fs.s3.amazonaws.com/images/credit-card-student-no-logo.png'},
  ];


  String banner1Path = '';
  String banner2Path = '';
  

  @override
  _ShopState(this._interactionstudioLogEvent, this._registerTap, this._returnMessage, this._setReturnMessage);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String jsonString = "";
    String strName = "";
    String strImage = "";
    List<dynamic> imageList = [];

    if(AppLocalizations.of(context).zone1Campaign != null){
      AppLocalizations.of(context).zone1Campaign.forEach((element) {
        strName = element["name"].toString();
        imageList = element["images"];   
        strImage = imageList[0]["url"];   
      });
    }
    if(strImage.length > 0){
        banner1Path = strImage;
    }else{
        banner1Path = 'https://cumulus-fs.s3.amazonaws.com/images/banners/hero-personal-banking-default-BG-image.jpg';
    }
    /*
    if(_returnMessage() != "No Campaign"){
        jsonString = AppLocalizations.of(context).convertToJson(_returnMessage());
        //jsonString = convertToJson(_returnMessage());

        jsonString = jsonString.replaceAll(new RegExp(r'\['), '{');
        jsonString = jsonString.replaceAll(new RegExp(r'\]'), '}');

        final decodedJson = jsonDecode(jsonString);
        //List<dynamic> jsonObj = jsonDecode(jsonString);
        AppLocalizations.of(context).zone2Campaign = decodedJson;

        //jsonObj.forEach((element) {
       // AppLocalizations.of(context).zone2Campaign.forEach((element) {
       strImage = decodedJson["Image1"];   
       // });        

        banner2Path = 'https://cumulus-fs.s3.amazonaws.com/images/banners/' + strImage;
        //_setReturnMessage("No Campaign");
        //banner2Path = strImage;
    }
    else{
      jsonString = _returnMessage();
      print('Here in Home.dart: ' + jsonString.toString());
    }
  */

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                scaffoldKey.currentState
                    .showBottomSheet((context) => ShopSearch());
              },
            )
          ],
          title: Text('Products & Services'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return DefaultTabController(
                length: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 150.0),
                      child: Material(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 1.0, left: 8.0, right: 8.0, bottom: 10),
                        child: new Image.network(banner1Path),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                         
                          Container(
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              padding: EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 12),
                              children: List.generate(products.length, (index) {
                                return Container(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                      onTap: () {
                                        print('Card tapped.');
                                       //_registerTap('viewCategory',"Credit Cards", _interactionstudioLogEvent, 'zone2');

                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: (MediaQuery.of(context).size.width / 2 - 5),
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fitWidth,
                                              imageUrl: products[index]['image'],
                                              placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator()
                                              ),
                                              errorWidget: (context, url, error) => new Icon(Icons.error),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: ListTile(
                                              title: Text(
                                                products[index]['name'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                              /*subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                                                        child: Text('\$200', style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                          fontWeight: FontWeight.w700,
                                                        )),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 6.0),
                                                        child: Text('(\$400)', style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.grey,
                                                            decoration: TextDecoration.lineThrough
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                 Row(
                                                    children: <Widget>[
                                                      SmoothStarRating(
                                                          allowHalfRating: false,
                                                          onRated: (v) {
                                                            products[index]['rating'] = v;
                                                            setState(() {});
                                                          },
                                                          starCount: 5,
                                                          rating: products[index]['rating'],
                                                          size: 16.0,
                                                          color: Colors.amber,
                                                          borderColor: Colors.amber,
                                                          spacing:0.0
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 6.0),
                                                        child: Text('(4)', style: TextStyle(
                                                            fontWeight: FontWeight.w300,
                                                            color: Theme.of(context).primaryColor
                                                        )),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),*/
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 1.0, left: 8.0, right: 8.0, bottom: 10),
                        child: new Image.network(banner1Path),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 1.0, left: 8.0, right: 8.0, bottom: 10),
                        child: new Image.network(banner2Path),
                      ),
                    ),*/

                  ],
                ));
          },
        ),
//        body: DefaultTabController(
//            length: 2,
//            child: Column(
//              children: <Widget>[
//                Container(
//                  constraints: BoxConstraints(maxHeight: 150.0),
//                  child: Material(
//                    color: Theme.of(context).accentColor,
//                    child: TabBar(
//                      indicatorColor: Colors.blue,
//                      tabs: [
//                        Tab(icon: Icon(Icons.view_list)),
//                        Tab(icon: Icon(Icons.grid_on)),
//                      ],
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: TabBarView(
//                    children: [
//                      Container(
//                        child: ListView(
//                          children: products.map((product) {
//                            return Builder(
//                              builder: (BuildContext context) {
//                                return  InkWell(
//                                  onTap: () {
//                                    print('Card tapped.');
//                                  },
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Divider(
//                                        height: 0,
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//                                        child: ListTile(
//                                          trailing: Icon(Icons.navigate_next),
//                                          leading: ClipRRect(
//                                            borderRadius: BorderRadius.circular(5.0),
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  color: Colors.blue
//                                              ),
//                                              child: CachedNetworkImage(
//                                                fit: BoxFit.cover,
//                                                imageUrl: product['image'],
//                                                placeholder: (context, url) => Center(
//                                                    child: CircularProgressIndicator()
//                                                ),
//                                                errorWidget: (context, url, error) => new Icon(Icons.error),
//                                              ),
//                                            ),
//                                          ),
//                                          title: Text(
//                                            product['name'],
//                                            style: TextStyle(
//                                                fontSize: 14
//                                            ),
//                                          ),
//                                          subtitle: Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Row(
//                                                children: <Widget>[
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(top: 2.0, bottom: 1),
//                                                    child: Text('\$200', style: TextStyle(
//                                                      color: Theme.of(context).accentColor,
//                                                      fontWeight: FontWeight.w700,
//                                                    )),
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 6.0),
//                                                    child: Text('(\$400)', style: TextStyle(
//                                                        fontWeight: FontWeight.w700,
//                                                        fontStyle: FontStyle.italic,
//                                                        color: Colors.grey,
//                                                        decoration: TextDecoration.lineThrough
//                                                    )),
//                                                  )
//                                                ],
//                                              ),
//                                              Row(
//                                                children: <Widget>[
//                                                  SmoothStarRating(
//                                                      allowHalfRating: false,
//                                                      onRatingChanged: (v) {
//                                                        product['rating'] = v;
//                                                        setState(() {});
//                                                      },
//                                                      starCount: 5,
//                                                      rating: product['rating'],
//                                                      size: 16.0,
//                                                      color: Colors.amber,
//                                                      borderColor: Colors.amber,
//                                                      spacing:0.0
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 6.0),
//                                                    child: Text('(4)', style: TextStyle(
//                                                      fontWeight: FontWeight.w300,
//                                                      color: Theme.of(context).primaryColor
//                                                    )),
//                                                  )
//                                                ],
//                                              )
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                );
//                              },
//                            );
//                          }).toList(),
//                        ),
//                      ),
//                      Container(
//                        child: GridView.count(
//                          shrinkWrap: true,
//                          crossAxisCount: 2,
//                          childAspectRatio: 0.7,
//                          padding: EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 12),
//                          children: List.generate(products.length, (index) {
//                            return Container(
//                              child: Card(
//                                clipBehavior: Clip.antiAlias,
//                                child: InkWell(
//                                  onTap: () {
//                                    print('Card tapped.');
//                                  },
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      SizedBox(
//                                        height: (MediaQuery.of(context).size.width / 2 - 5),
//                                        width: double.infinity,
//                                        child: CachedNetworkImage(
//                                          fit: BoxFit.cover,
//                                          imageUrl: products[index]['image'],
//                                          placeholder: (context, url) => Center(
//                                              child: CircularProgressIndicator()
//                                          ),
//                                          errorWidget: (context, url, error) => new Icon(Icons.error),
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(top: 5.0),
//                                        child: ListTile(
//                                            title: Text(
//                                              'Two Gold Rings',
//                                              style: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 16
//                                              ),
//                                            ),
//                                          subtitle: Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Row(
//                                                children: <Widget>[
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(top: 2.0, bottom: 1),
//                                                    child: Text('\$200', style: TextStyle(
//                                                      color: Theme.of(context).accentColor,
//                                                      fontWeight: FontWeight.w700,
//                                                    )),
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 6.0),
//                                                    child: Text('(\$400)', style: TextStyle(
//                                                        fontWeight: FontWeight.w700,
//                                                        fontStyle: FontStyle.italic,
//                                                        color: Colors.grey,
//                                                        decoration: TextDecoration.lineThrough
//                                                    )),
//                                                  )
//                                                ],
//                                              ),
//                                              Row(
//                                                children: <Widget>[
//                                                  SmoothStarRating(
//                                                      allowHalfRating: false,
//                                                      onRatingChanged: (v) {
//                                                        products[index]['rating'] = v;
//                                                        setState(() {});
//                                                      },
//                                                      starCount: 5,
//                                                      rating: products[index]['rating'],
//                                                      size: 16.0,
//                                                      color: Colors.amber,
//                                                      borderColor: Colors.amber,
//                                                      spacing:0.0
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 6.0),
//                                                    child: Text('(4)', style: TextStyle(
//                                                        fontWeight: FontWeight.w300,
//                                                        color: Theme.of(context).primaryColor
//                                                    )),
//                                                  )
//                                                ],
//                                              )
//                                            ],
//                                          ),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            );
//                          }),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ))
      ),
    );
  }
}
