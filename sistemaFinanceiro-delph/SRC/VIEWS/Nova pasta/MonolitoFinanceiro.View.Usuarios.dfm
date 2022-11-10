inherited frmCadastroUsuarios: TfrmCadastroUsuarios
  Caption = 'Cadastro de Usuarios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CdPnel: TCardPanel
    ActiveCard = Card_Cadastro
    inherited Card_Cadastro: TCard
      Font.Name = 'zzz'
      ParentFont = False
      inherited Panel1: TPanel
        object Label1: TLabel [0]
          Left = 40
          Top = 43
          Width = 42
          Height = 19
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel [1]
          Left = 40
          Top = 89
          Width = 39
          Height = 19
          Caption = 'Login'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel [2]
          Left = 40
          Top = 130
          Width = 43
          Height = 19
          Caption = 'Senha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel [3]
          Left = 40
          Top = 217
          Width = 43
          Height = 19
          Caption = 'Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel [4]
          Left = 40
          Top = 170
          Width = 98
          Height = 19
          Caption = 'Repetir Senha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtNome: TEdit
          Left = 152
          Top = 45
          Width = 313
          Height = 22
          TabOrder = 1
          OnChange = edtNomeChange
        end
        object edtLogin: TEdit
          Left = 152
          Top = 91
          Width = 313
          Height = 22
          TabOrder = 2
        end
        object edtSenha: TEdit
          Left = 152
          Top = 132
          Width = 313
          Height = 22
          PasswordChar = '*'
          TabOrder = 3
        end
        object ToggleSwitch1: TToggleSwitch
          Left = 152
          Top = 217
          Width = 110
          Height = 20
          DisabledColor = clMenuBar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          StateCaptions.CaptionOn = 'Ativo'
          StateCaptions.CaptionOff = 'Desativado'
          TabOrder = 4
          ThumbColor = clMenuHighlight
        end
        object edtRepeteSenha: TEdit
          Left = 152
          Top = 172
          Width = 313
          Height = 22
          PasswordChar = '*'
          TabOrder = 5
        end
      end
    end
    inherited Card_Pesquisa: TCard
      inherited pnlPrincipal: TPanel
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = DataModule1.cdsUsuario
    Left = 401
    Top = 250
  end
end
