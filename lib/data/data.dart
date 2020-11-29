// Dummy Data later from firebase
import 'dart:html';

import '../models/models.dart';

final List<ProductType> productsType = [
  ProductType(type: 'Product 1'),
  ProductType(type: 'Product 2'),
  ProductType(type: 'Product 3'),
  ProductType(type: 'Product 4'),
  ProductType(type: 'Product 5'),
];

final List<Product> product = [
  Product(
    name: 'Product Item 1',
    currentPrice: 2000,
    previousPrice: 1500,
    discount: 36,
    imageUrl: 'https://picsum.photos/200/300',
  ),
  Product(
    name: 'Product Item 2',
    currentPrice: 2000,
    previousPrice: 1500,
    discount: 36,
    imageUrl: 'https://picsum.photos/200/300',
  ),
  Product(
      name: 'Product Item 3',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 4',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 5',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 6',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 7',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 8',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 9',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 10',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
  Product(
      name: 'Product Item 11',
      currentPrice: 2000,
      previousPrice: 1500,
      imageUrl: 'https://picsum.photos/200/300',
      discount: 36),
];

final List<Order> order = [
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
        quantity: 2,
      ),
      OrderedProduct(
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
        quantity: 2,
      ),
      OrderedProduct(
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
        quantity: 2,
      ),
      OrderedProduct(
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
        quantity: 2,
      ),
      OrderedProduct(
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
        quantity: 2,
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        quantity: 10,
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        quantity: 20,
        productId: 'dssdbfdg',
        price: 456,
        orderPrice: 345,
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
];

final List<Address> address = [
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: true,
      name: 'Shan',
      pincode: '49235'),
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: false,
      name: 'Shan',
      pincode: '49235'),
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: false,
      name: 'Shan',
      pincode: '49235'),
];

final List<Cart> cart = [
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
];

final List<Rating> rating = [
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
];
