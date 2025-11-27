import 'package:flutter/cupertino.dart';

class MyRequestListScreen extends StatefulWidget {
  const MyRequestListScreen({required this.scrollController, final Key? key})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<MyRequestListScreen> createState() => _MyRequestListScreenState();
}

class _MyRequestListScreenState extends State<MyRequestListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}