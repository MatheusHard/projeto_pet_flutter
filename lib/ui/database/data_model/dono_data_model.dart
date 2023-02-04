
class DonoDataModel{

  static const String TABELA = "tabelaDono";
  static const String id = "id";
  static const String nome = "nome";
  static const String cpf = "cpf";
  static const String user = "user";
  static const String password = "password";
  static const String qtdRowListagem = "qtdRowListagem";
  static const String codigoRecuperacao = 'codigoRecuperacao';

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY,
              $nome TEXT, $cpf TEXT, $qtdRowListagem INTEGER,
              $user TEXT, $password TEXT, $codigoRecuperacao TEXT);''';
  }

  static String dropTable(){
    return   "DROP TABLE IF EXISTS $TABELA;";
  }

  static String zerarTabela() {

    return "DELETE FROM $TABELA;";
  }

  static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
    return '''$TABELA.id, $TABELA.nome, $TABELA.user, $TABELA.password, $TABELA.qtdRowListagem, $TABELA.cpf, $TABELA.codigoRecuperacao''';
  }
}

