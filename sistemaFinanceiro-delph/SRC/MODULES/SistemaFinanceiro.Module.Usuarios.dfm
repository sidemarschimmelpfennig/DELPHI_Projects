object ModuleUsuarios: TModuleUsuarios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 404
  Width = 522
  object SQLUsuario: TFDQuery
    Connection = ModuleConexao.FBCONEXAO
    Left = 32
    Top = 24
  end
  object CDSUsuarios: TClientDataSet
    Aggregates = <>
    Filtered = True
    Params = <>
    ProviderName = 'DSPUsuarios'
    Left = 32
    Top = 136
    object CDSUsuariosid: TStringField
      FieldName = 'id'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 36
    end
    object CDSUsuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'NOME'
      Size = 50
    end
    object CDSUsuarioslogin: TStringField
      FieldName = 'login'
      Origin = 'LOGIN'
    end
    object CDSUsuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'SENHA'
      Size = 60
    end
    object CDSUsuariosstatus: TStringField
      FieldName = 'status'
      Origin = 'STATUS'
      Size = 1
    end
    object CDSUsuariosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
      Origin = 'DATA_CADASTRO'
    end
    object CDSUsuariossenha_temporaria: TStringField
      FieldName = 'senha_temporaria'
      Size = 1
    end
  end
  object DSPUsuarios: TDataSetProvider
    DataSet = SQLUsuario
    Constraints = False
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 32
    Top = 80
  end
end
