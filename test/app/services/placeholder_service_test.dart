import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:teste_openco_flutter_pleno/app/services/placeholder_service.dart';

class MockDio extends Mock implements Dio {}

class FakeUri extends Fake implements Uri {}

void main() {
  late Dio dio;
  late PlaceholderService service;
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });
  setUp(() {
    dio = MockDio();
    service = PlaceholderService(dio);
  });

  test('Listar Postagens', () async {
    var response = Response(
        data: jsonDecode(jsonPosts.replaceAll('\n', '')),
        statusCode: 200,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any())).thenAnswer((_) async => response);
    final posts = await service.getPosts();
    expect(posts.isNotEmpty, equals(true));
  });

  test('Erro ao Listar Postagens', () async {
    var response = Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any())).thenAnswer((_) async => response);
    try {
      await service.getPosts();
      fail('An exception should have been thrown.');
    } catch (error) {
      expect(error, isA<Exception>());
    }
  });

  test('Pesquisar Postagem por Id', () async {
    var response = Response(
        data: jsonDecode(jsonPostById.replaceAll('\n', '')),
        statusCode: 200,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => response);
    final posts = await service.getPostsById(id: '3');
    expect(posts.title!.isNotEmpty, equals(true));
  });

  test('Erro ao Pesquisar Postagem por Id', () async {
    var response = Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => response);
    try {
      await service.getPostsById(id: '101');
      fail('An exception should have been thrown.');
    } catch (error) {
      expect(error, isA<Exception>());
    }
  });

  test('Listar Comentários', () async {
    var response = Response(
        data: jsonDecode(jsonComments.replaceAll('\n', '')),
        statusCode: 200,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => response);
    final posts = await service.getCommentByPost(id: '5');
    expect(posts.isNotEmpty, equals(true));
  });

  test('Passar id inválido ao Listar Comentários', () async {
    var response = Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => response);
    final posts = await service.getCommentByPost(id: '0');
    expect(posts.isEmpty, equals(true));
  });

  test('Erro no servidor ao Listar Comentários', () async {
    var response = Response(
        data: [],
        statusCode: 500,
        requestOptions: RequestOptions(method: 'GET'));
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => response);
    try {
      await service.getCommentByPost(id: '0');

      fail('An exception should have been thrown.');
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}

const jsonPosts = '''[
  {
    "userId": 1,
    "id": 1,
    "title":
        "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body":
        "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body":
        "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body":
        "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
  },
  {
    "userId": 1,
    "id": 4,
    "title": "eum et est occaecati",
    "body":
        "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"
  }
]''';

const jsonPostById = '''
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body":
        "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
  }
''';

const jsonComments = '''[
  {
    "postId": 5,
    "id": 21,
    "name": "aliquid rerum mollitia qui a consectetur eum sed",
    "email": "Noemie@marques.me",
    "body": "deleniti aut sed molestias explicabo\ncommodi odio ratione nesciunt\nvoluptate doloremque est\nnam autem error delectus"
  },
  {
    "postId": 5,
    "id": 22,
    "name": "porro repellendus aut tempore quis hic",
    "email": "Khalil@emile.co.uk",
    "body": "qui ipsa animi nostrum praesentium voluptatibus odit\nqui non impedit cum qui nostrum aliquid fuga explicabo\nvoluptatem fugit earum voluptas exercitationem temporibus dignissimos distinctio\nesse inventore reprehenderit quidem ut incidunt nihil necessitatibus rerum"
  }
]''';
