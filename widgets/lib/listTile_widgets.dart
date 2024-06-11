import 'package:flutter/material.dart';

import 'button_widgets.dart';

class ListViewExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text('ListView (Default)',
              style: Theme.of(context).textTheme.headlineMedium),
          Container(
            height: 200,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Map'),
                  subtitle: Text('View your maps'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomButton()),
                    );
                    // Handle the tap
                    print('Map Tapped');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Album'),
                  subtitle: Text('View your albums'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle the tap
                    print('Album Tapped');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                  subtitle: Text('View your phone logs'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle the tap
                    print('Phone Tapped');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text('ListView.builder',
              style: Theme.of(context).textTheme.headlineMedium),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Item $index'),
                  subtitle: Text('Subtitle $index'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle the tap
                    print('Item $index Tapped');
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('ListView.separated',
              style: Theme.of(context).textTheme.headlineMedium),
          Container(
            height: 200,
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Item $index'),
                  subtitle: Text('Subtitle $index'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle the tap
                    print('Item $index Tapped');
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
          SizedBox(height: 20),
          Text('ListView.custom',
              style: Theme.of(context).textTheme.headlineMedium),
          Container(
            height: 200,
            child: ListView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Item $index'),
                    subtitle: Text('Subtitle $index'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Handle the tap
                      print('Item $index Tapped');
                    },
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
