object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Monolito Financeiro'
  ClientHeight = 496
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object MainMenu1: TMainMenu
    Left = 24
    Top = 8
    object mnCadastro: TMenuItem
      Caption = 'Cadastros'
      object mnCadastroPadrao: TMenuItem
        Caption = 'Usuarios'
        OnClick = mnCadastroPadraoClick
      end
    end
    object mnRelatorio1: TMenuItem
      Caption = 'Relatorios'
    end
    object mnAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
end
