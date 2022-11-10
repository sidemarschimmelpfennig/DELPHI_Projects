object ViewMain: TViewMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'ViewMain'
  ClientHeight = 619
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object plTop: TPanel
    Left = 0
    Top = 0
    Width = 817
    Height = 73
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 240
    ExplicitTop = 192
    ExplicitWidth = 185
    object Button1: TButton
      Left = 696
      Top = 1
      Width = 120
      Height = 71
      Align = alRight
      Caption = 'FECHAR'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
