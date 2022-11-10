object ModuleContasPagar: TModuleContasPagar
  OldCreateOrder = False
  Height = 387
  Width = 545
  object SQLContasPagar: TFDQuery
    Connection = ModuleConexao.FBCONEXAO
    SQL.Strings = (
      'select * from contas_pagar')
    Left = 32
    Top = 16
  end
  object CDSContasPagar: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from contas_pagar'
    Params = <>
    ProviderName = 'DSPContasPagar'
    Left = 32
    Top = 136
    object CDSContasPagarID: TStringField
      FieldName = 'ID'
      Required = True
      FixedChar = True
      Size = 36
    end
    object CDSContasPagarNUMERO_DOCUMENTO: TStringField
      FieldName = 'NUMERO_DOCUMENTO'
      Required = True
    end
    object CDSContasPagarDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object CDSContasPagarPARCELA: TIntegerField
      FieldName = 'PARCELA'
      Required = True
    end
    object CDSContasPagarVALOR_PARCELA: TFMTBCDField
      FieldName = 'VALOR_PARCELA'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasPagarVALOR_COMPRA: TFMTBCDField
      FieldName = 'VALOR_COMPRA'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasPagarVALOR_ABATIDO: TFMTBCDField
      FieldName = 'VALOR_ABATIDO'
      Required = True
      Precision = 18
      Size = 2
    end
    object CDSContasPagarDATA_COMPRA: TDateField
      FieldName = 'DATA_COMPRA'
      Required = True
    end
    object CDSContasPagarDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object CDSContasPagarDATA_VENCIMENTO: TDateField
      FieldName = 'DATA_VENCIMENTO'
      Required = True
    end
    object CDSContasPagarDATA_PAGAMENTO: TDateField
      FieldName = 'DATA_PAGAMENTO'
    end
    object CDSContasPagarSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DSPContasPagar: TDataSetProvider
    DataSet = SQLContasPagar
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 32
    Top = 72
  end
end
