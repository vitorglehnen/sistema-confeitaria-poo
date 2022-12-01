unit conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function DataSet: TDataSet;
    procedure SQL(Value: String);
    procedure Params(aParam: String; aValue: Variant); overload;
    function Params(aParam: String): Variant; overload;
    procedure ExecSql;
    procedure Open;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    procedure FetchAll;
    procedure First;
    procedure Next;
    procedure Last;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmConexao.Commit;
begin
  FDConnection1.Commit;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected;
end;

function TdmConexao.DataSet: TDataSet;
begin
  Result := FDQuery1;
end;

procedure TdmConexao.ExecSql;
begin
  FDQuery1.ExecSQL;
end;

procedure TdmConexao.FetchAll;
begin
  FDQuery1.FetchAll;
end;

procedure TdmConexao.First;
begin
  FDQuery1.First;
end;

procedure TdmConexao.Last;
begin
  FDQuery1.Last;
end;

procedure TdmConexao.Next;
begin
  FDQuery1.Next;
end;

procedure TdmConexao.Open;
begin
  FDQuery1.open;
end;

function TdmConexao.Params(aParam: String): Variant;
begin
  Result := FDQuery1.ParamByName(aParam).Value;
end;

procedure TdmConexao.Params(aParam: String; aValue: Variant);
begin
  FDQuery1.ParamByName(aParam).Value := aValue;
end;

procedure TdmConexao.Rollback;
begin
  FDConnection1.Rollback;
end;

procedure TdmConexao.SQL(Value: String);
begin
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add(Value);
end;

procedure TdmConexao.StartTransaction;
begin
  FDConnection1.StartTransaction;
end;

end.
