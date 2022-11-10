unit SistemaFinanceiro.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels, System.ImageList, Vcl.ImgList;

type
  TfrmUSUARIOS = class(TForm)
	 CdPnel: TCardPanel;
    Card_Cadastro: TCard;
    Card_Pesquisa: TCard;
    pnlPesquisa: TPanel;
    pnlRodape: TPanel;
    pnlPrincipal: TPanel;
    lblPesquisa: TLabel;
	 DBGrid1: TDBGrid;
	 btnPesquisar: TButton;
	 edtPesquisa: TEdit;
	 ImageList1: TImageList;
	 btnFechar: TButton;
	 btnIncluir: TButton;
	 btnAlterar: TButton;
	 btnExcluir: TButton;
	 btnImprimir: TButton;
	 Panel1: TPanel;
	 Panel2: TPanel;
	 Button1: TButton;
	 btnSalvar: TButton;
	 DataSource1: TDataSource;
	 procedure btnIncluirClick(Sender: TObject);
	 procedure Button1Click(Sender: TObject);
	 procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
	 { Private declarations }
  public
	 { Public declarations }
  end;

var
  frmUSUARIOS: TfrmUSUARIOS;
 
implementation


{$R *.dfm}

{procedure TfrmUSUARIOS.btnFecharClick(Sender: TObject);
begin
if MessageDlg('Tem Certeza que deseja Sair ? ', mtConfirmation, mbYesNo, 0) = 6 then
close;
end;

procedure TfrmUSUARIOS.btnIncluirClick(Sender: TObject);
begin
	CdPnel.ActiveCard := Card_Cadastro; 
end;

procedure TfrmUSUARIOS.btnPesquisarClick(Sender: TObject);
begin
    MonolitoFinanceiro.Db.Principal.DMConexao.FDQuery.Active := not MonolitoFinanceiro.Db.Principal.DMConexao.FDQuery.Active
end;

procedure TfrmUsuarios.Button1Click(Sender: TObject);
var
Retorno: Integer;
begin
	if MessageDlg('Tem Certeza que deseja Fechar ? ', mtConfirmation, mbYesNo, 0) = 6 then
	CdPnel.ActiveCard := Card_Pesquisa; 
end;  }

end.
