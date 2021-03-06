import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfmc_holoapp/blocks/auth_block.dart';
import 'signin.dart';
import 'signup.dart';

class Auth extends StatefulWidget {
  final Function interactionstudioLogEvent;
  final Function registerTap;

  Auth(this.interactionstudioLogEvent, this.registerTap);

  @override
  _Auth createState() => _Auth(interactionstudioLogEvent, registerTap);

}

class _Auth extends State<Auth> {
  final Function _interactionstudioLogEvent;
  final Function _registerTap;

  final List<Widget> tabs = [];

  @override
  _Auth(this._interactionstudioLogEvent, this._registerTap){

    tabs.add(SignIn(_interactionstudioLogEvent, _registerTap));
    tabs.add(SignUp(_interactionstudioLogEvent, _registerTap));

  }

  @override
  Widget build(BuildContext context) {
    final AuthBlock authBlock = Provider.of<AuthBlock>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authBlock.currentIndex == 0 ? 'Sign In' : 'Create Account'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_open),
            title: Text('Sign In'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            title: Text('Create Account'),
          ),
        ],
        currentIndex: authBlock.currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (num){
           authBlock.currentIndex = num;
        },
      ),
      body: tabs[authBlock.currentIndex],
    );
  }
}