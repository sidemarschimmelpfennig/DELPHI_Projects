unit SistemaFinanceiro.View.Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SistemaFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TfrmCaixa = class(TfrmCadastroPadrao)
    edtDocumento: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtValor: TEdit;
    edtDescricao: TEdit;
    RadioGroup1: TRadioGroup;
    ComboBox1: TComboBox;
    Label2: TLabel;
	 procedure Pesquisar;override;
    procedure btnSalveClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
	 { Private declarations }
  public
	 { Public declarations }
  end;

var
  frmCaixa: TfrmCaixa;

implementation

{$R *.dfm}

uses SistemaFinanceiro.Module.Caixa, SistemaFinanceiro.View.Usuarios,
  Utilitarios;

procedure TfrmCaixa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtDocumento.Text := ModuleCaixa.CDSCaixaNUMERO_DOC.AsString;
  edtValor.Text := ModuleCaixa.CDSCaixaVALOR.AsString;
  edtDescricao.Text := ModuleCaixa.CDSCaixaDESCRICAO.AsString;
  if ModuleCaixa.CDSCaixaTIPO.AsString = 'R' then
	  RadioGroup1.ItemIndex:= 0
  else if ModuleCaixa.CDSCaixaTIPO.AsString = 'D'  then
	  RadioGroup1.ItemIndex:= 1;
  end;   
  


procedure TfrmCaixa.btnSalveClick(Sender: TObject);
var 
Ltipo: string;
begin
 
  if trim(edtDocumento.Text) = '' then
		begin
			edtDocumento.SetFocus;
			Application.MessageBox('O campo do Documento esta vazio !!','Aten��o', MB_OK + MB_ICONWARNING);
			abort;
		end;
	if trim(edtValor.Text) = '' then
		begin
			edtValor.SetFocus;
			Application.MessageBox('O campo de Valor esta vazio !!','Aten��o', MB_OK + MB_ICONWARNING);
			abort;
		end;


	if RadioGroup1.ItemIndex = -1 then
		begin
			RadioGroup1.SetFocus;
			Application.MessageBox('O campo de Valor esta vazio !!','Aten��o', MB_OK + MB_ICONWARNING);
			abort;
		end;
		LTipo := 'R';
		if RadioGroup1.ItemIndex = 1 then
		Ltipo := 'D';

		if DataSource1.State in [dsInsert] then
		begin
			ModuleCaixa.CDSCaixaID.AsString := TUtilitarios.GetId;
			ModuleCaixa.CDSCaixaDATA_CADASTRO.AsDateTime := Now;
		end;

		ModuleCaixa.CDSCaixaNUMERO_DOC.AsString:= Trim(edtDocumento.Text);
		ModuleCaixa.CDSCaixaDESCRICAO.AsString:= Trim(edtDescricao.Text);
		ModuleCaixa.CDSCaixaVALOR.AsCurrency:= StrToFloat(edtValor.Text);
		ModuleCaixa.CDSCaixaTIPO.AsString:= LTipo;
		
		
		
		  inherited;
		
end;

procedure TfrmCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  edtValor.OnKeyPress:= TUtilitarios.KeyPressValor;
end;

procedure TfrmCaixa.Pesquisar;
var 
FiltroPesquisa : String;
FiltroResultado: String;
begin
case ComboBox1.ItemIndex of
  1 : FiltroResultado := 'AND TIPO = ''R''';
  2 : FiltroResultado := 'AND TIPO = ''D''';
  3 : FiltroResultado :=  'AND DESCRICAO = DESCRICAO ';
end;

 inherited;
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisa.Text, DBGrid1);
	ModuleCaixa.CDSCaixa.Close;
	ModuleCaixa.CDSCaixa.CommandText:='SELECT * FROM CAIXA WHERE 1 = 1 ' + FiltroPesquisa + FiltroResultado;
	ModuleCaixa.CDSCaixa.open;
end;

end.
