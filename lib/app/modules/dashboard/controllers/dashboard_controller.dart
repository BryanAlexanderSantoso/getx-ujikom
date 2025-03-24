import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/api.dart';

class DashboardController extends GetxController {
  final _getConnect = GetConnect();
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var concert = Rxn<Map<String, dynamic>>(); // Menyimpan data konser

  final token = GetStorage().read('token');

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Fungsi untuk mengambil detail konser
  Future<void> fetchConcertDetail(int id) async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get(
        "${BaseUrl.concerts}/$id",
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        concert.value = response.body;
      } else {
        Get.snackbar("Error", "Gagal mengambil detail konser");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logOut() async {
    final response = await _getConnect.post(
      BaseUrl.logout,
      {},
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Logout Success',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      GetStorage().erase();
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Failed', 'Logout Failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    eventDateController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
