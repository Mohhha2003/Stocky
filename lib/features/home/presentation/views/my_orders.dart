import 'package:flutter/material.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_product_list_item.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) => Dismissible(
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.transparent,
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) {
          if (direction == AxisDirection.right) {}
        },
        key: GlobalKey(),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomProductListItem(),
        ),
      ),
      itemCount: 10,
    );
  }
}
