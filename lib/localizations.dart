import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sfmc_holoapp/localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;
  List<dynamic> zone1Campaign;
  List<dynamic> zone2Campaign;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  // This method will be called from every widget which needs an IS campaign as a JSON
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


}
