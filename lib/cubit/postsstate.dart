import 'package:flutter/material.dart';
import 'package:grad_app/models/postsmodel.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;

  PostLoaded(this.posts);
}