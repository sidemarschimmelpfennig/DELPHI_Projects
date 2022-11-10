﻿unit SistemaFinanceiro.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmSplash = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    lblStatus: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Image1: TImage;
    imgDll: TImage;
    imgDb: TImage;
    imgConfig: TImage;
    imgInicializar: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
	 { Private declarations }
	 procedure AtualizaImagemStatus(Mensagem: String; Imagem: TImage);
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

{ TfrmSplash }

procedure TfrmSplash.AtualizaImagemStatus(Mensagem: String; Imagem: TImage);
begin
 lblStatus.Caption:= Mensagem;
 Imagem.Visible:= True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
    if ProgressBar1.Position <= 100 then
	  begin
		ProgressBar1.StepIt;
		case ProgressBar1.Position of
			10: AtualizaImagemStatus('Carregando Dependencias ... ', imgDll);
			25: AtualizaImagemStatus('Conectando ao Banco de Dados ... ', imgDB);
			45: AtualizaImagemStatus('Carregando as Configurações ... ', imgConfig);
			75: AtualizaImagemStatus('Iniciando o sistema ... ', imgInicializar);
		end;
		end;
	if  ProgressBar1.Position = 100 then 
	close;
end;

end.
