import 'package:flutter/cupertino.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({required this.scrollController, final Key? key})
      : super(key: key);
  final ScrollController scrollController;


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}