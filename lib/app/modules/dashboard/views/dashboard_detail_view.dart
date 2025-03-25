import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aku_pengen_mudik_gabawa_laptop/app/data/acara_response.dart';

class DetailAcaraView extends StatelessWidget {
  final AcaraResponse acara;

  const DetailAcaraView({super.key, required this.acara});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(acara.concertName ?? "Detail Acara"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan Gambar
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  acara.image ?? '',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 200,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama Konser
            Text(
              acara.concertName ?? "Unknown Concert",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Venue (Tempat Konser)
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  acara.venue ?? "Unknown Venue",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Tanggal Konser
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  acara.date ?? "Unknown Date",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Harga Tiket
            Row(
              children: [
                const Icon(
                  Icons.attach_money,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  acara.ticketPrice ?? "Unknown Price",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}