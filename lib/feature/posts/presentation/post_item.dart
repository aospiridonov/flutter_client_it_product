import 'package:flutter/material.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';
import 'package:flutter_client_it_product/feature/posts/presentation/detail_post_screen.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postEntity}) : super(key: key);

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPostScreen(id: postEntity.id.toString()),
        ));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(postEntity.name),
            Text(postEntity.preContent ?? ''),
            Text('Author: ${postEntity.author?.id ?? ''}'),
          ],
        ),
      ),
    );
  }
}
