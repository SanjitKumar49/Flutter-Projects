import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleChildScrollWidges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.red,
            child: Center(
              child: Text('SingleChildScrollView'),
            ),
          ),
          SizedBox(height: 20),
          ListViewExample(),
          SizedBox(height: 20),
          GridViewExample(),
          SizedBox(height: 20),
          CustomScrollViewExample(),
          SizedBox(height: 20),
          NestedScrollViewExample(),
        ],
      ),
    );
  }
}

class ListViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
          );
        });
  }
}

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(4, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
      }),
    );
  }
}

class CustomScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CustomScrollView'),
          floating: true,
          flexibleSpace: Placeholder(),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
}

class NestedScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text('NestedScrollView'),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
        ];
      },
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}
