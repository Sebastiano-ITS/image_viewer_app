import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/api_service.dart';

class PhotoProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Photo> _photos = [];
  bool _isLoading = false;
  double _gridSize = 200.0;
  String _sortBy = 'created_at';
  String _order = 'DESC';
  String _searchQuery = '';

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;
  double get gridSize => _gridSize;
  String get sortBy => _sortBy;
  String get order => _order;

  void setGridSize(double size) {
    _gridSize = size;
    notifyListeners();
  }

  void setSorting(String field, String direction) {
    _sortBy = field;
    _order = direction;
    fetchPhotos();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _photos = await _apiService.getPhotos(
        name: _searchQuery.isEmpty ? null : _searchQuery,
        sortBy: _sortBy,
        order: _order,
      );
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> scanFolder(String path) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.scanFolder(path);
      await fetchPhotos();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
