unit SistemaFinanceiro.View.RedefinirSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,Utilitarios.usuarios, SistemaFinanceiro.Module.Usuarios;

type
  TfrmRedefinirSenha = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    edtConfirmaSenha: TEdit;
    btnConfirmar: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel7: TPanel;
	 Button2: TButton;
	 Image1: TImage;
	 procedure Button2Click(Sender: TObject);
	 procedure btnConfirmarClick(Sender: TObject);
	 //procedure FormShow(Sender: TObject);
  
  private
	 FUsuario: EntidadeUsuarios;
	 procedure SetUsuario(const Value: EntidadeUsuarios);
	 { Private declarations }
  public
	 { Public declarations }
	 property Usuario: EntidadeUsuarios read FUsuario write SetUsuario;
  end;

var
  frmRedefinirSenha: TfrmRedefinirSenha;

implementation

{$R *.dfm}

procedure TfrmRedefinirSenha.btnConfirmarClick(Sender: TObject);
begin
	  edtSenha.Text := Trim(edtSenha.Text);
	  edtConfirmaSenha.Text:= Trim(edtConfirmaSenha.Text);
	  if edtSenha.Text = '' then
		begin 
			edtSenha.SetFocus;
			Application.MessageBox('Informe sua nova senha ', 'Atenção' ,MB_OK);
			abort;
		end;
		 if (edtSenha.Text <> edtConfirmaSenha.Text) or (edtConfirmaSenha.Text = '') then
		begin 
			edtConfirmaSenha.SetFocus;
			Application.MessageBox('Senhas Informadas não são iguais!!','Atenção' ,MB_OK);
			abort;
		end;
	
		Usuario.senha := edtSenha.Text;
		ModuleUsuarios.RedefinirSenha(Usuario);
		Application.MessageBox('Senha Redefinida com Sucesso!!','Atenção' ,MB_OK);
		ModalResult:=  mrOk;
end;

procedure TfrmRedefinirSenha.Button2Click(Sender: TObject);
begin
close;
end;

{procedure TfrmRedefinirSenha.FormShow(Sender: TObject);
begin
	Label2.Caption := 'DIGIDITE A SENHA USUARIO : ' + FUsuario.Nome;
end;}

procedure TfrmRedefinirSenha.SetUsuario(const Value: EntidadeUsuarios);
begin
  FUsuario := Value;
end;


end.
