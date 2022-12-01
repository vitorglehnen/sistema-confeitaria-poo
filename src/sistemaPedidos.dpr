program sistemaPedidos;

uses
  Vcl.Forms,
  viewPrincipal in '..\view\viewPrincipal.pas' {frmPrincipal},
  viewCadastrarPedido in '..\view\viewCadastrarPedido.pas' {frmCadastrarPedido},
  conexao in 'conexao\conexao.pas' {dmConexao: TDataModule},
  dao.pedido in 'DAO\dao.pedido.pas',
  viewInserirProdutos in '..\view\viewInserirProdutos.pas' {frmInserirProdutos},
  model.entitys.pedido in '..\model\entitys\model.entitys.pedido.pas',
  dao.tiposDeProduto in 'DAO\dao.tiposDeProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
