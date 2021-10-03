import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_helper.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Helpers/shared_pref_helper.dart';
import 'package:qbittorent_remote/Models/server.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


class add_server extends StatefulWidget {

  @override
  _add_serverState createState() => _add_serverState();
}

class _add_serverState extends State<add_server> {

  final GlobalKey<FormState> _form_key = GlobalKey();

  String? ip_address, port_number, user_name, password;


  void show_snackbar({message}) {

    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submit() async {
    var formState = _form_key.currentState;

    if (formState!.validate()) {
        List<Server> servers = [Server(ip: ip_address, port: port_number,user_name: user_name,password: password)];
        SharedPref pref = SharedPref();
        pref.sharedPrefInit();
        final FormState? formState = _form_key.currentState;
        var api_session = Session("http://152.70.53.181:8080");
        if(formState!.validate()) {
          await api_session.login("bhuppi", "18120120229").then((value) async {
            if (value == true) {
              await pref.putString('serverList',Server.encode(servers));
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new home(api_session:api_session)));
            } else {
              print("login failed");
            }
          });
        }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
              child: Form(
                key: _form_key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter server ip address',
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value) => value!.isEmpty ? "Please enter ip address" : null,
                        onChanged: (value) => ip_address = value,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter port number'
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value)  => value!.isEmpty ? "Please enter port number" : null,
                        onChanged: (value) => port_number = value,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your username'
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value) => value!.isEmpty ? "Please enter username" : null,
                        onChanged: (value) => user_name = value,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter password'
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: true,
                        validator: (value) => value!.isEmpty ? "Please enter password" : null,
                        onChanged: (value) => password = value,
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: submit,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      ]
                ),
              ),
            ),
          ),
        )
    );
  }
}
