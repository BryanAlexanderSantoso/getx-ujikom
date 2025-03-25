import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aku_pengen_mudik_gabawa_laptop/app/data/acara_response.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dashboard_detail_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late Future<List<AcaraResponse>> futureAcara;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
    futureAcara = fetchAcara();
  }

  Future<List<AcaraResponse>> fetchAcara() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/concerts'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print('Response API: $jsonResponse');

      return jsonResponse.map<AcaraResponse>((acara) {
        print('Image URL: ${acara['image']}');
        acara['image'] = 'http://127.0.0.1:8000/storage/${acara['image']}';
        return AcaraResponse.fromJson(acara);
      }).toList();
    } else {
      throw Exception('Failed to load acara');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<AcaraResponse>>(
        future: futureAcara,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada acara yang ditemukan',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                AcaraResponse acara = snapshot.data![index];
                print('Displaying Image: ${acara.image}');

                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail konser
                    Get.to(() => DetailAcaraView(acara: acara));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Image.network(
                            acara.image ?? '',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  acara.concertName ??
                                      'Nama Acara Tidak Tersedia',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  acara.venue ?? 'Lokasi Tidak Tersedia',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      acara.date != null
                                          ? formatTanggal(acara.date!)
                                          : 'Tanggal Tidak Tersedia',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  /// Fungsi untuk mencoba berbagai format tanggal agar parsing lebih fleksibel
  String formatTanggal(String tanggal) {
    List<String> formats = [
      'dd MMMM yyyy', // 12 Maret 2024
      'dd/MM/yyyy',   // 12/03/2024
      'yyyy-MM-dd'    // 2024-03-12
    ];

    for (String format in formats) {
      try {
        return DateFormat('dd MMMM yyyy', 'id_ID').format(
          DateFormat(format, 'id_ID').parseStrict(tanggal),
        );
      } catch (e) {
        continue; // Jika gagal, coba format berikutnya
      }
    }

    return 'Format Tanggal Tidak Valid';
  }
}
