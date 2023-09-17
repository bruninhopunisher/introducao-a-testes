double calcularDesconto(double valor, double desconto, bool percentual) {

  if (valor <= 0) {
    throw ArgumentError("Valor do produto não pode ser zero. Tente novamente.");
  }

  if (desconto <= 0) {
    throw ArgumentError("Valor do produto não pode ser zero. Tente novamente.");
  }

  if (percentual) {
    return valor - ((valor * desconto) / 100);
  } return valor - desconto;
}

String convertToUpper(String texto) {
  return texto.toUpperCase();
}

int retornaInt (int numero) {
  return numero;
}

