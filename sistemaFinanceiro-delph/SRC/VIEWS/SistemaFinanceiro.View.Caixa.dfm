inherited frmCaixa: TfrmCaixa
  Caption = 'Caixa'
  ClientHeight = 406
  ClientWidth = 717
  OnCreate = FormCreate
  ExplicitWidth = 733
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 13
  inherited CardPrincipal: TCardPanel
    Width = 717
    Height = 406
    ExplicitWidth = 717
    ExplicitHeight = 406
    inherited CdCadastar: TCard
      Width = 715
      Height = 404
      ExplicitWidth = 715
      ExplicitHeight = 404
      object Label6: TLabel [0]
        Left = 32
        Top = 24
        Width = 128
        Height = 19
        Caption = 'N'#186' do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel [1]
        Left = 32
        Top = 63
        Width = 67
        Height = 19
        Caption = 'Descricao'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel [2]
        Left = 32
        Top = 172
        Width = 37
        Height = 19
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      inherited Panel1: TPanel
        Top = 326
        Width = 715
        ExplicitTop = 326
        ExplicitWidth = 715
        inherited btnCancelar: TButton
          Left = 625
          ExplicitLeft = 625
        end
        inherited btnSalve: TButton
          Left = 536
          ExplicitLeft = 536
        end
      end
      object edtDocumento: TEdit
        Left = 180
        Top = 26
        Width = 413
        Height = 21
        NumbersOnly = True
        TabOrder = 1
      end
      object edtValor: TEdit
        Left = 180
        Top = 170
        Width = 413
        Height = 21
        TabOrder = 2
      end
      object edtDescricao: TEdit
        Left = 180
        Top = 65
        Width = 413
        Height = 21
        TabOrder = 3
      end
      object RadioGroup1: TRadioGroup
        Left = 180
        Top = 208
        Width = 413
        Height = 49
        Caption = 'Situa'#231#227'o/tipo'
        Columns = 2
        Items.Strings = (
          'RECEITA'
          'DESPESA')
        TabOrder = 4
      end
    end
    inherited CdPesquisar: TCard
      Width = 715
      Height = 404
      ExplicitWidth = 715
      ExplicitHeight = 404
      inherited pnlTopCDP: TPanel
        Width = 715
        ExplicitWidth = 715
        object Label2: TLabel [1]
          Left = 290
          Top = 11
          Width = 67
          Height = 19
          Caption = 'Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        inherited btnPesquisar: TButton
          Left = 625
          ExplicitLeft = 625
        end
      end
      inherited pnlBottom: TPanel
        Top = 326
        Width = 715
        ExplicitTop = 326
        ExplicitWidth = 715
        inherited btnFechar: TButton
          Left = 625
          ExplicitLeft = 625
        end
      end
      inherited DBGrid1: TDBGrid
        Width = 715
        Height = 251
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA_CADASTRO'
            Title.Caption = 'DATA DE CAD'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO_DOC'
            Title.Caption = 'N'#176' DOCUMENTO'
            Width = 152
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'DESCRI'#199#195'O'
            Width = 302
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPO'
            Width = 31
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Width = 83
            Visible = True
          end>
      end
      object ComboBox1: TComboBox
        Left = 260
        Top = 36
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'TODOS'
        Items.Strings = (
          'TODOS'
          'RECEITAS'
          'DESPESAS'
          'DESCRI'#199#195'O')
      end
    end
  end
  inherited ImageList1: TImageList
    Left = 632
    Top = 96
  end
  inherited DataSource1: TDataSource
    DataSet = ModuleCaixa.CDSCaixa
    Left = 632
    Top = 168
  end
end
