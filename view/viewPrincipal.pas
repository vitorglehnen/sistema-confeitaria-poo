unit viewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, viewCadastrarPedido;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btCadastrarNovoPedido: TButton;
    btPedidos: TButton;
    btEditarCardapio: TButton;
    Panel3: TPanel;
    Image1: TImage;
    procedure btCadastrarNovoPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal : TFrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btCadastrarNovoPedidoClick(Sender: TObject);
var
  lCadastrarPedido : TfrmCadastrarPedido;
begin
  lCadastrarPedido := TfrmCadastrarPedido.create(nil);
  try
    lCadastrarPedido.ShowModal();
  finally
    lCadastrarPedido.free;
  end;
end;

end.
