
class DonoDataModel{

  static const String TABELA = "tabelaDono";
  static const String id = "id";
  static const String nome = "nome";
  static const String cpf = "cpf";
  static const String user = "user";
  static const String password = "password";

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY,
              $nome TEXT, $cpf TEXT,
              $user TEXT, $password TEXT);''';
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
    return '''$TABELA.id, $TABELA.nome, $TABELA.data_final, $TABELA.gasto_total, $TABELA.saldo, $TABELA.cidade_id, $TABELA.funcionario_id''';
  }
}

