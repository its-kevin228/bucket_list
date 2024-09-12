import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketlistdata = [];
//get API
  Future<void> getdata() async {
    try {
      Response reponse = await Dio().get(
          'https://flutter228-47a82-default-rtdb.firebaseio.com/bucketlist.json');
bucketlistdata=reponse.data;

setState(() {});
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('somethig is wrong'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bucket List'),
      ),

      body: Column(
        children: [
          ElevatedButton(
            onPressed: getdata,
            child: Text('Add data'),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: bucketlistdata.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                
                  leading: CircleAvatar(
                    backgroundImage:NetworkImage(bucketlistdata[index]['image']),
                  ),
                
                  trailing: Text(bucketlistdata[index]['cost'].toString()),
                
                  title: Text(bucketlistdata[index]['item'] ?? " "),
                ),
              );

            }),

          )
        ],
      ),

    );
  }
}
