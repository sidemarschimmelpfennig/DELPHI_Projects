unit SistemaFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SistemaFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls, Utilitarios, Vcl.Menus,
  SistemaFinanceiro.View.RedefinirSenha;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    edtNome: TEdit;
    edtUsuario: TEdit;
	 Label2: TLabel;
	 Label4: TLabel;
	 ToggleStatus: TToggleSwitch;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
	 LimparSenha1: TMenuItem;
    RedefinirSenha1: TMenuItem;
	 procedure FormShow(Sender: TObject);
	 procedure btnSalveClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
	 procedure LimparSenha1Click(Sender: TObject);

	  
	 
  private
	 { Private declarations }
  public
	 { Public declarations }
  protected
	 procedure Pesquisar;override; 
  end;

var
  frmUsuarios: TfrmUsuarios;
 
implementation
uses
 SistemaFinanceiro.Module.Usuarios,
 BCrypt
 ;
{$R *.dfm}





procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin                                                            
	  inherited;
		edtNome.Text := ModuleUsuarios.CDSUsuariosnome.AsString;
		edtUsuario.Text := ModuleUsuarios.CDSUsuarioslogin.AsString;
		
		ToggleStatus.State := tssOn;
		if ModuleUsuarios.CDSUsuariosstatus.AsString = 'B' then
			ToggleStatus.State := tssOff;
end;
procedure TfrmUsuarios.btnSalveClick(Sender: TObject);
var 
LStatus: String;
begin 
	 if trim(edtUsuario.Text) = '' then
		begin
			edtUsuario.SetFocus;
			Application.MessageBox('O campo de Usuario esta vazio !!','Atenção', MB_OK + MB_ICONWARNING);
			abort;
		end;
	 if trim(edtNome.Text) = '' then
		begin
			edtNome.SetFocus;
			Application.MessageBox('O campo de Nome esta vazio !!','Atenção', MB_OK + MB_ICONWARNING);
			abort;
		end;
		if ModuleUsuarios.TemLoginCadastrado(trim(edtUsuario.Text) ,  ModuleUsuarios.CDSUsuarios.FieldByName('ID').AsString) then
		begin
			edtUsuario.SetFocus;
			Application.MessageBox(PWideChar(Format('O login %s ja se encontra cadastrado !! ', [edtUsuario.Text])),'Atenção', MB_OK + MB_ICONWARNING);
			abort;
		end;
		LStatus:='A';
		if ToggleStatus.State = tssOff then
		LStatus:= 'B';
		
		if ModuleUsuarios.CDSUsuarios.State in [dsInsert]  then
		begin
			ModuleUsuarios.CDSUsuariosid.AsString := TUtilitarios.GetId;
			ModuleUsuarios.CDSUsuariosdata_cadastro.AsDateTime := now;
			ModuleUsuarios.CDSUsuariossenha.AsString := TBCrypt.GenerateHash(ModuleUsuarios.TEMP_PASSWORD) ;
			ModuleUsuarios.CDSUsuariossenha_temporaria.AsString := 'S';
		 end;
	 
		ModuleUsuarios.CDSUsuariosnome.AsString :=  Trim(edtNome.Text);
		ModuleUsuarios.CDSUsuarioslogin.AsString :=   Trim(edtUsuario.Text);
		ModuleUsuarios.CDSUsuariosstatus.AsString := (LStatus);
		inherited;
end;
procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
	  inherited;
	  CardPrincipal.ActiveCard := CdPesquisar;
	  
end;
procedure TfrmUsuarios.LimparSenha1Click(Sender: TObject);
begin
	inherited;
	if not DataSource1.DataSet.IsEmpty then
	begin
		ModuleUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('ID').AsString);
		Application.MessageBox(PWideChar(Format('Foi definida a senha  padrão para o usuario "%s" ',[DataSource1.DataSet.FieldByName('Nome').AsString])),'Atenção', MB_OK + MB_ICONINFORMATION )
	end;
  
end;
procedure TfrmUsuarios.Pesquisar;
var 
FiltroPesquisa : string;
begin
  inherited;
  FiltroPesquisa:= TUtilitarios.LikeFind(edtPesquisa.Text, DBGrid1);
  ModuleUsuarios.CDSUsuarios.Close;
  ModuleUsuarios.CDSUsuarios.CommandText := 'select * from usuarios where 1 = 1' + FiltroPesquisa;
  ModuleUsuarios.CDSUsuarios.Open;  
end;



end.
