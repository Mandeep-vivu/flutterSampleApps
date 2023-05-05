import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ImageProvider(), // Create an instance of ImageProvider
      child: const MyApp(),
    ),
  );
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


class ImageProvider with ChangeNotifier {
  final List<File> _images = [];
  final List<String> _imageNames = [];

  List<File> get images => _images;

  Future<void> getImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();
      final appDir = await getApplicationDocumentsDirectory();
      for (final pickedFile in pickedFiles) {
        final originalFileName = pickedFile.path.split('/').last;
        final fileName = '${DateTime.now()}_$originalFileName';
        final savedImage = File(pickedFile.path).copySync('${appDir.path}/$fileName');
        _images.add(savedImage);
        _imageNames.add(originalFileName);
      }
      notifyListeners();
    } catch (e) {
      print('Error picking images: $e');
    }
  }


  Future<void> removeImage(int index) async {
    final file = File(_images[index].path);
    if (await file.exists()) {
      await file.delete();
      _images.removeAt(index);
      _imageNames.removeAt(index);
      notifyListeners();
    }
  }

  void reorderImages(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final imageToMove = _images.removeAt(oldIndex);
    final imageNameToMove = _imageNames.removeAt(oldIndex);
    _images.insert(newIndex, imageToMove);
    _imageNames.insert(newIndex, imageNameToMove);
    notifyListeners();
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Private Gallery"),
      ),
      body: Consumer<ImageProvider>(
        builder: (context, imageProvider, child) {
      if (imageProvider.images.isEmpty) {
        // Render a message when there are no images
        return  Center(
          child: RichText(
            text: const TextSpan(
              text: 'No images added, to add press the button\n',
              style: TextStyle(fontSize: 18,color: Colors.cyan),
              children: [
                TextSpan(
                  text: '\nSwipe up on an image to delete',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),TextSpan(
                  text: '\nLog tap to rearrange',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return ReorderableGridView.builder(
          itemCount: imageProvider.images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            final filen = imageProvider.images[index];
            final fileName = imageProvider._imageNames[index];
            return _buildGridTile(context,imageProvider, filen, fileName, index);
          },
          onReorder: (int oldIndex, int newIndex) {
            imageProvider.reorderImages(oldIndex, newIndex);
          },
        );
      }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ImageProvider>().getImages(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
Widget _buildGalleryPage(ImageProvider imageProvider, int index) {
  return Scaffold(
    appBar: AppBar(title: Text(imageProvider._imageNames[index])),
    body: Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: PhotoViewGallery.builder(
        itemCount: imageProvider.images.length,
        builder: (BuildContext context, int index) {
          final filen = imageProvider.images[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(filen),
            heroAttributes: PhotoViewHeroAttributes(tag: 'image$index'),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: PageController(initialPage: index),
      ),
    ),
  );
}

Widget _buildGridTile(BuildContext context, ImageProvider imageProvider, File filen, String fileName, int index) {
  return ReorderableDelayedDragStartListener(
    key: ValueKey(index),
    index: index,
    child: Dismissible(
      key: ValueKey(filen),
      onDismissed: (_) => imageProvider.removeImage(index),
      direction: DismissDirection.up,
      background: Container(
        color: Colors.red,
        child: const Center(
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _buildGalleryPage(imageProvider, index),
          ));
        },
        child: Hero(
          tag: 'image$index',
          child: GridTile(footer: Container(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
              child: Image.file(filen,fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ),
  );
}
