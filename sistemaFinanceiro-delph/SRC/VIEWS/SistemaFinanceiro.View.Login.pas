unit SistemaFinanceiro.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, SistemaFinanceiro.Module.Usuarios,
  SistemaFinanceiro.Module.UltimoLogin;

type
  TfrmLogin = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    Button1: TButton;
    Image1: TImage;
    Panel1: TPanel;
    Button2: TButton;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    Label5: TLabel;
	 Label6: TLabel;
	 procedure Button2Click(Sender: TObject);
	 procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
begin
 if Trim(edtLogin.Text) = ''  then
  begin
  edtLogin.setFocus;
  Application.MessageBox('O campo de Login esta Vazio ','aten��o' , MB_ICONWARNING + MB_OK);
  abort;
  end;
  if Trim(edtSenha.Text) = ''  then
  begin
  edtSenha.setFocus;
  Application.MessageBox('O campo de Senha esta Vazio ','aten��o' , MB_ICONWARNING + MB_OK);
  abort;
  end; 
  try
  ModuleUsuarios.EfetuarLogin(Trim(edtLogin.Text), Trim(edtSenha.Text));
  ModuleLogin.DataUltimoAcesso(now);
  ModuleLogin.UsuarioUltimoAcesso(ModuleUsuarios.GetUsuarioLogado.Login);
  ModalREsult := mrOk;
  
  except
	  on Erro : Exception do
	  begin
		  Application.MessageBox(PWideChar(Erro.Message),'aten��o' , MB_ICONWARNING + MB_OK);
		  edtLogin.SetFocus;
	  end;
  end;
end;


procedure TfrmLogin.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
edtLogin.Text:= ModuleLogin.UsuarioUltimoAcesso
end;

end.
