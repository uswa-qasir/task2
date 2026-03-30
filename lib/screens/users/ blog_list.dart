// // import 'package:flutter/material.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import '../../services/firestore_service.dart';
// // import '../../models/blog_model.dart';
// // import 'blog_detail.dart';

// // class BlogList extends StatelessWidget {
// //   final FirestoreService _firestoreService = FirestoreService();

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<List<BlogModel>>(
// //       stream: _firestoreService.getAllBlogs(),
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError) {
// //           return Center(child: Text('Error: ${snapshot.error}'));
// //         }

// //         if (!snapshot.hasData) {
// //           return Center(child: CircularProgressIndicator());
// //         }

// //         final blogs = snapshot.data!;

// //         if (blogs.isEmpty) {
// //           return Center(child: Text('No blogs available'));
// //         }

// //         return ListView.builder(
// //           padding: EdgeInsets.all(16),
// //           itemCount: blogs.length,
// //           itemBuilder: (context, index) {
// //             final blog = blogs[index];
// //             return Card(
// //               margin: EdgeInsets.only(bottom: 16),
// //               child: InkWell(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => BlogDetail(blogId: blog.id),
// //                     ),
// //                   );
// //                 },
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     if (blog.imageUrl.isNotEmpty)
// //                       CachedNetworkImage(
// //                         imageUrl: blog.imageUrl,
// //                         height: 200,
// //                         width: double.infinity,
// //                         fit: BoxFit.cover,
// //                         placeholder: (context, url) => Container(
// //                           height: 200,
// //                           color: Colors.grey[300],
// //                           child: Center(child: CircularProgressIndicator()),
// //                         ),
// //                         errorWidget: (context, url, error) => Container(
// //                           height: 200,
// //                           color: Colors.grey[300],
// //                           child: Icon(Icons.error),
// //                         ),
// //                       ),
// //                     Padding(
// //                       padding: EdgeInsets.all(16),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             blog.title,
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           SizedBox(height: 8),
// //                           Text(
// //                             blog.content.length > 100
// //                                 ? '${blog.content.substring(0, 100)}...'
// //                                 : blog.content,
// //                             style: TextStyle(color: Colors.grey[600]),
// //                           ),
// //                           SizedBox(height: 12),
// //                           Wrap(
// //                             spacing: 8,
// //                             children: blog.tags.map((tag) {
// //                               return Chip(
// //                                 label: Text(tag),
// //                                 backgroundColor: Colors.blue[50],
// //                                 materialTapTargetSize:
// //                                     MaterialTapTargetSize.shrinkWrap,
// //                               );
// //                             }).toList(),
// //                           ),
// //                           SizedBox(height: 8),
// //                           Row(
// //                             children: [
// //                               Icon(
// //                                 Icons.remove_red_eye,
// //                                 size: 16,
// //                                 color: Colors.grey,
// //                               ),
// //                               SizedBox(width: 4),
// //                               Text('${blog.views} views'),
// //                               SizedBox(width: 16),
// //                               Icon(
// //                                 Icons.access_time,
// //                                 size: 16,
// //                                 color: Colors.grey,
// //                               ),
// //                               SizedBox(width: 4),
// //                               Text(
// //                                 _formatDate(blog.createdAt),
// //                                 style: TextStyle(color: Colors.grey[600]),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   String _formatDate(DateTime date) {
// //     return '${date.day}/${date.month}/${date.year}';
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../services/firestore_service.dart';
// import '../../models/blog_model.dart';
// import 'blog_detail.dart';

// class BlogList extends StatelessWidget {
//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<BlogModel>>(
//       stream: _firestoreService.getAllBlogs(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 64, color: Colors.red),
//                 SizedBox(height: 16),
//                 Text('Error: ${snapshot.error}'),
//               ],
//             ),
//           );
//         }

//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         final blogs = snapshot.data!;

//         if (blogs.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.article_outlined, size: 80, color: Colors.grey[400]),
//                 SizedBox(height: 16),
//                 Text(
//                   'No blogs available',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Check back later for new content!',
//                   style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(16),
//           itemCount: blogs.length,
//           itemBuilder: (context, index) {
//             final blog = blogs[index];
//             return Card(
//               margin: EdgeInsets.only(bottom: 16),
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BlogDetail(blogId: blog.id),
//                     ),
//                   );
//                 },
//                 borderRadius: BorderRadius.circular(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (blog.imageUrl.isNotEmpty)
//                       ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(12),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl: blog.imageUrl,
//                           height: 200,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => Container(
//                             height: 200,
//                             color: Colors.grey[300],
//                             child: Center(child: CircularProgressIndicator()),
//                           ),
//                           errorWidget: (context, url, error) => Container(
//                             height: 200,
//                             color: Colors.grey[300],
//                             child: Icon(Icons.error),
//                           ),
//                         ),
//                       ),
//                     Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             blog.title,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             blog.content.length > 100
//                                 ? '${blog.content.substring(0, 100)}...'
//                                 : blog.content,
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                           SizedBox(height: 12),
//                           Wrap(
//                             spacing: 8,
//                             children: blog.tags.map((tag) {
//                               return Chip(
//                                 label: Text(tag),
//                                 backgroundColor: Colors.blue[50],
//                                 materialTapTargetSize:
//                                     MaterialTapTargetSize.shrinkWrap,
//                                 padding: EdgeInsets.zero,
//                                 labelStyle: TextStyle(fontSize: 12),
//                               );
//                             }).toList(),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.remove_red_eye,
//                                 size: 16,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(width: 4),
//                               Text('${blog.views} views'),
//                               SizedBox(width: 16),
//                               Icon(
//                                 Icons.access_time,
//                                 size: 16,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 _formatDate(blog.createdAt),
//                                 style: TextStyle(color: Colors.grey[600]),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/firestore_service.dart';
import '../../models/blog_model.dart';
import 'blog_detail.dart';

class BlogList extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BlogModel>>(
      stream: _firestoreService.getAllBlogs(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final blogs = snapshot.data!;

        if (blogs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.article_outlined, size: 80, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'No blogs available',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Text(
                  'Check back later for new content!',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            final blog = blogs[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlogDetail(blogId: blog.id),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (blog.imageUrl.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: blog.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            blog.content.length > 100
                                ? '${blog.content.substring(0, 100)}...'
                                : blog.content,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: blog.tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                backgroundColor: Colors.blue[50],
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text('${blog.views} views'),
                              SizedBox(width: 16),
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${blog.createdAt.day}/${blog.createdAt.month}/${blog.createdAt.year}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
