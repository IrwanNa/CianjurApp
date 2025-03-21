import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ReportDetailScreen extends StatefulWidget {
  final String kategoriLaporan; // Use a meaningful variable name

  const ReportDetailScreen({super.key, required this.kategoriLaporan});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  File? _image;
  bool _isLoading = false; // Corrected variable name

  Future<void> sendData(Map<String, String> data, File? image) async {
    final url = Uri.parse('https://example.com/api/endpoint');
    setState(() {
      _isLoading = true;
    });

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'multipart/form-data';

      data.forEach((key, value) {
        request.fields[key] = value;
      });
      if (image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('foto_kejadian', image.path));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data sent successfully');
        showSuccessDialog();
      } else {
        print('Failed to send data: ${response.statusCode} $responseBody');
        showFailureDialog(responseBody);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to send data: $e');
      showFailureDialog(e.toString());
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Data berhasil dikirim'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                clearForm();
              },
            ),
          ],
        );
      },
    );
  }

  void showFailureDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failure'),
          content: Text('Gagal mengirim data: $message'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearForm() {
    _namaController.clear();
    _teleponController.clear();
    _lokasiController.clear();
    _tanggalController.clear(); // Clear date field
    _isiController.clear();
    setState(() {
      _image = null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _tanggalController.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Image picking failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unggah Foto Kejadian'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: _image == null
                          ? const Center(
                              child: Icon(Icons.camera_alt, size: 50))
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _namaController,
                    decoration:
                        const InputDecoration(labelText: 'Nama Pelapor'),
                  ),
                  TextField(
                    controller: _teleponController,
                    decoration:
                        const InputDecoration(labelText: 'Telepon Pelapor'),
                  ),
                  TextField(
                      controller: _lokasiController,
                      decoration:
                          const InputDecoration(labelText: 'Lokasi Kejadian')),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context); // Corrected method call
                    },
                    child: AbsorbPointer(
                      child: TextField(
                          controller: _tanggalController,
                          decoration: const InputDecoration(
                              labelText: 'Tanggal Kejadian')),
                    ),
                  ),
                  TextField(
                    controller: _isiController,
                    decoration: const InputDecoration(labelText: 'Isi Laporan'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final data = {
                        "nama": _namaController.text,
                        "no_telp": _teleponController.text,
                        "lokasi_kejadian": _lokasiController.text,
                        "tanggal_kejadian": _tanggalController.text,
                        "isi_laporan": _isiController.text,
                        "kategori_kejadian": widget.kategoriLaporan,
                      };
                      sendData(data, _image);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
