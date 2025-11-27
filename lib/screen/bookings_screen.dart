import 'package:flutter/widgets.dart';
import 'package:personal_security_officer/app/general_imports.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({required this.scrollController, final Key? key})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<BookingsScreen> createState() => BookingsScreenState();
}

class BookingsScreenState extends State<BookingsScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Booking Screen"),);
  }
  
  @override
  
  bool get wantKeepAlive => true;
}