import 'package:flutter/material.dart';



class Product {
  final String id;
  final String name;
  final Color color;
  const Product({required this.id, required this.name, required this.color});
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final List<Product> products = const [
    Product(id: 'p1', name: 'Apple', color: Colors.red),
    Product(id: 'p2', name: 'Lime', color: Colors.green),
    Product(id: 'p3', name: 'Blueberry', color: Colors.blue),
  ];

  final List<Product> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drag → Drop — Shopping Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ======= Cart (DragTarget) =======
            DragTarget<Product>(
              onWillAccept: (p) => p != null && !cart.contains(p),
              onAcceptWithDetails: (details) {
                setState(() => cart.add(details.data));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${details.data.name} added to cart')),
                );
              },
              onLeave: (p) {
                // هنا تقدر تزيل حالة hover لو حفظتها
              },
              builder: (context, candidateData, rejectedData) {
                final hovering = candidateData.isNotEmpty;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: hovering ? Colors.green.shade50 : Colors.grey.shade100,
                    border: Border.all(color: hovering ? Colors.green : Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cart (${cart.length})', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: cart.isEmpty
                                ? [const Text('Cart is empty')]
                                : cart.map((p) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Chip(
                                backgroundColor: p.color.withOpacity(0.2),
                                label: Text(p.name),
                                avatar: CircleAvatar(backgroundColor: p.color),
                              ),
                            )).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // ======= Draggables area =======
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: products.map((p) {
                return LongPressDraggable<Product>(
                  data: p,
                  // feedback: ما يظهر أثناء السحب -> نغلفه Material كي يظهر ظل ونص صحيح
                  feedback: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(8),
                    child: _buildProductTile(p, size: 90),
                  ),
                  childWhenDragging: Opacity(opacity: 0.35, child: _buildProductTile(p)),
                  // الودجت العادي
                  child: _buildProductTile(p),
                  // callbacks اختيارية:
                  onDragStarted: () {
                    // print('started ${p.name}');
                  },
                  onDragEnd: (details) {
                    // details.offset يحتوي موقع نهاية السحب في الـ screen coordinates
                  },
                  maxSimultaneousDrags: 1,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTile(Product p, {double size = 72}) {
    return Container(
      width: size * 2,
      height: size,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: p.color.withOpacity(0.12),
        border: Border.all(color: p.color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          CircleAvatar(radius: size * 0.22, backgroundColor: p.color),
          const SizedBox(width: 12),
          Text(p.name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}


// class TestDragable extends StatelessWidget {
//   const TestDragable({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Draggable(
//
//                 child: Container(
//                   child: Text('Box'),
//               height: 100,
//               width: 200,
//               color: Colors.blue,
//             ), feedback:Material(
//                           elevation: 6,
//                           borderRadius: BorderRadius.circular(8),
//                           child:Container(
//                             height: 100,
//                             width: 200,
//
//                             child: Text('fedback'),
//                           ),
//                         ), ),
//
//             DragTarget(
//                 onAcceptWithDetails: (details) {
//
//                 },
//
//                 builder:(
//                 BuildContext ,
//                 Listdy
//                 )
//
//             )
//           ],
//         ),
//
//
//       ),
//     );
//   }
// }
