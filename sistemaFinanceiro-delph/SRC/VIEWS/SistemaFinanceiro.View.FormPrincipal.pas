unit SistemaFinanceiro.View.FormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, SistemaFinanceiro.View.Splash,
  SistemaFinanceiro.View.CadastroPadrao, SistemaFinanceiro.View.Usuarios,
  SistemaFinanceiro.View.Login, Vcl.ComCtrls, SistemaFinanceiro.Module.Usuarios,
  Vcl.ExtCtrls, SistemaFinanceiro.View.RedefinirSenha, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Ajuda1: TMenuItem;
    Sair1: TMenuItem;
    Usuarios1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Panel1: TPanel;
    MnuCaixa: TMenuItem;
    Sair2: TMenuItem;
    mnuResumoDeCaixa: TMenuItem;
    ContasaPagar1: TMenuItem;
    ContasaReceber1: TMenuItem;
   
    procedure Usuarios1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MnuCaixaClick(Sender: TObject);
    procedure mnuResumoDeCaixaClick(Sender: TObject);
    procedure ContasaPagar1Click(Sender: TObject);
    procedure ContasaReceber1Click(Sender: TObject);
  private
	 { Private declarations }
  public
	 { Public declarations }

  end;

var
  frmPrincipal: TfrmPrincipal;

  

  

implementation


{$R *.dfm}

uses SistemaFinanceiro.Module.Caixa, SistemaFinanceiro.View.Caixa,
  SistemaFinanceiro.View.Caixa.Saldo, SistemaFinanceiro.View.ContasPagar,
  SistemaFinanceiro.Module.ContasReceber, SistemaFinanceiro.View.ContasReceber;


procedure TfrmPrincipal.ContasaPagar1Click(Sender: TObject);
begin
   frmContasPagar.Show;            
end;

procedure TfrmPrincipal.ContasaReceber1Click(Sender: TObject);
begin
   frmContasReceber.show;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplash := TfrmSplash.Create(nil);
  try
	  frmSplash.ShowModal;
  finally
	  FreeAndNil(frmSplash);
  end;
	 frmLogin := TfrmLogin.Create(nil);
  try
	  frmLogin.ShowModal;
	  if frmLogin.ModalResult <> mrOk then
	  Application.Terminate;
	  
  finally
	  FreeAndNil(frmLogin);
  end;
  if ModuleUsuarios.GetUsuarioLogado.SenhaTemporaria then
  begin
	  frmRedefinirSenha := TfrmRedefinirSenha.Create(nil);
	  try
		  frmRedefinirSenha.Usuario:= ModuleUsuarios.GetUsuarioLogado;
			frmRedefinirSenha.ShowModal;
			if frmRedefinirSenha.ModalResult <> mrOK then
			 Application.Terminate;
			
	  finally
		  FreeAndNil(frmRedefinirSenha);
	  end;
  end;
  
  StatusBar1.Panels.Items[1].Text := 'Usuario: '  + ModuleUsuarios.GetUsuarioLogado.Nome
  
end;



procedure TfrmPrincipal.MnuCaixaClick(Sender: TObject);
begin
frmCaixa.Show

end;

procedure TfrmPrincipal.mnuResumoDeCaixaClick(Sender: TObject);
begin
   frmCaixaSaldo.Show;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
 StatusBar1.Panels.Items[0].Text := DateTimeToStr(now); 
end;

procedure TfrmPrincipal.Usuarios1Click(Sender: TObject);
var 
  frmUsuarios: SistemaFinanceiro.View.Usuarios.TfrmUsuarios;
begin
	frmUsuarios := SistemaFinanceiro.View.Usuarios.TfrmUsuarios.Create(nil);
	try
	  frmUsuarios.ShowModal;
	finally
	  FreeAndNil(frmUsuarios);
	end;

end;

end.
