import 'package:flutter/material.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postEntity}) : super(key: key);

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text(postEntity.name),
          Text(postEntity.preContent ?? ''),
          Text('Author: ${postEntity.author?.id ?? ''}'),
        ],
      ),
    );
  }
}
