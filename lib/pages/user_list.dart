import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';

import 'package:investigation/models/users.dart';
import 'package:investigation/services/user_service.dart';

/// UserList
class UserListPage extends StatefulWidget {

  static const String route = '/user/list';

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: _buildBody(context),
    );
  }  

  FutureBuilder<Response<Users>> _buildBody(BuildContext context) {

    return FutureBuilder<Response<Users>>(
      future: Provider.of<UserService>(context).getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final users = snapshot.data.body;

          return _buildUserList(context, users);

        } else {
          // Show a loading indicator while waiting for the users
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ); 
  }

  ListView _buildUserList(BuildContext context, Users users) {

    return ListView.builder(
      itemCount: users.users.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/150/24f355'),
                          fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Text(users.users[index].name,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Container(
                                child: Text(
                          users.users[index].email,
                          style: TextStyle(fontSize: 12),
                        ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

  }

}



