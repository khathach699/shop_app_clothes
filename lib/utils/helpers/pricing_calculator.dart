class TPricingCalculator {
  // Phương thức tính tổng giá tiền
  static double calculateTotalPrice(double productPrice, int location) {
    double taxRate = getTaxRateForLocation(location); // Lấy tỷ lệ thuế
    double taxAmount = productPrice * taxRate; // Tính thuế
    double shippingCost = getShippingCost(location); // Lấy phí vận chuyển
    double totalPrice =
        productPrice + taxAmount + shippingCost; // Tính tổng giá tiền
    return totalPrice;
  }

  // Phương thức tính phí vận chuyển
  static String calculateShippingCost(double productPrice, int location) {
    double shippingCost = getShippingCost(location); // Lấy phí vận chuyển
    return shippingCost.toStringAsFixed(
      2,
    ); // Trả về giá trị với 2 chữ số thập phân
  }

  // Phương thức giả lập để lấy tỷ lệ thuế theo vị trí (cần thay thế bằng logic thực tế)
  static double getTaxRateForLocation(int location) {
    // Giả lập, tùy thuộc vào vị trí, tỷ lệ thuế có thể thay đổi
    // Ví dụ: nếu location == 1 thì thuế là 5%, location == 2 thì thuế là 7%, v.v.
    switch (location) {
      case 1:
        return 0.05; // 5%
      case 2:
        return 0.07; // 7%
      default:
        return 0.05; // Mặc định 5%
    }
  }

  // Phương thức giả lập để lấy phí vận chuyển theo vị trí (cần thay thế bằng logic thực tế)
  static double getShippingCost(int location) {
    // Giả lập, phí vận chuyển có thể khác nhau tùy theo vị trí
    switch (location) {
      case 1:
        return 10.0; // Phí vận chuyển cho vị trí 1
      case 2:
        return 15.0; // Phí vận chuyển cho vị trí 2
      default:
        return 12.0; // Mặc định 12.0
    }
  }
}
