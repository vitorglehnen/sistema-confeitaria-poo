unit viewCadastrarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPickers, Vcl.Mask, Vcl.ComCtrls, Vcl.Imaging.pngimage, model.entitys.pedido;

type
  TfrmCadastrarPedido = class(TForm)
    panelPageCadastro: TPanel;
    panelImagemEmpresa: TPanel;
    Image1: TImage;
    panelDadosCliente: TPanel;
    lblDataHoraEntrega: TLabel;
    lblNomeCliente: TLabel;
    lblTelefoneCliente: TLabel;
    btConfirmar: TButton;
    dataEntrega: TDateTimePicker;
    editEnderecoCliente: TLabeledEdit;
    editNomeCliente: TEdit;
    editTelefoneCliente: TMaskEdit;
    horaEntrega: TTimePicker;
    rdbtClienteRetira: TRadioGroup;
    procedure btConfirmarClick(Sender: TObject);
    procedure cadastraPedido;
    procedure editTelefoneClienteEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbtClienteRetiraClick(Sender: TObject);
  private
  public
  end;

implementation

uses
  System.SysUtils, dao.pedido, viewInserirProdutos, dao.tiposDeProduto;


{$R *.dfm}


procedure TfrmCadastrarPedido.btConfirmarClick(Sender: TObject);
begin
  cadastraPedido;
end;

procedure TfrmCadastrarPedido.cadastraPedido;
var
  lPedido : TPedido;
  lDAOPedido : TDAOPedido;
  lFrmInserirProdutos : TfrmInserirProdutos;
begin
  lPedido := TPedido.create;
  lDAOPedido := TDAOPedido.Create;
  lFrmInserirProdutos := TfrmInserirProdutos.Create(nil);
  try
    lPedido.SetNome(editNomeCliente.Text);
    lPedido.DataEntrega := dataEntrega.Date;
    lPedido.HoraEntrega := horaEntrega.Time;
    lPedido.SetTelefone(editTelefoneCliente.Text);
    lPedido.Endereco := editEnderecoCliente.text;
    lDAOPedido.InserirPedido(lPedido);
    lFrmInserirProdutos.ShowModal();
    close;
  finally
    lPedido.Free;
    lDAOPedido.Free;
    lFrmInserirProdutos.Free;
  end;
end;

procedure TfrmCadastrarPedido.editTelefoneClienteEnter(Sender: TObject);
begin
  editTelefoneCliente.EditMask := '(99) 99999-9999;0;';
end;

procedure TfrmCadastrarPedido.FormCreate(Sender: TObject);
begin
  dataEntrega.date := Now;
  horaEntrega.Time := 0000;
end;

procedure TfrmCadastrarPedido.rdbtClienteRetiraClick(Sender: TObject);
begin
  case rdbtClienteRetira.ItemIndex of
    0: editEnderecoCliente.Enabled := False;
    1: editEnderecoCliente.Enabled := True;
  end;

end;

end.
