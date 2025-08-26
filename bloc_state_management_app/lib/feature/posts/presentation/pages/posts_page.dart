import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) return Center(child: CircularProgressIndicator());
          if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(state.posts[i].title),
                subtitle: Text(state.posts[i].body),
              ),
            );
          }
          if (state is PostError) return Center(child: Text(state.message));
          return Center(child: Text("Press button to load posts"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostBloc>().add(LoadPosts()),
        child: Icon(Icons.download),
      ),
    );
  }
}
