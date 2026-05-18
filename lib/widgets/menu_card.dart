// Mengimpor paket Flutter untuk widget dan Material Design.
import 'package:flutter/material.dart';

/// Widget kartu menu reusable yang menampilkan judul, deskripsi, dan gambar.
class MenuCard extends StatelessWidget {
  // Judul kategori menu.
  final String title;
  // Deskripsi pendek yang muncul di bawah judul.
  final String? description;
  // Callback ketika kartu ditekan.
  final VoidCallback onTap;
  // URL gambar ilustrasi untuk kartu.
  final String? imageUrl;

  const MenuCard({
    super.key,
    required this.title,
    required this.onTap,
    this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Build tampilan kartu menu dengan gambar atau icon, judul, dan deskripsi.
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              if (imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 50,
                    ),
                  ),
                ),
              ] else ...[
                const Icon(
                  Icons.article,
                  size: 50,
                ),
              ],

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}