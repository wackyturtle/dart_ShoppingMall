import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'dart:io';
import 'package:collection/collection.dart';

//제품 클래스
class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}

//쇼핑몰 클래스(제품 리스트, 카트 리스트)
class ShoppingMall {
  final List<Product> products;
  final List<String> cartItems = [];
  int total = 0;

  ShoppingMall(this.products);

  void showProducts() {
    //제품목록 보기 함수
    for (Product product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart() {
    //카트에 담는 함수
    stdout.write('상품 이름을 입력하세요: ');
    final nameInput = stdin.readLineSync();
    Product? product;

    for (final p in products) {
      if (p.name == nameInput) {
        product = p;
        break;
      }
    }

    if (product == null) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    stdout.write('상품 개수를 입력하세요: ');
    final countStr = stdin.readLineSync();
    int count;
    try {
      count = int.parse(countStr ?? '');
      if (count <= 0) {
        print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
        return;
      }
    } catch (_) {
      print("입력값이 올바르지 않아요 !");
      return;
    }

    total += product.price * count;
    for (int i = 0; i < count; i++) {
      cartItems.add(product.name);
    }
    print('장바구니에 상품이 담겼어요 !');
  }

  void showTotal() {
    //총 가격 함수
    if (cartItems.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      final distinct = cartItems.toSet().toList();
      final names = distinct.join(', ');
      print('장바구니에 $names 가 담겨있습니다. 총 ${total}원 입니다!');
    }
  }

  void clearCart() {
    // 카트 초기화 함수
    if (cartItems.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      cartItems.clear();
      total = 0;
      print('장바구니를 초기화합니다.');
    }
  }
}

void main() {
  final mall = ShoppingMall([
    Product('shirt', 45000),
    Product('dress', 30000),
    Product('tshirt', 35000),
    Product('shorts', 38000),
    Product('socks', 5000),
  ]);

  bool running = true;

  while (running) {
    print(
      '\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화',
    );
    stdout.write('메뉴를 선택하세요: ');
    final input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4':
        stdout.write('정말 종료하시겠습니까? 종료하려면 5를 입력하세요: ');
        final confirm = stdin.readLineSync();
        if (confirm == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
          running = false;
        } else {
          print('종료하지 않습니다.');
        }
        break;
      case '6':
        mall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
