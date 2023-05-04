import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<File> _images = []; // list of uploaded images
  final List<String> _imageNames = [];

  Future<void> _getImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final originalFileName = pickedFile.path.split('/').last;
        final fileName = DateTime.now().toString() + '_' + originalFileName;
        final savedImage = File(pickedFile.path).copySync('${appDir.path}/$fileName');
        setState(() {
          _images.add(savedImage);
          _imageNames.add(originalFileName);
        });
      }
    } catch (e) {
      // Handle any exceptions here
      print('Error picking image: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to pick image from gallery.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  Future<void> _removeImage(int index) async {

    final file = File(_images[index].path);


    if (await file.exists()) {
      await file.delete();
      setState(() {
        _images.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GridView.builder(itemCount: _images.length,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,crossAxisSpacing: 0,mainAxisSpacing: 10,
      ), itemBuilder: (BuildContext context, int index) {
        final filen = _images[index];
        final fileName = _imageNames[index];

        return Stack(
          children: [
            GridTile(
              footer: GridTileBar(title: Text(
                fileName
              ),),
              child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.file(filen, fit: BoxFit.fill),
          ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
        ]
        );
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _getImage,child: const Icon(Icons.add),),
    );
  }
}
