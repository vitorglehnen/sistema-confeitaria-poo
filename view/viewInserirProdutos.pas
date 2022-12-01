unit viewInserirProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.ComCtrls;

type
  TfrmInserirProdutos = class(TForm)
    panelPageProdutos: TPanel;
    panelTiposDeProduto: TPanel;
    lblNomeDoProduto: TLabel;
    lblTamanhoDoProduto: TLabel;
    lblTipoDoProduto: TLabel;
    comboNomeDoProduto: TComboBox;
    comboTamanhoDoProduto: TComboBox;
    comboTiposDeProduto: TComboBox;
    editObservacoes: TEdit;
    btAdicionarProduto: TButton;
    panelGridProdutos: TPanel;
    btCancelarPedido: TButton;
    btFinalizarPedido: TButton;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure comboTiposDeProdutoClick(Sender: TObject);
    procedure btAdicionarProdutoClick(Sender: TObject);
    procedure InsereProdutos;
    procedure btFinalizarPedidoClick(Sender: TObject);
    procedure btCancelarPedidoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  dao.tiposDeProduto, model.entitys.pedido, dao.pedido, viewCadastrarPedido, conexao;

{$R *.dfm}

procedure TfrmInserirProdutos.btAdicionarProdutoClick(Sender: TObject);
begin
  InsereProdutos;
  comboTiposDeProduto.ItemIndex := -1;
  comboNomeDoProduto.Clear;
  comboTamanhoDoProduto.Clear;
  editObservacoes.Clear;
end;

procedure TfrmInserirProdutos.btCancelarPedidoClick(Sender: TObject);
var lDAOPedido : TDAOPedido;
begin
  lDAOPedido := TDAOPedido.Create;
  try
   if Application.MessageBox('Deseja cancelar seu pedido?', 'Cancelar pedido',
    + MB_ICONQUESTION + MB_YESNO) = MrYes then
    lDAOPedido.ApagarUltimoPedido;
    close;   
  finally
    lDAOPedido.Free;
  end;
  
end;

procedure TfrmInserirProdutos.btFinalizarPedidoClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja concluir seu pedido?', 'Concluir pedido',
    + MB_ICONQUESTION + MB_YESNO) = MrYes then
    close;
end;

procedure TfrmInserirProdutos.comboTiposDeProdutoClick(Sender: TObject);
var
  lDAOTiposDeProduto : TDAOTiposDeProduto;
begin
  lDAOTiposDeProduto := TDAOTiposDeProduto.Create;
  try
    lDAOTiposDeProduto.BuscaNomeDosProdutos(comboTiposDeProduto, comboNomeDoProduto);
    lDAOTiposDeProduto.BuscaTamanhoDosProdutos(comboTiposDeProduto, comboTamanhoDoProduto);
  finally
    lDAOTiposDeProduto.Free;
  end;
end;

procedure TfrmInserirProdutos.FormCreate(Sender: TObject);
var
  lDAOTiposDeProduto : TDAOTiposDeProduto;
begin
  lDAOTiposDeProduto := TDAOTiposDeProduto.Create;
  try
    lDAOTiposDeProduto.BuscaTiposDeProdutos(comboTiposDeProduto);
  finally
    lDAOTiposDeProduto.Free;
  end;
end;

procedure TfrmInserirProdutos.InsereProdutos;
var
  lPedido : TPedido;
  lDAOPedido : TDAOPedido;
begin
  lPedido := TPedido.Create;
  lDAOPedido := TDAOPedido.Create;
  try
    lPedido.SetNomeProduto(comboNomeDoProduto.Text);
    lPedido.SetTipoProduto(comboTiposDeProduto.Text);
    lPedido.SetTamanhoProduto(comboTamanhoDoProduto.Text);
    lPedido.Observacoes := editObservacoes.Text;
    lDAOPedido.InserirProdutos(lPedido);
    lDAOPedido.InsereListView(ListView1, lPedido);
  finally
    lPedido.Free;
    lDAOPedido.Free;
  end;
end;

end.
