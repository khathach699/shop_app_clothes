import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/features/shop/models/Comment.dart';
import 'package:shop_app_clothes/features/shop/screens/service/CommentService.dart';

class CommentController extends GetxController {
  var comment = <Comment>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;
  late int productId;

  @override
  void onInit() {
    super.onInit();
  }

  void initialize(int productId) {
    this.productId = productId;
    fetchComments(productId);
  }

  Future<void> fetchComments(int productId) async {
    try {
      isLoading(true);
      final List<Comment> fetchedComments = await CommentService().getComments(
        productId,
      );
      comment.assignAll(fetchedComments);
    } catch (e) {
      errorMessage.value = 'Failed to load comments';
    } finally {
      isLoading(false);
    }
  }

  Future<void> addComment(String content) async {
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;
    final newComment = Comment(
      username: "khathach",
      timestamp: DateTime.now(),
      content: content,
      id: 0,
      productId: productId,
      userId: userId,
    );

    try {
      final Comment addedComment = await CommentService().addComment(
        newComment,
      );
      comment.add(addedComment);
    } catch (e) {
      errorMessage.value = 'Failed to add comment';
    }
  }

  Future<void> updateComment(int commentId, String newContent) async {
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    try {
      final Comment updatedComment = await CommentService().updateComment(
        commentId,
        userId,
        newContent,
      );
      final index = comment.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        comment[index] = updatedComment;
      }
    } catch (e) {
      errorMessage.value = 'Failed to update comment';
    }
  }

  Future<void> deleteComment(int commentId) async {
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    try {
      await CommentService().deleteComment(commentId, userId);
      comment.removeWhere((c) => c.id == commentId);
    } catch (e) {
      errorMessage.value = 'Failed to delete comment';
    }
  }
}
