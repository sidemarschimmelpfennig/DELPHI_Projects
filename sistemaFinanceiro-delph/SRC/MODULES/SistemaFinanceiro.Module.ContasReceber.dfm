object ModuleContasReceber: TModuleContasReceber
  OldCreateOrder = False
  Height = 317
  Width = 488
  object SQLContasReceber: TFDQuery
    Active = True
    Connection = ModuleConexao.FBCONEXAO
    SQL.Strings = (
      'select * from contas_receber')
    Left = 24
    Top = 8
  end
  object CDSContasReceber: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from contas_receber'
    Params = <>
    ProviderName = 'DSPContasReceber'
    Left = 32
    Top = 136
    object CDSContasReceberID: TStringField
      FieldName = 'ID'
      Required = True
      FixedChar = True
      Size = 36
    end
    object CDSContasReceberNUMERO_DOCUMENTO: TStringField
      FieldName = 'NUMERO_DOCUMENTO'
      Required = True
    end
    object CDSContasReceberDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object CDSContasReceberPARCELA: TIntegerField
      FieldName = 'PARCELA'
      Required = True
    end
    object CDSContasReceberVALOR_PARCELA: TFMTBCDField
      FieldName = 'VALOR_PARCELA'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasReceberVALOR_VENDA: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasReceberVALOR_ABATIDO: TFMTBCDField
      FieldName = 'VALOR_ABATIDO'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasReceberDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
      Required = True
    end
    object CDSContasReceberDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object CDSContasReceberDATA_VENCIMENTO: TDateField
      FieldName = 'DATA_VENCIMENTO'
      Required = True
    end
    object CDSContasReceberDATA_RECEBIMENTO: TDateField
      FieldName = 'DATA_RECEBIMENTO'
    end
    object CDSContasReceberSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DSPContasReceber: TDataSetProvider
    DataSet = SQLContasReceber
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 32
    Top = 72
  end
end
