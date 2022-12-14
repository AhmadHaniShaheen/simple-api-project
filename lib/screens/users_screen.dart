import 'package:api_secand_project/api/controllers/student_auth_api_controller.dart';
import 'package:api_secand_project/api/controllers/user_api_controller.dart';
import 'package:api_secand_project/models/user.dart';
import 'package:api_secand_project/storage/sharedPrefController.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  List<User> _users=<User>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          actions: [
            IconButton(onPressed: (){
               Navigator.pushNamed(context, '/index_image');
            }, icon: Icon(Icons.image)),
            IconButton(onPressed: (){
              SharedPrefController().clear();
              Navigator.pushNamed(context, '/login_screen');
              // StudentAuthApiController().logout();
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: FutureBuilder<List<User>>(
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasData){
              _users=snapshot.data!;
              return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      // child: NetworkImage(snapshot.data!.),
                      backgroundImage:NetworkImage(_users[index].image) ,
                    ),
                    title: Text(_users[index].firstName),
                    subtitle: Text(_users[index].mobile),
                  );
                },
              );
            }
            else{
              return Center(child: Text('No Data',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),);
            }
          },
          future: UserApiController().getUser(),

        ));
  }
}
