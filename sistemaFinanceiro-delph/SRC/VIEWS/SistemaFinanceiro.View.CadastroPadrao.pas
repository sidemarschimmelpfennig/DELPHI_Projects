unit SistemaFinanceiro.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels,
	SistemaFinanceiro.Module.Conexao,
  SistemaFinanceiro.Module.UltimoLogin;

type
  TfrmCadastroPadrao = class(TForm)
    CardPrincipal: TCardPanel;
    CdCadastar: TCard;
	 CdPesquisar: TCard;
	 pnlTopCDP: TPanel;
    edtPesquisa: TEdit;
    btnPesquisar: TButton;
    pnlBottom: TPanel;
    DBGrid1: TDBGrid;
    btnFechar: TButton;
    btnIncluir: TButton;
    btnImprimir: TButton;
    btnExcluir: TButton;
    Label1: TLabel;
    ImageList1: TImageList;
    btnAlterar: TButton;
    Panel1: TPanel;
    btnCancelar: TButton;
    btnSalve: TButton;
    DataSource1: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
	 procedure FormShow(Sender: TObject);
	 procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalveClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
	 procedure btnExcluirClick(Sender: TObject);
  private
	 { Private declarations }
	 procedure LimparCampos;
	 procedure HabilitarBotoes;
  public
	 { Public declarations }
  protected
    procedure Pesquisar;virtual;
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

uses
  Datasnap.DBClient, SistemaFinanceiro.Module.Usuarios, Vcl.WinXCtrls;

{$R *.dfm}

procedure TfrmCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
 TClientDataSet(DataSource1.DataSet).Edit;
 CardPrincipal.ActiveCard:= CdCadastar; 
end;
procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  TClientDataSet(DataSource1.Dataset).cancel;
  CardPrincipal.ActiveCard:= CdPesquisar;
end;
procedure TfrmCadastroPadrao.btnExcluirClick(Sender: TObject);
begin
	if Application.MessageBox('Deseja realmente excluir o registro ?', 'Pergunta', MB_YESNO + MB_ICONQUESTION ) <> mrYes  then
	 exit  ;
	try
		TClientDataSet(DataSource1.DataSet).Delete;
		TClientDataSet(DataSource1.DataSet).ApplyUpdates(0);
		Application.MessageBox('Registro excluido com Sucesso !! ', 'Informação', MB_OK);
	except on E : exception do  
	  Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir registro', MB_OK + MB_ICONERROR)
	end;
end;
procedure TfrmCadastroPadrao.btnFecharClick(Sender: TObject);
begin
close;
end;
procedure TfrmCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
TClientDataSet(DataSource1.DataSet).Insert; 
LimparCampos;    
CardPrincipal.ActiveCard := CdCadastar; 
end;
procedure TfrmCadastroPadrao.btnPesquisarClick(Sender: TObject);
begin
	Pesquisar;
end;
procedure TfrmCadastroPadrao.btnSalveClick(Sender: TObject);
var
Mensagem: string;
begin
TClientDataSet(DataSource1.DataSet).Edit;
Mensagem := 'Registro alterado com sucesso!!';
if DataSource1.State in [dsInsert]  then
  Mensagem := 'Registro incluido com sucesso!!';

TClientDataSet(DataSource1.DataSet).Post;
TClientDataSet(DataSource1.DataSet).ApplyUpdates(0);
Application.MessageBox(PWideChar(Mensagem),'Sucesso',MB_OK);

Pesquisar;
CardPrincipal.ActiveCard := CdPesquisar;
end;
procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
 CardPrincipal.ActiveCard := CdPesquisar; 
 Pesquisar;
end;
procedure TfrmCadastroPadrao.HabilitarBotoes;
begin
  btnAlterar.Enabled := not DataSource1.DataSet.IsEmpty;
  btnExcluir.Enabled := not DataSource1.DataSet.IsEmpty;
end;
procedure TfrmCadastroPadrao.LimparCampos;
var 
Contador: integer;
begin
	for Contador := 0 to Pred (ComponentCount) do
	begin
	if Components[Contador] is TCustomEdit   then
	TCustomEdit(Components[Contador]).Clear
	else if Components[Contador] is TToggleSwitch then
		TToggleSwitch(Components[Contador]).State := tssOn
	else if Components[Contador] is TRadioGroup then 
		  TRadioGroup(Components[Contador]).ItemIndex := -1;
	end;
end;
procedure TfrmCadastroPadrao.Pesquisar;
begin
	HabilitarBotoes();
end;

end.
