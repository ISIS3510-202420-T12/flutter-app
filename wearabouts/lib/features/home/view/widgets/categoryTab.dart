import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoryTab extends StatefulWidget {
  final String name;
  final String assetName;

  const CategoryTab({Key? key, required this.name, required this.assetName})
      : super(key: key);

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  bool _isPressed = false;

  void _togglePressed() {
    setState(() {
      _isPressed = !_isPressed;
    });

    Provider.of<FirebaseAnalytics>(context, listen: false).logEvent(
      name: 'select_category_filter',
      parameters: {
        'category_name': widget.name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePressed,
      child: Card(
        color: _isPressed
            ? Colors.grey.shade300
            : Colors.white, // Color oscuro cuando está presionado
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: 90,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 60,
                  child: SvgPicture.asset(
                    widget.assetName,
                    height: 55,
                    width: 20,
                  ),
                ),
              ),
              Text(widget.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
    );
  }
}
