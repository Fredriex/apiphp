import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'barang.dart';

class EditBarang extends StatefulWidget {
  final Barang barang;

  EditBarang({required this.barang});

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  late TextEditingController _kodeController;
  late TextEditingController _namaController;
  late TextEditingController _satuanController;
  late TextEditingController _hargabeliController;
  late TextEditingController _hargajualController;

  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  String result = '';

  @override
  void initState() {
    super.initState();
    _kodeController = TextEditingController(text: widget.barang.kode);
    _namaController = TextEditingController(text: widget.barang.nama);
    _satuanController = TextEditingController(text: widget.barang.satuan);
    _hargabeliController = TextEditingController(text: widget.barang.hargabeli.toString());
    _hargajualController = TextEditingController(text: widget.barang.hargajual.toString());
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _satuanController.dispose();
    _hargabeliController.dispose();
    _hargajualController.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.5/android/ubah.php'));
      request.fields.addAll({
        'id': widget.barang.kode.toString(),
        'kode': _kodeController.text,
        'nama': _namaController.text,
        'satuan': _satuanController.text,
        'hargabeli': _hargabeliController.text,
        'hargajual': _hargajualController.text,
        'update': 'ok'
      });

      log(request.fields.toString()); // Log the request fields to check them

      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log('Response status: ${response.statusCode}');
      log('Response body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(responseBody);
        setState(() {
          result = 'Update successful';
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to update data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Barang',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Nama',
                    labelText: 'Nama',
                    errorText: _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _satuanController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Satuan',
                    labelText: 'Satuan',
                    errorText: _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargabeliController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Beli',
                    labelText: 'Harga Beli',
                    errorText: _validatehargabeli ? 'Harga Beli Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargajualController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Jual',
                    labelText: 'Harga Jual',
                    errorText: _validatehargajual ? 'Harga Jual Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _kodeController.text.isEmpty
                              ? _validateKode = true
                              : _validateKode = false;
                          _namaController.text.isEmpty
                              ? _validateNama = true
                              : _validateNama = false;
                          _satuanController.text.isEmpty
                              ? _validateSatuan = true
                              : _validateSatuan = false;
                          _hargabeliController.text.isEmpty
                              ? _validatehargabeli = true
                              : _validatehargabeli = false;
                          _hargajualController.text.isEmpty
                              ? _validatehargajual = true
                              : _validatehargajual = false;
                        });
                        if (!_validateKode &&
                            !_validateNama &&
                            !_validateSatuan &&
                            !_validatehargabeli &&
                            !_validatehargajual) {
                          await _updateData();
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _kodeController.text = '';
                        _namaController.text = '';
                        _satuanController.text = '';
                        _hargabeliController.text = '';
                        _hargajualController.text = '';
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
