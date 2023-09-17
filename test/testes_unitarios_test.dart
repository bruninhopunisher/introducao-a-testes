import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testes_unitarios/classes/viacep.dart';
import 'package:testes_unitarios/testes_unitarios.dart' as app;
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

import 'testes_unitarios_test.mocks.dart';

@GenerateMocks([MockViaCEP])

void main() {

  // Testes de um em um

  test('calcula o valor do produto com desconto sem porcentagem', () {
    expect(app.calcularDesconto(1000, 150, false), equals(850));
  });

  test('calcula o valor do produto com desconto sem porcentagem com valor do produto zerado', () {
    expect(() => app.calcularDesconto(0, 150, false), throwsA(TypeMatcher<ArgumentError>()));
  });

  test('calcula o valor do produto com desconto zerado', () {
    expect(() => app.calcularDesconto(1000, 0, false), throwsA(TypeMatcher<ArgumentError>()));
  });

  test('calcula o valor do produto com desconto com porcentagem', () {
    expect(app.calcularDesconto(1000, 15, true), 850);
  });

  // Testes usando agrupamento

  group('Calcula o valor do produto com desconto', () {
    var valuesToTest = {
      {'valor': 1000, 'desconto': 150, 'percentual': false} : 850,
      {'valor': 1000, 'desconto': 15, 'percentual': true} : 850,
    };
    valuesToTest.forEach((values, expected) {
      test('Entrada $values: $expected', () {
        expect(app.calcularDesconto(
            double.parse(values['valor'].toString()),
            double.parse(values['desconto'].toString()),
            values["percentual"] == true),
            equals(expected));
      });
    });
  });

  group('Calcula o valor do produto informando valores zerados, deve gerar erro', () {
    var valuesToTest = {
      {'valor': 0, 'desconto': 150, 'percentual': false},
      {'valor': 1000, 'desconto': 0, 'percentual': true} ,
    };
    for (var values in valuesToTest) {
      test('Entrada $values', () {
        expect(() => app.calcularDesconto(
            double.parse(values['valor'].toString()),
            double.parse(values['desconto'].toString()),
            values["percentual"] == true),
            throwsA(TypeMatcher<ArgumentError>()));
      });
    }
  });

  // Testes

  test('Testar conversão para uppercase', () {
    expect(app.convertToUpper('bruno'), equals('BRUNO'));
  });

  // 'equalsIgnoringCase' verifica a correção ortografia e não se esta minúscula ou maiúscula
  test('Testar conversão para uppercase teste 2', () {
    expect(app.convertToUpper('bruno'), equalsIgnoringCase('bruno'));
  });

  test('Testar conversão para uppercase teste 2', () {
    expect(app.convertToUpper('bruno'), equalsIgnoringCase('bruno'));
  });

  test('Verifica se o número é int', () {
    expect(app.retornaInt(15), isA<int>());
  });

  test('Verifica se o número é int', () {
    expect(app.retornaInt(15), isNot(isA<double>()));
  });

  // Teste para validação do CEP utilizando HTTPS e Mock

  test('Retornar CEP', () async {

    MockViaCEP mockViaCEP = MockMockViaCEP();
    when(mockViaCEP.retornarCEP('01001000')).thenAnswer((realInvocation) => Future.value({
          "cep": "01001000",
          "logradouro": "Praça da Sé",
          "complemento": "lado ímpar",
          "bairro": "Sé",
          "localidade": "São Paulo",
          "uf": "SP",
          "ibge": "3550308",
          "gia": "1004",
          "ddd": "11",
          "siafi": "7107"
    }));

    var body = await mockViaCEP.retornarCEP('01001000');
    expect(body['bairro'], equals('Sé'));
    expect(body['logradouro'], equals('Praça da Sé'));
  });
}

class MockViaCEP extends Mock implements ViaCEP {}

