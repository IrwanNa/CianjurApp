import 'package:flutter/material.dart';
import 'report_button.dart';
import 'report_detail_screen.dart';

class ReportTypeScreen extends StatelessWidget {
  const ReportTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Laporkan jika ada keadaan darurat disekitar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
              child: Text(
                'Keamanan Masyarakat adalah tugas kami',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 16),
            ReportButton(
              label: 'Keadaan Darurat',
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailScreen(
                      kategoriLaporan: 'kebersihan',
                    ),
                  ),
                );
              },
            ),
            ReportButton(
              label: 'Keadaan Tanggap Darurat',
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailScreen(
                      kategoriLaporan: 'kekerasan',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
