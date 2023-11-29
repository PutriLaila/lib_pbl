import 'package:flutter/material.dart';

class OrderProgressPage extends StatelessWidget {
  final List<OrderStage> stages = [
    OrderStage(name: "Order Being Made", icon: Icons.build),
    OrderStage(name: "Packing Order", icon: Icons.archive),
    OrderStage(name: "Order Being Delivered", icon: Icons.local_shipping),
    OrderStage(name: "Order Reached Customer", icon: Icons.check),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(
                right: 5.0, top: 25), // Adjust the right padding as needed
            child: Text(
              'Order Progress',
              style: TextStyle(
                fontSize: 25.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Icon(
                stages[0].icon,
                size: 48.0,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: OrderStageCard(
                    stage: stages[index],
                    isActive: index == 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStage {
  final String name;
  final IconData icon;

  OrderStage({required this.name, required this.icon});
}

class OrderStageCard extends StatelessWidget {
  final OrderStage stage;
  final bool isActive;

  OrderStageCard({required this.stage, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stage.name),
      subtitle: Text('Additional details about ${stage.name}'),
      leading: CircleAvatar(
        backgroundColor: isActive ? Colors.blue : Colors.grey,
        child: Icon(
          stage.icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
