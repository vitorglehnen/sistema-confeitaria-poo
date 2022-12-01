object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 379
  Width = 532
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=sistemaangela'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 144
    Top = 40
  end
end
