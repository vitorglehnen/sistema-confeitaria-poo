unit dao.pedido;

interface

uses
  model.entitys.pedido, conexao, System.SysUtils, Data.DB, Vcl.DBGrids,
  Vcl.ComCtrls;

type
  TDAOPedido = class
  private
    FConn: TDMConexao;
    NomeCliente: String;
    IdCliente: String;
    FPrecoProduto: currency;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserirPedido(Value: TPedido);
    procedure InserirProdutos(Value: TPedido);
    procedure Apagar(Value: TPedido);
    procedure BuscaCliente;
    function CalculaPrecoProdutos(Value: TPedido): currency;
    procedure InsereListView(ListView: TListView; pedido: TPedido);
    procedure ApagarUltimoPedido;
  end;

implementation

uses
  Vcl.Dialogs;

{ TDAOUsuario }

procedure TDAOPedido.Apagar(Value: TPedido);
begin
  abort;
end;

procedure TDAOPedido.ApagarUltimoPedido;
begin
  FConn.StartTransaction;
  try
    BuscaCliente;
    FConn.SQL('DELETE FROM pedidos WHERE nome = :NomeCliente');
    FConn.Params('NomeCliente', NomeCliente);
    FConn.ExecSql;
    FConn.Commit
  except

  end;
end;

procedure TDAOPedido.BuscaCliente;
begin
  FConn.StartTransaction;
  try
    FConn.SQL('SELECT * FROM pedidos');
    FConn.Open;
    FConn.Last;
    FConn.Commit;
    IdCliente := FConn.FDQuery1['id'];
    NomeCliente := FConn.FDQuery1['nome'];
  except
    FConn.Rollback;
    raise Exception.Create('Cliente não encontrado');
  end;
end;

function TDAOPedido.CalculaPrecoProdutos(Value: TPedido): currency;
var
  tabela : String;
begin
  if Value.TipoProduto = 'Torta doce' then
    tabela := 'precos_tortas_doces';
    if Value.TipoProduto = 'Torta salgada' then
      tabela := 'precos_tortas_salgadas';
      if Value.TipoProduto = 'Sobremesa' then
        tabela := 'precos_sobremesa';

  FConn.StartTransaction;
  try
    FConn.SQL('SELECT preco FROM ' + tabela + ' WHERE tamanho = :TamanhoProduto');
    FConn.Params('TamanhoProduto', Value.TamanhoProduto);
    FConn.Open;
    FConn.Commit;
    FPrecoProduto := FConn.FDQuery1['preco'];
    Result := FPrecoProduto;
  except
    FConn.Rollback;
    raise Exception.Create('Valor do produto não encontrado');
  end;
end;

constructor TDAOPedido.Create;
begin
  FConn := TDMConexao.Create(nil);
end;

destructor TDAOPedido.Destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TDAOPedido.InsereListView(ListView: TListView; pedido: TPedido);
var itens : TListItem;
begin
  itens := ListView.Items.Add;
  BuscaCliente;

  itens.Caption := NomeCliente;
  itens.SubItems.Add('(' + pedido.TipoProduto + ') ' + pedido.NomeProduto);
  itens.SubItems.Add(pedido.TamanhoProduto);
  itens.SubItems.Add('R$ ' + CurrToStr(CalculaPrecoProdutos(pedido)) + ',00');
  itens.SubItems.Add(pedido.Observacoes);
end;

procedure TDAOPedido.InserirPedido(Value: TPedido);
begin
  FConn.StartTransaction;
  try
    FConn.SQL('INSERT INTO pedidos (nome, data_entrega, hora_entrega, telefone,'
    + ' endereco) VALUES (:nome, :data_entrega, :hora_entrega, :telefone, :endereco)');
    FConn.Params('nome', Value.Nome);
    FConn.Params('data_entrega', FormatDateTime('YYYY/MM/DD', Value.DataEntrega));
    FConn.Params('hora_entrega', TimeToStr(Value.HoraEntrega));
    FConn.Params('telefone', Value.Telefone);
    FConn.Params('endereco', Value.Endereco);
    FConn.ExecSQL;
    FConn.Commit;
  except
    FConn.Rollback;
    raise Exception.Create('Erro ao inserir o pedido!');
  end;
end;

procedure TDAOPedido.InserirProdutos(Value: TPedido);
begin
  FConn.StartTransaction;
  try
    CalculaPrecoProdutos(Value);
    BuscaCliente;
    FConn.SQL('INSERT INTO cadastro_produtos (id_cliente, nome_cliente, nome, tamanho, valor, observacoes) VALUES (:IdCliente, :NomeCliente, :NomeProduto, :Tamanho, :Valor, :Observacoes)');
    FConn.Params('IdCliente', IdCliente);
    FConn.Params('NomeCliente', NomeCliente);
    FConn.Params('NomeProduto', '(' + Value.TipoProduto + ') ' + Value.NomeProduto);
    FConn.Params('Tamanho', Value.TamanhoProduto);
    FConn.Params('Valor', FPrecoProduto);
    FConn.Params('Observacoes', Value.Observacoes);
    FConn.ExecSql;
    FConn.Commit;
  except
    FConn.Rollback;
    raise Exception.Create('Erro ao inserir o produto');
  end;
end;

end.
