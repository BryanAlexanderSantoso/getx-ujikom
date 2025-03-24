import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class ConcertDetailPage extends StatelessWidget {
  final int concertId;
  final DashboardController controller = Get.put(DashboardController());

  ConcertDetailPage({super.key, required this.concertId});

  @override
  Widget build(BuildContext context) {
    controller.fetchConcertDetail(concertId);

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Konser")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.concert.value == null) {
          return const Center(child: Text("Konser tidak ditemukan"));
        }

        final concert = controller.concert.value!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "http://127.0.0.1:8000/storage/${concert['image']}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(concert['concert_name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Venue: ${concert['venue']}"),
              Text("Tanggal: ${concert['date']}"),
              Text("Harga Tiket: Rp ${concert['ticket_price']}"),
            ],
          ),
        );
      }),
    );
  }
}
