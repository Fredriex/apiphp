import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'viewbarang.dart';
import 'barang.dart';
import 'addbarang.dart';
import 'editbarang.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Barang> _barangList = <Barang>[];
  var response;
  var panjang = 0;
  String result = '';

  bacabarang() async {
    try {
      var result = await http.get(Uri.parse("http://192.168.222"
          ".5/android/membaca.php"));
      log(result.body.toString());

      setState(() {
        _barangList = <Barang>[];
        var hasil = jsonDecode(result.body)['data'];
        hasil.forEach((barang) {
          var x = Barang(
            barang['kode'] ?? '',
            barang['nama'] ?? '',
            barang['satuan'] ?? '',
            int.tryParse(barang['hargaBeli'].toString()) ?? 0,
            int.tryParse(barang['hargaJual'].toString()) ?? 0,
          );
          _barangList.add(x);
        });
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    bacabarang();
  }

  _deleteFormDialog(BuildContext context, String kode) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Kamu Yakin Menghapus',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    try {
                      var request = http.MultipartRequest('POST',
                          Uri.parse('http://192.168.1.5/android/hapus.php'));
                      request.fields.addAll({'kode': kode, 'save': 'ok'});
                      http.StreamedResponse response = await request.send();
                      var responseData = await response.stream.bytesToString();
                      log(responseData);
                      if (response.statusCode == 201) {
                        setState(() {
                          result = responseData.toString();
                        });
                      } else {
                        throw Exception('Failed to delete data');
                      }
                    } catch (e) {
                      setState(() {
                        result = 'Error: $e';
                      });
                    }
                    if (result.isNotEmpty) {
                      bacabarang();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Kasir'),
      ),
      body: ListView.builder(
          itemCount: _barangList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewBarang(
                            barang: _barangList[index],
                          ))).then((data) {
                    if (data != null) {
                      bacabarang();
                    }
                  });
                },
                leading: const Icon(Icons.shopping_cart),
                iconColor: Colors.purple,
                title: Text(_barangList[index].kode ?? ''),
                subtitle: Text(_barangList[index].nama ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditBarang(
                                    barang: _barangList[index],
                                  ))).then((data) {
                            if (data != null) {
                              bacabarang();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _barangList[index].kode!);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addbarang()))
              .then((data) {
            if (data == true) {
              bacabarang();
            }
          });
        },
        tooltip: 'Increment',
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
