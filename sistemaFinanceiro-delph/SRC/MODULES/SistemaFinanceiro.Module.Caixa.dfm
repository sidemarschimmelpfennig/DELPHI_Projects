object ModuleCaixa: TModuleCaixa
  OldCreateOrder = False
  Height = 409
  Width = 688
  object CDSCaixa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPCaixa'
    Left = 32
    Top = 160
    object CDSCaixaID: TStringField
      FieldName = 'ID'
      Size = 36
    end
    object CDSCaixaNUMERO_DOC: TStringField
      FieldName = 'NUMERO_DOC'
    end
    object CDSCaixaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object CDSCaixaVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Size = 18
    end
    object CDSCaixaDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
    end
    object CDSCaixaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object DSPCaixa: TDataSetProvider
    DataSet = SQLCaixa
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 32
    Top = 80
  end
  object SQLCaixa: TFDQuery
    Connection = ModuleConexao.FBCONEXAO
    Left = 32
    Top = 16
  end
end
