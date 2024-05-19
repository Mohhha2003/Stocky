import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project1/Services/repos/orders_repo.dart';
import 'package:project1/features/home/data/models/order/order.dart';
import 'package:project1/features/home/presentation/views/order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: OrdresRepo().getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error is $e'),
            );
          } else {
            List<Order> orders = snapshot.data ?? [];
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                Order order = orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomOrderListViewItem(order: order),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CustomOrderListViewItem extends StatelessWidget {
  const CustomOrderListViewItem({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(order: order),
      )),
      tileColor: const Color(0xff964B00),
      title: Text(
        'Id: ${order.id}',
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Date: ${order.orderDate}',
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Text(
        '${order.status}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
