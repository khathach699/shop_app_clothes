import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app_clothes/pages/controllers/CommentController.dart';

import 'package:shop_app_clothes/utils/constants/size.dart';

class TUserReviewCard extends StatelessWidget {
  final int productId;

  const TUserReviewCard({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    RxInt editingCommentId = RxInt(
      0,
    ); // To track the ID of the comment being edited

    return GetX<CommentController>(
      init:
          CommentController()
            ..initialize(productId), // Initialize the controller
      builder: (controller) {
        if (controller.isLoading.value) {
          return Column(
            children: [
              // Shimmer for banner
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: TSize.spaceBtwSections),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: TSize.spaceBtwSections),

              // Shimmer grid for products
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6, // Number of placeholders
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Column(
            children: [
              // Display comments if available
              if (controller.comment.isNotEmpty)
                ...controller.comment.map((comment) {
                  bool isEditing = editingCommentId.value == comment.id;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  "https://imgs.search.brave.com/3L8uuFbYeEUGCcXZzODBhDJWAYLrYQtSF5VbYwvo0x4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9ob2Fu/Z2hhbW9iaWxlLmNv/bS90aW4tdHVjL3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDIzLzA3/L2FuaC1kZXAtdGhp/ZW4tbmhpZW4tdGh1/bXAuanBn", // Example avatar URL
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                comment.username,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'update') {
                                // Edit comment
                                editingCommentId.value = comment.id;
                                commentController.text = comment.content ?? '';
                              } else if (value == 'delete') {
                                // Delete comment
                                controller.deleteComment(comment.id);
                              }
                            },
                            itemBuilder:
                                (BuildContext context) => [
                                  const PopupMenuItem<String>(
                                    value: 'update',
                                    child: Text('Update'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy').format(comment.timestamp),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReadMoreText(
                          comment.content ?? 'No content available',
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimExpandedText: "show less",
                          trimCollapsedText: "show more",
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          lessStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      Divider(),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),

              // If no comments, display a message
              if (controller.comment.isEmpty)
                const Center(child: Text('No comments available.')),

              const SizedBox(height: TSize.spaceBtwItems),

              // Always show the "Add a Comment" section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add a Comment",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: commentController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Write your comment...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (editingCommentId.value != 0) {
                          // Update comment
                          controller.updateComment(
                            editingCommentId.value,
                            commentController.text,
                          );
                          editingCommentId.value = 0; // Reset editing ID
                        } else if (commentController.text.isNotEmpty) {
                          // Add a new comment
                          controller.addComment(commentController.text);
                        }
                        commentController.clear(); // Clear the input field
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text(
                        editingCommentId.value != 0
                            ? "Update Comment"
                            : "Post Comment",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
