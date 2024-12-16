import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoProvider with ChangeNotifier {
  // Stream untuk koleksi "Todo"
  Stream<QuerySnapshot> get todosStream {
    return FirebaseFirestore.instance.collection("Todo").snapshots();
  }

  // Fungsi untuk menambahkan todo
  Future<void> addTodo(Map<String, dynamic> todoData) async {
    await FirebaseFirestore.instance.collection("Todo").add(todoData);
    notifyListeners();
  }

  // Fungsi untuk memperbarui todo berdasarkan ID
  Future<void> updateTodo(String id, Map<String, dynamic> updatedData) async {
    await FirebaseFirestore.instance.collection("Todo").doc(id).update(updatedData);
    notifyListeners();
  }

  // Fungsi untuk menghapus todo berdasarkan ID
  Future<void> deleteTodo(String id) async {
    await FirebaseFirestore.instance.collection("Todo").doc(id).delete();
    notifyListeners();
  }
}
