import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// -----------------------------------------------------------------------------
// 1. MODEL DATA (Sesuai Ketentuan 2 & 3)
// Menggunakan 4 tipe data Dart: String, double, int, bool
// -----------------------------------------------------------------------------
class CatatanTidur {
  final String tanggal;
  final double durasiJam;
  final int skorKualitas; // Skala 1 - 10
  final bool isMimpi;

  const CatatanTidur({
    required this.tanggal,
    required this.durasiJam,
    required this.skorKualitas,
    required this.isMimpi,
  });
}

// -----------------------------------------------------------------------------
// 2. MYAPP (Sesuai Ketentuan 1 & 5)
// Memiliki HANYA SATU MaterialApp dan mengatur ThemeData khusus (Deep Purple)
// -----------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleep & Dream Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LayarUtama(),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. HALAMAN UTAMA (Sesuai Ketentuan 1 & 7)
// Menggunakan Scaffold TANPA MaterialApp kedua, anti-overflow dengan SingleChildScrollView
// -----------------------------------------------------------------------------
class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Object data milik sendiri (Sesuai Ketentuan 2 & 3)
    const mySleepLog = CatatanTidur(
      tanggal: "19 Oktober 2026",
      durasiJam: 7.5,
      skorKualitas: 8,
      isMimpi: true,
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Jurnal Kualitas Tidur'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Custom Widget dipanggil di sini (Sesuai Ketentuan 6)
              const KartuRingkasanTidur(dataTidur: mySleepLog),
              const SizedBox(height: 20),
              // ElevatedButton dengan callback onPressed (Sesuai Ketentuan 4)
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint("Tombol Tambah Catatan Tidur diklik!");
                },
                icon: const Icon(Icons.add_alarm),
                label: const Text('Tambah Catatan Baru'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. CUSTOM WIDGET TERPISAH (Sesuai Ketentuan 4 & 6)
// Memisahkan kartu ringkasan menjadi Custom Widget terpisah
// -----------------------------------------------------------------------------
class KartuRingkasanTidur extends StatelessWidget {
  final CatatanTidur dataTidur;

  const KartuRingkasanTidur({
    super.key,
    required this.dataTidur,
  });

  @override
  Widget build(BuildContext context) {
    // Card, Container, BoxDecoration, Padding, Column, Row, Text, Icon (Ketentuan 4)
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepPurple.shade100, width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bedtime, size: 32, color: Colors.deepPurple),
                const SizedBox(width: 10),
                Text(
                  dataTidur.tanggal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  icon: Icons.access_time,
                  label: "Durasi",
                  value: "${dataTidur.durasiJam} Jam",
                ),
                _buildInfoItem(
                  icon: Icons.star_rate_rounded,
                  label: "Kualitas",
                  value: "${dataTidur.skorKualitas}/10",
                ),
                _buildInfoItem(
                  icon: Icons.nightlight_round,
                  label: "Mimpi",
                  value: dataTidur.isMimpi ? "Ya" : "Tidak",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk memperrapi baris informasi
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.deepPurpleAccent),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}