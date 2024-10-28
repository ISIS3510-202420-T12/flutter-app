import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String goal;
  final int percentage;
  final String imagePath;
  final VoidCallback onTap;

  const FeaturedCard(
      {super.key,
      required this.title,
      required this.goal,
      required this.percentage,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.network(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // La imagen se ha cargado completamente
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    ); // Muestra un spinner mientras la imagen se carga
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    height: 150,
                    fit: BoxFit.fitHeight,
                  ); // Muestra una imagen local predeterminada si la carga falla
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Pallete.color1),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(goal,
                          style:
                              TextStyle(fontSize: 16, color: Pallete.color1)),
                      Text("$percentage%",
                          style:
                              TextStyle(fontSize: 16, color: Pallete.color1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Pallete.backgroundColor2,
                    color: Pallete.color2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
