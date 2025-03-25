import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/models/Comment.dart';
import 'package:shop_app_clothes/pages/service/CommentService.dart';
import '../service/StorageService.dart';

class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;
  var editingCommentId = RxInt(0);
  TextEditingController? commentController; // ✅ Dùng nullable để tránh lỗi

  int productId = 0;
  int? userId;

  @override
  void onInit() {
    super.onInit();
    commentController = TextEditingController(); // ✅ Khởi tạo khi onInit
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
    update();
  }

  void initialize(int productId) {
    this.productId = productId;
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      isLoading(true);

      final fetchedComments = await CommentService().getCommentsByProduct(
        productId,
      );
      comments.assignAll(fetchedComments);
    } catch (e) {
      errorMessage.value = 'Failed to load comments';
    } finally {
      isLoading(false);
    }
  }

  Future<void> addComment() async {
    if (userId == null) {
      Get.snackbar(
        'Lỗi',
        'Bạn chưa đăng nhập.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (commentController?.text.isEmpty ?? true) {
      return;
    }

    final newComment = Comment(
      username: "khathach",
      timestamp: DateTime.now(),
      content: commentController!.text,
      id: 0,
      productId: productId,
      userId: userId!,
    );

    try {
      final addedComment = await CommentService().addComment(newComment);
      comments.add(addedComment);
      commentController?.clear();
      Get.snackbar(
        'Thành công',
        'Cảm ơn bạn đã bình luận!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng thử lại sau.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void startEditing(int commentId, String content) {
    editingCommentId.value = commentId;
    commentController?.text = content; // ✅ Kiểm tra null trước khi gán
  }

  void cancelEditing() {
    editingCommentId.value = 0;
    commentController?.clear();
  }

  Future<void> updateComment() async {
    if (editingCommentId.value == 0) return;
    try {
      final updatedComment = await CommentService().updateComment(
        editingCommentId.value,
        commentController!.text,
        userId!,
      );
      final index = comments.indexWhere((c) => c.id == editingCommentId.value);
      if (index != -1) {
        comments[index] = updatedComment;
        comments.refresh();
        Get.snackbar(
          'Cập nhât thành  công',
          'Cảm ơn bạn đã cập nhât bình luận!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {}
      cancelEditing();
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Cập nhật thất bại.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteComment(int commentId, int userId) async {
    try {
      await CommentService().deleteComment(commentId, userId);

      if (comments.isEmpty) {
        return;
      }

      bool exists = comments.any((c) => c.id == commentId);
      if (!exists) {
        return;
      }

      // Xóa comment khỏi danh sách
      comments.removeWhere((c) => c.id == commentId);
      Get.snackbar(
        'Xoá thành công',
        '',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Xóa thất bại.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    commentController?.dispose();
    super.onClose();
  }
}
