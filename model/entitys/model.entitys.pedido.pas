unit model.entitys.pedido;

interface

uses
System.SysUtils, Vcl.Dialogs;

type
  TPedido = class
    private
      FNome: string;
      FDataEntrega: TDate;
      FHoraEntrega: TTime;
      FTelefone: String;
      FEndereco: String;
      FTipoProduto: String;
      FNomeProduto: String;
      FTamanhoProduto: String;
      FObservacoes: String;
    public
      procedure SetNome(Value: String);
      procedure SetTelefone(Value: String);
      procedure SetTipoProduto(Value: String);
      procedure SetNomeProduto(Value: String);
      procedure SetTamanhoProduto(Value: String);

      property Nome: String read FNome;
      property DataEntrega: TDate read FDataEntrega write FDataEntrega;
      property HoraEntrega: TTime read FHoraEntrega write FHoraEntrega;
      property Telefone: String read FTelefone;
      property Endereco: String read FEndereco write FEndereco;
      property TipoProduto: String read FTipoProduto;
      property NomeProduto: String read FNomeProduto;
      property TamanhoProduto: String read FTamanhoProduto;
      property Observacoes: String read FObservacoes write FObservacoes;
  end;

implementation


procedure TPedido.SetNome(Value: String);
begin
  if (Value.IsEmpty) or (Value.Length < 3) then
  begin
    ShowMessage('Nome inválido, deve conter pelo menos 3 caracteres');
    abort;
  end;
  FNome := Value;
end;

procedure TPedido.SetNomeProduto(Value: String);
begin
  if (Value.IsEmpty) then
  begin
    ShowMessage('Selecione o produto!');
    abort;
  end;
  FNomeProduto := Value;
end;

procedure TPedido.SetTamanhoProduto(Value: String);
begin
  if (Value.IsEmpty) then
    begin
      ShowMessage('Selecione o tamanho do produto!');
      abort;
    end;
    FTamanhoProduto := Value;
end;

procedure TPedido.SetTelefone(Value: String);
begin
  if not Value.IsEmpty then
    if Value.Length < 11 then
      begin
        ShowMessage('Número de telefone inválido!');
        abort;
      end;
  FTelefone := Value;
end;

procedure TPedido.SetTipoProduto(Value: String);
begin
  if (Value.IsEmpty) then
    begin
      ShowMessage('Selecione o tipo do produto!');
      abort;
    end;
    FTipoProduto := Value;
end;

end.
