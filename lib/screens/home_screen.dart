import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';
import '../widgets/photo_grid.dart';
import '../widgets/right_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Viewer Premium", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cerca foto...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                Provider.of<PhotoProvider>(context, listen: false).setSearchQuery(value);
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Row(
        children: [
          const Expanded(
            child: PhotoGrid(),
          ),
          const RightSidebar(),
        ],
      ),
    );
  }
}
