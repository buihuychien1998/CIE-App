import 'package:home/models/reports.dart';

class DatabaseService {
  // Phương thức giả định trả về dữ liệu mẫu
  Future<List<Reports>> getReports() async {
    // Dữ liệu mẫu
    return [
      Reports(year: 2021, quantity: 10),
      Reports(year: 2022, quantity: 20),
      Reports(year: 2023, quantity: 30),
      Reports(year: 2024, quantity: 40),
    ];
  }
}