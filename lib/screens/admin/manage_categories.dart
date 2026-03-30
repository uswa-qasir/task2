// import 'package:flutter/material.dart';
// import '../../services/firestore_service.dart';
// import '../../services/notification_service.dart';
// import '../../models/category_model.dart';

// class ManageCategories extends StatefulWidget {
//   @override
//   _ManageCategoriesState createState() => _ManageCategoriesState();
// }

// class _ManageCategoriesState extends State<ManageCategories> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   bool _isEditing = false;
//   String? _editingId;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16),
//           child: Card(
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Category Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter category name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 12),
//                     TextFormField(
//                       controller: _descriptionController,
//                       decoration: InputDecoration(
//                         labelText: 'Description',
//                         border: OutlineInputBorder(),
//                       ),
//                       maxLines: 3,
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: _submitCategory,
//                             child: Text(_isEditing ? 'Update' : 'Add Category'),
//                           ),
//                         ),
//                         if (_isEditing)
//                           TextButton(
//                             onPressed: _cancelEdit,
//                             child: Text('Cancel'),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: StreamBuilder<List<CategoryModel>>(
//             stream: _firestoreService.getCategories(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }

//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               final categories = snapshot.data!;

//               if (categories.isEmpty) {
//                 return Center(child: Text('No categories found'));
//               }

//               return ListView.builder(
//                 padding: EdgeInsets.all(16),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 12),
//                     child: ListTile(
//                       title: Text(category.name),
//                       subtitle: Text(category.description),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () => _editCategory(category),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _deleteCategory(category),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   void _submitCategory() async {
//     if (_formKey.currentState!.validate()) {
//       if (_isEditing) {
//         await _firestoreService.updateCategory(
//           _editingId!,
//           _nameController.text,
//           _descriptionController.text,
//         );
//         // FIXED: Using named parameters
//         await NotificationService.sendNotification(
//           title: 'Category Updated',
//           body: 'Category "${_nameController.text}" has been updated',
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Category updated successfully')),
//         );
//         _cancelEdit();
//       } else {
//         await _firestoreService.addCategory(
//           _nameController.text,
//           _descriptionController.text,
//         );
//         // FIXED: Using named parameters
//         await NotificationService.sendNotification(
//           title: 'Category Added',
//           body: 'New category "${_nameController.text}" has been added',
//         );
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Category added successfully')));
//         _clearForm();
//       }
//     }
//   }

//   void _editCategory(CategoryModel category) {
//     setState(() {
//       _isEditing = true;
//       _editingId = category.id;
//       _nameController.text = category.name;
//       _descriptionController.text = category.description;
//     });
//   }

//   void _deleteCategory(CategoryModel category) async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Delete Category'),
//         content: Text('Are you sure you want to delete "${category.name}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await _firestoreService.deleteCategory(category.id);
//               // FIXED: Using named parameters
//               await NotificationService.sendNotification(
//                 title: 'Category Deleted',
//                 body: 'Category "${category.name}" has been deleted',
//               );
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Category deleted successfully')),
//               );
//             },
//             child: Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _cancelEdit() {
//     setState(() {
//       _isEditing = false;
//       _editingId = null;
//       _clearForm();
//     });
//   }

//   void _clearForm() {
//     _nameController.clear();
//     _descriptionController.clear();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/category_model.dart';

class ManageCategories extends StatefulWidget {
  @override
  _ManageCategoriesState createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isEditing = false;
  String? _editingId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter category name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submitCategory,
                            child: Text(_isEditing ? 'Update' : 'Add Category'),
                          ),
                        ),
                        if (_isEditing)
                          TextButton(
                            onPressed: _cancelEdit,
                            child: Text('Cancel'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<CategoryModel>>(
            stream: _firestoreService.getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final categories = snapshot.data!;
              if (categories.isEmpty) {
                return Center(child: Text('No categories found'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(category.name),
                      subtitle: Text(category.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editCategory(category),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCategory(category),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _submitCategory() async {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        await _firestoreService.updateCategory(
          _editingId!,
          _nameController.text,
          _descriptionController.text,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Category updated')));
        _cancelEdit();
      } else {
        await _firestoreService.addCategory(
          _nameController.text,
          _descriptionController.text,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Category added')));
        _clearForm();
      }
    }
  }

  void _editCategory(CategoryModel category) {
    setState(() {
      _isEditing = true;
      _editingId = category.id;
      _nameController.text = category.name;
      _descriptionController.text = category.description;
    });
  }

  void _deleteCategory(CategoryModel category) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Category'),
        content: Text('Delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _firestoreService.deleteCategory(category.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Category deleted')));
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _editingId = null;
      _clearForm();
    });
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
