import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:readmore/readmore.dart';
import 'package:shop_app_clothes/pages/controllers/CommentController.dart';

class TUserReviewCard extends StatelessWidget {
  final int productId;

  const TUserReviewCard({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommentController());
    controller.initialize(productId);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          if (controller.comments.isNotEmpty)
            ...controller.comments.map((comment) {
              bool isEditing = controller.editingCommentId.value == comment.id;
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
                              "https://imgs.search.brave.com/dOj85iRioEBJp9wQnjAWbyHkRYFf46EWsPUz91INiPo/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/bWVkaWEuc2ZvcnVt/LnZuL3N0b3JhZ2Uv/YXBwL21lZGlhL2Fu/aC1kZXAtOS5qcGc",
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
                            controller.startEditing(comment.id, comment.content ?? '');
                          } else if (value == 'delete') {
                            controller.deleteComment(comment.id,comment.userId);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'update', child: Text('Cập nhật')),
                          const PopupMenuItem(value: 'delete', child: Text('Xóa')),
                        ],
                        icon: const Icon(Icons.more_vert),
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
                      trimExpandedText: "Thu gọn",
                      trimCollapsedText: "Xem thêm",
                      moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                      lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),

          if (controller.comments.isEmpty)
            const Center(child: Text('Không có bình luận.')),

          _buildCommentInput(controller),
        ],
      );
    });
  }

  Widget _buildCommentInput(CommentController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: controller.commentController,
            decoration: InputDecoration(hintText: "Viết bình luận..."),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => controller.editingCommentId.value == 0
                ? controller.addComment()
                : controller.updateComment(),
            child: Text(controller.editingCommentId.value == 0 ? "Gửi" : "Cập nhật"),
          ),
        ],
      ),
    );
  }
}
