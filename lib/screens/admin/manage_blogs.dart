// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:task2/services/%20storage_service.dart';
// import '../../services/firestore_service.dart';

// import '../../services/notification_service.dart';
// import '../../models/blog_model.dart';
// import '../../models/category_model.dart';

// class ManageBlogs extends StatefulWidget {
//   @override
//   _ManageBlogsState createState() => _ManageBlogsState();
// }

// class _ManageBlogsState extends State<ManageBlogs> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final StorageService _storageService = StorageService();
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _contentController = TextEditingController();
//   final _tagsController = TextEditingController();

//   String? _selectedCategoryId;
//   File? _selectedImage;
//   bool _isLoading = false;
//   bool _isEditing = false;
//   String? _editingId;
//   String? _existingImageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: StreamBuilder<List<BlogModel>>(
//             stream: _firestoreService.getAllBlogs(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }

//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               final blogs = snapshot.data!;

//               if (blogs.isEmpty) {
//                 return Center(child: Text('No blogs found'));
//               }

//               return ListView.builder(
//                 padding: EdgeInsets.all(16),
//                 itemCount: blogs.length,
//                 itemBuilder: (context, index) {
//                   final blog = blogs[index];
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 12),
//                     child: Column(
//                       children: [
//                         if (blog.imageUrl.isNotEmpty)
//                           Image.network(
//                             blog.imageUrl,
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ListTile(
//                           title: Text(blog.title),
//                           subtitle: Text(
//                             'Tags: ${blog.tags.join(", ")}\nViews: ${blog.views}',
//                           ),
//                           trailing: PopupMenuButton(
//                             itemBuilder: (context) => [
//                               PopupMenuItem(child: Text('Edit'), value: 'edit'),
//                               PopupMenuItem(
//                                 child: Text('Delete'),
//                                 value: 'delete',
//                               ),
//                             ],
//                             onSelected: (value) {
//                               if (value == 'edit') {
//                                 _editBlog(blog);
//                               } else if (value == 'delete') {
//                                 _deleteBlog(blog);
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         _buildAddBlogButton(),
//       ],
//     );
//   }

//   Widget _buildAddBlogButton() {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: ElevatedButton.icon(
//         onPressed: _showBlogForm,
//         icon: Icon(Icons.add),
//         label: Text('Add New Blog'),
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showBlogForm() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => StatefulBuilder(
//         builder: (context, setModalState) {
//           return Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//               top: 20,
//               left: 20,
//               right: 20,
//             ),
//             height: MediaQuery.of(context).size.height * 0.9,
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       _isEditing ? 'Edit Blog' : 'Create New Blog',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _titleController,
//                       decoration: InputDecoration(
//                         labelText: 'Title',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter title';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     TextFormField(
//                       controller: _contentController,
//                       decoration: InputDecoration(
//                         labelText: 'Content',
//                         border: OutlineInputBorder(),
//                       ),
//                       maxLines: 10,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter content';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     TextFormField(
//                       controller: _tagsController,
//                       decoration: InputDecoration(
//                         labelText: 'Tags (comma separated)',
//                         border: OutlineInputBorder(),
//                         hintText: 'e.g., Flutter, Dart, Mobile',
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     StreamBuilder<List<CategoryModel>>(
//                       stream: _firestoreService.getCategories(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return CircularProgressIndicator();
//                         }
//                         final categories = snapshot.data!;
//                         return DropdownButtonFormField<String>(
//                           value: _selectedCategoryId,
//                           decoration: InputDecoration(
//                             labelText: 'Category',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: categories.map((category) {
//                             return DropdownMenuItem(
//                               value: category.id,
//                               child: Text(category.name),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setModalState(() {
//                               _selectedCategoryId = value;
//                             });
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return 'Please select a category';
//                             }
//                             return null;
//                           },
//                         );
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () async {
//                         final picker = ImagePicker();
//                         final pickedFile = await picker.pickImage(
//                           source: ImageSource.gallery,
//                         );
//                         if (pickedFile != null) {
//                           setModalState(() {
//                             _selectedImage = File(pickedFile.path);
//                           });
//                         }
//                       },
//                       child: Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: _selectedImage != null
//                             ? Image.file(_selectedImage!, fit: BoxFit.cover)
//                             : (_existingImageUrl != null &&
//                                       _existingImageUrl!.isNotEmpty
//                                   ? Image.network(
//                                       _existingImageUrl!,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Center(child: Text('Tap to select image'))),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _isLoading
//                           ? null
//                           : () => _submitBlog(setModalState),
//                       child: _isLoading
//                           ? SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             )
//                           : Text(_isEditing ? 'Update' : 'Create'),
//                     ),
//                     SizedBox(height: 10),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         _resetForm();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _submitBlog(Function setModalState) async {
//     if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
//       setModalState(() => _isLoading = true);

//       try {
//         String? imageUrl = _existingImageUrl;

//         if (_selectedImage != null) {
//           if (_existingImageUrl != null && _existingImageUrl!.isNotEmpty) {
//             await _storageService.deleteImage(_existingImageUrl!);
//           }
//           imageUrl = await _storageService.uploadImage(
//             _selectedImage!,
//             'blogs',
//           );
//         }

//         final tags = _tagsController.text
//             .split(',')
//             .map((tag) => tag.trim())
//             .where((tag) => tag.isNotEmpty)
//             .toList();

//         final blogData = {
//           'title': _titleController.text,
//           'content': _contentController.text,
//           'tags': tags,
//           'imageUrl': imageUrl ?? '',
//           'categoryId': _selectedCategoryId,
//           'authorId': 'admin', // In real app, get from auth
//           'authorName': 'Admin',
//         };

//         if (_isEditing) {
//           await _firestoreService.updateBlog(_editingId!, blogData);
//           // FIXED: Using named parameters
//           await NotificationService.sendNotification(
//             title: 'Blog Updated',
//             body: 'Blog "${_titleController.text}" has been updated',
//           );
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Blog updated successfully')));
//         } else {
//           await _firestoreService.addBlog(blogData);
//           // FIXED: Using named parameters
//           await NotificationService.sendNotification(
//             title: 'New Blog Added',
//             body: 'New blog "${_titleController.text}" has been published',
//           );
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Blog created successfully')));
//         }

//         Navigator.pop(context);
//         _resetForm();
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
//       } finally {
//         setModalState(() => _isLoading = false);
//       }
//     }
//   }

//   void _editBlog(BlogModel blog) {
//     _isEditing = true;
//     _editingId = blog.id;
//     _titleController.text = blog.title;
//     _contentController.text = blog.content;
//     _tagsController.text = blog.tags.join(', ');
//     _selectedCategoryId = blog.categoryId;
//     _existingImageUrl = blog.imageUrl;
//     _showBlogForm();
//   }

//   void _deleteBlog(BlogModel blog) async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Delete Blog'),
//         content: Text('Are you sure you want to delete "${blog.title}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               if (blog.imageUrl.isNotEmpty) {
//                 await _storageService.deleteImage(blog.imageUrl);
//               }
//               await _firestoreService.deleteBlog(blog.id);
//               // FIXED: Using named parameters
//               await NotificationService.sendNotification(
//                 title: 'Blog Deleted',
//                 body: 'Blog "${blog.title}" has been deleted',
//               );
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Blog deleted successfully')),
//               );
//             },
//             child: Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _resetForm() {
//     _titleController.clear();
//     _contentController.clear();
//     _tagsController.clear();
//     _selectedCategoryId = null;
//     _selectedImage = null;
//     _existingImageUrl = null;
//     _isEditing = false;
//     _editingId = null;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _contentController.dispose();
//     _tagsController.dispose();
//     super.dispose();
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task2/services/%20storage_service.dart';
import '../../services/firestore_service.dart';

import '../../models/blog_model.dart';
import '../../models/category_model.dart';

class ManageBlogs extends StatefulWidget {
  @override
  _ManageBlogsState createState() => _ManageBlogsState();
}

class _ManageBlogsState extends State<ManageBlogs> {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();

  String? _selectedCategoryId;
  File? _selectedImage;
  bool _isLoading = false;
  bool _isEditing = false;
  String? _editingId;
  String? _existingImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<BlogModel>>(
            stream: _firestoreService.getAllBlogs(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final blogs = snapshot.data!;
              if (blogs.isEmpty) {
                return Center(child: Text('No blogs found'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(blog.title),
                      subtitle: Text('Tags: ${blog.tags.join(", ")}'),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Edit'), value: 'edit'),
                          PopupMenuItem(child: Text('Delete'), value: 'delete'),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editBlog(blog);
                          } else if (value == 'delete') {
                            _deleteBlog(blog);
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _showBlogForm,
            icon: Icon(Icons.add),
            label: Text('Add New Blog'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBlogForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20,
            ),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _isEditing ? 'Edit Blog' : 'Create New Blog',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _tagsController,
                      decoration: InputDecoration(
                        labelText: 'Tags (comma separated)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., Flutter, Dart, Mobile',
                      ),
                    ),
                    SizedBox(height: 16),
                    StreamBuilder<List<CategoryModel>>(
                      stream: _firestoreService.getCategories(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final categories = snapshot.data!;
                        return DropdownButtonFormField<String>(
                          value: _selectedCategoryId,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setModalState(() {
                              _selectedCategoryId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setModalState(() {
                            _selectedImage = File(pickedFile.path);
                          });
                        }
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : Center(child: Text('Tap to select image')),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () => _submitBlog(setModalState),
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_isEditing ? 'Update' : 'Create'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetForm();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submitBlog(Function setModalState) async {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      setModalState(() => _isLoading = true);

      try {
        String? imageUrl = _existingImageUrl;

        if (_selectedImage != null) {
          imageUrl = await _storageService.uploadImage(
            _selectedImage!,
            'blogs',
          );
        }

        final tags = _tagsController.text
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList();

        final blogData = {
          'title': _titleController.text,
          'content': _contentController.text,
          'tags': tags,
          'imageUrl': imageUrl ?? '',
          'categoryId': _selectedCategoryId,
          'authorId': 'admin',
          'authorName': 'Admin',
        };

        if (_isEditing) {
          await _firestoreService.updateBlog(_editingId!, blogData);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Blog updated')));
        } else {
          await _firestoreService.addBlog(blogData);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Blog created')));
        }

        Navigator.pop(context);
        _resetForm();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      } finally {
        setModalState(() => _isLoading = false);
      }
    }
  }

  void _editBlog(BlogModel blog) {
    _isEditing = true;
    _editingId = blog.id;
    _titleController.text = blog.title;
    _contentController.text = blog.content;
    _tagsController.text = blog.tags.join(', ');
    _selectedCategoryId = blog.categoryId;
    _existingImageUrl = blog.imageUrl;
    _showBlogForm();
  }

  void _deleteBlog(BlogModel blog) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Blog'),
        content: Text('Delete "${blog.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (blog.imageUrl.isNotEmpty) {
                await _storageService.deleteImage(blog.imageUrl);
              }
              await _firestoreService.deleteBlog(blog.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Blog deleted')));
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _titleController.clear();
    _contentController.clear();
    _tagsController.clear();
    _selectedCategoryId = null;
    _selectedImage = null;
    _existingImageUrl = null;
    _isEditing = false;
    _editingId = null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
