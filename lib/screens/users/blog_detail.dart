// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../services/firestore_service.dart';
// import '../../models/blog_model.dart';

// class BlogDetail extends StatefulWidget {
//   final String blogId;

//   BlogDetail({required this.blogId});

//   @override
//   _BlogDetailState createState() => _BlogDetailState();
// }

// class _BlogDetailState extends State<BlogDetail> {
//   final FirestoreService _firestoreService = FirestoreService();
//   BlogModel? _blog;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadBlog();
//   }

//   Future<void> _loadBlog() async {
//     final blog = await _firestoreService.getBlogById(widget.blogId);
//     if (blog != null) {
//       await _firestoreService.incrementBlogViews(widget.blogId);
//       setState(() {
//         _blog = blog;
//         _isLoading = false;
//       });
//     } else {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Loading...')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (_blog == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Blog Not Found')),
//         body: Center(child: Text('Blog not found')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text(_blog!.title)),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (_blog!.imageUrl.isNotEmpty)
//               CachedNetworkImage(
//                 imageUrl: _blog!.imageUrl,
//                 width: double.infinity,
//                 height: 250,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Container(
//                   height: 250,
//                   color: Colors.grey[300],
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//                 errorWidget: (context, url, error) => Container(
//                   height: 250,
//                   color: Colors.grey[300],
//                   child: Icon(Icons.error),
//                 ),
//               ),
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _blog!.title,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.person, size: 16, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text(_blog!.authorName),
//                       SizedBox(width: 16),
//                       Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text('${_blog!.views} views'),
//                       SizedBox(width: 16),
//                       Icon(Icons.access_time, size: 16, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text(_formatDate(_blog!.createdAt)),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Wrap(
//                     spacing: 8,
//                     children: _blog!.tags.map((tag) {
//                       return Chip(
//                         label: Text(tag),
//                         backgroundColor: Colors.blue[50],
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 24),
//                   Text(
//                     _blog!.content,
//                     style: TextStyle(fontSize: 16, height: 1.5),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Last updated: ${_formatDate(_blog!.updatedAt)}',
//                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/firestore_service.dart';
import '../../models/blog_model.dart';

class BlogDetail extends StatefulWidget {
  final String blogId;
  BlogDetail({required this.blogId});

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  final FirestoreService _firestoreService = FirestoreService();
  BlogModel? _blog;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBlog();
  }

  Future<void> _loadBlog() async {
    final blog = await _firestoreService.getBlogById(widget.blogId);
    if (blog != null) {
      await _firestoreService.incrementBlogViews(widget.blogId);
      setState(() {
        _blog = blog;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_blog == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Blog Not Found')),
        body: Center(child: Text('Blog not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_blog!.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_blog!.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: _blog!.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _blog!.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(_blog!.authorName),
                      SizedBox(width: 16),
                      Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('${_blog!.views} views'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: _blog!.tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue[50],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),
                  Text(
                    _blog!.content,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
