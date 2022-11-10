unit SistemaFinanceiro.View.ContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SistemaFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Datasnap.DBClient, Vcl.WinXCtrls, Vcl.ComCtrls;

type
  TfrmContasReceber = class(TfrmCadastroPadrao)
    CardPanel1: TCardPanel;
    Card1: TCard;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    edtDescricao: TEdit;
    edtValorVenda: TEdit;
    DataVenda: TDateTimePicker;
    Panel3: TPanel;
    CardParcela: TCardPanel;
    CardParcelamento: TCard;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    DataVencimento: TDateTimePicker;
    edtNumDocumento: TEdit;
    edtParcela: TEdit;
    edtValorParcela: TEdit;
    Card2: TCard;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtQuantidade: TEdit;
    edtIntervaloDias: TEdit;
    Button3: TButton;
    Button4: TButton;
    DBGrid2: TDBGrid;
    ToggleSwitch1: TToggleSwitch;
    Card3: TCard;
    Panel4: TPanel;
    Label14: TLabel;
    Edit1: TEdit;
    Button5: TButton;
    DBGrid3: TDBGrid;
    CDSParcelas: TClientDataSet;
    CDSParcelasParcela: TIntegerField;
    CDSParcelasValor: TCurrencyField;
    CDSParcelasVencimento: TDateField;
    CDSParcelasDocumento: TStringField;
    DSPArcelas: TDataSource;
    ImageList2: TImageList;
    procedure btnAlterarClick(Sender: TObject);
	 procedure btnExcluirClick(Sender: TObject);
	 procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalveClick(Sender: TObject);
    procedure edtValorVendaExit(Sender: TObject);
    procedure edtValorParcelaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
  private
	 { Private declarations }
	 procedure CadastrarParcelamento;
	  procedure CadastrarParcelaUnica;
  public
	 { Public declarations }
	   protected
  procedure Pesquisar;override;
	 
  end;

var
  frmContasReceber: TfrmContasReceber;

implementation

{$R *.dfm}

uses SistemaFinanceiro.Module.ContasReceber,
  Utilitarios, System.DateUtils;

procedure TfrmContasReceber.btnAlterarClick(Sender: TObject);
begin
  if ModuleContasReceber.CDSContasReceberSTATUS.AsString = 'B' then
  begin
Application.MessageBox('O documento ja foi baixado e nao pode ser alterado', 'Informa��o' ,MB_ICONWARNING);
abort;
  end;
	if ModuleContasReceber.CDSContasReceberSTATUS.AsString = 'C'then
  begin
Application.MessageBox('O documento ja foi Cancelado e nao pode ser alterado', 'Informa��o' ,MB_ICONWARNING);
abort;
  end;
  
  inherited;
  
  ToggleSwitch1.Enabled := False;
  CardParcela.ActiveCard := CardParcelamento;
  CDSParcelas.EmptyDataSet;

  edtNumDocumento.Text := ModuleContasReceber.CDSContasReceberNUMERO_DOCUMENTO.AsString;
  edtDescricao.Text := ModuleContasReceber.CDSContasReceberDESCRICAO.AsString;
  edtValorVenda.Text := TUtilitarios.FormatoValor(ModuleContasReceber.CDSContasReceberVALOR_VENDA.AsCurrency);
  DataVenda.DateTime := ModuleContasReceber.CDSContasReceberDATA_VENDA.AsDateTime;
  edtParcela.Text := ModuleContasReceber.CDSContasReceberPARCELA.AsString;
  edtValorParcela.Text :=TUtilitarios.FormatoValor(ModuleContasReceber.CDSContasReceberVALOR_PARCELA.AsCurrency);
  DataVencimento.DateTime := ModuleContasReceber.CDSContasReceberDATA_VENCIMENTO.AsDateTime;

end;

procedure TfrmContasReceber.btnExcluirClick(Sender: TObject);

begin
	  if ModuleContasReceber.CDSContasReceberSTATUS.AsString = 'C' then
		  begin
			  Application.MessageBox('O documento ja se encontra cancelado' , 'Aten��o' , MB_OK );
			  abort;
		  end;
		if Application.MessageBox('Deseja realmente cancelar o   a nota ? ', 'Pergunta', MB_YESNO + MB_ICONQUESTION ) <> mrYes  then
	 exit  ;
	try
		ModuleContasReceber.CDSContasReceber.Edit;
		ModuleContasReceber.CDSContasReceberSTATUS.AsString := 'C';
		ModuleContasReceber.CDSContasReceber.ApplyUpdates(0);
		Application.MessageBox('Registro excluido com Sucesso !! ', 'Informa��o', MB_OK);
		Pesquisar;
	except on E : exception do  
	  Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir registro', MB_OK + MB_ICONERROR)
	end;


end;

procedure TfrmContasReceber.btnIncluirClick(Sender: TObject);
begin
  DataVenda.Date := now;
  DataVencimento.Date := now;
  ToggleSwitch1.Enabled := true;
  ToggleSwitch1.State := tssOff ;
  CardParcela.ActiveCard := CardParcelamento; // card parcela unica 
  cdsParcelas.EmptyDataSet;
  inherited;
end;

procedure TfrmContasReceber.btnSalveClick(Sender: TObject);
begin
	if ToggleSwitch1.State = tssOff then
	begin
		CadastrarParcelaUnica;
		inherited;
	end
	else
		  CadastrarParcelamento

end;

procedure TfrmContasReceber.Button3Click(Sender: TObject);
var
Contador: INTEGER;
QuantidadeParcelas: INTEGER;
IntervaloParcelas: INTEGER;
ValorVenda: CURRENCY;
ValorParcela: CURRENCY;
ValorResiduo: CURRENCY;
begin
  //inherited;
 if not TryStrToInt(edtQuantidade.Text, QuantidadeParcelas) then
 begin
	 edtQuantidade.SetFocus;
	 Application.MessageBox('Aten��o campo de quantidade de parcelas vazio/errado','Aten��o', MB_ICONWARNING);
	 Abort;
 end;
if not TryStrToInt(edtIntervaloDias.Text, IntervaloParcelas) then
 begin
	 edtIntervaloDias.SetFocus;
	 Application.MessageBox('Aten��o campo de Intervalo entre as  parcelas vazio/errado','Aten��o', MB_ICONWARNING);
	 Abort;
 end;
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
 begin
	 edtValorVenda.SetFocus;
	 Application.MessageBox('Aten��o campo de Valor da Venda vazio/errado','Aten��o', MB_ICONWARNING);
	 Abort;
 end;
	
  //Valores de Calculo de Parcelas 
  ValorParcela := TUtilitarios.TruncarValor(ValorVenda / QuantidadeParcelas);
  ValorResiduo := ValorVenda - ( ValorParcela * QuantidadeParcelas);

	CDSParcelas.EmptyDataSet;

	for Contador := 1 to QuantidadeParcelas do
	begin
	  CDSParcelas.Insert;
	  CDSParcelasParcela.AsInteger := Contador;
	  CDSParcelasValor.AsCurrency := ValorParcela + ValorResiduo;
	  ValorResiduo := 0;
	  CDSParcelasVencimento.AsDateTime := IncDay(DataVenda.Date, (IntervaloParcelas * Contador)); 
	  CDSParcelas.Post;
	end;
end;
  
procedure TfrmContasReceber.Button4Click(Sender: TObject);
begin
  CDSParcelas.EmptyDataSet;

end;

procedure TfrmContasReceber.CadastrarParcelamento;
var 
	Parcela: INTEGER;
	ValorVenda: CURRENCY;
	ValorParcela: CURRENCY;
begin
  
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
	edtValorVenda.SetFocus;
	application.MessageBox('O campo Valor da Venda  esta incorreto ou  pode ser vazio !!' , 'Aten��o', MB_ICONWARNING);
	abort; 
  end;
  

  CDSParcelas.First;
  while not CDSParcelas.Eof do
  begin 
	  if CDSParcelasParcela.AsInteger < 0 then
	  begin
		  Application.MessageBox('Numero da parcela invalido','Erro', MB_ICONERROR);
		  Abort
	  end;
	  if CDSParcelasDocumento.AsString = '' then
	  begin
		  Application.MessageBox('Numero do documento Invalido', 'Informa��o', MB_ICONWARNING);
		  Abort;
	  end;
	  if CDSParcelasValor.AsCurrency < 0.01  then
		Begin
			Application.MessageBox('Valor da parcela invalido', 'Informa��o', MB_ICONWARNING);
			Abort;
		End;
	  CDSParcelas.Next;
  end;
  
	CDSParcelas.First;
	while not CDSParcelas.Eof do
	begin  
		if ModuleContasReceber.CDSContasReceber.State in [dsBrowse, dsInactive] then
		 ModuleContasReceber.CDSContasReceber.Insert;
		
	 ModuleContasReceber.CDSContasReceberID.AsString:= TUtilitarios.GetId;
	 ModuleContasReceber.CDSContasReceberDATA_CADASTRO.AsDateTime:= now;
	 ModuleContasReceber.CDSContasReceberSTATUS.AsString:= 'A';
	 ModuleContasReceber.CDSContasReceberVALOR_ABATIDO.AsCurrency := 0 ;
 
	 //ValorCompra := StrToCurr(edtValorCompra.Text);
	 //Parcela := StrToInt(edtParcela.Text);
	 //ValorParcela := StrToCurr(edtValorParcela.Text); 

	 ModuleContasReceber.CDSContasReceberNUMERO_DOCUMENTO.AsString := CDSParcelasDocumento.AsString;
	 ModuleContasReceber.CDSContasReceberDESCRICAO.AsString:= format('%s - parcela %d', [edtDescricao.Text, CDSParcelasParcela.AsInteger]);
	 ModuleContasReceber.CDSContasReceberVALOR_PARCELA.AsCurrency := CDSParcelasValor.AsCurrency;
	 ModuleContasReceber.CDSContasReceberPARCELA.AsInteger := CDSParcelasParcela.AsInteger;
	 ModuleContasReceber.CDSContasReceberVALOR_VENDA.AsCurrency := ValorVenda;
	 ModuleContasReceber.CDSContasReceberDATA_VENCIMENTO.AsDateTime := CDSParcelasVencimento.AsDateTime;
	 ModuleContasReceber.CDSContasReceberDATA_VENDA.AsDateTime := DataVenda.Date; 
	 ModuleContasReceber.CDSContasReceber.Post;
	 ModuleContasReceber.CDSContasReceber.ApplyUpdates(0);
	

	 CDSParcelas.Next;
	end;
	Application.MessageBox('Parcelas cadastradas com sucesso.', 'Aten��o', MB_OK + MB_ICONINFORMATION);
	Pesquisar;
	CardPrincipal.ActiveCard := CdPesquisar;
end;

procedure TfrmContasReceber.CadastrarParcelaUnica;
var 
Parcela: INTEGER;
ValorVenda: CURRENCY;
ValorParcela: CURRENCY;
begin
  if edtNumDocumento.Text = '' then
  begin
	edtNumDocumento.SetFocus;
	application.MessageBox('O campo n�o pode ser vazio !!' , 'Aten��o', MB_ICONWARNING);
	abort;
  end;
  
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
	edtValorVenda.SetFocus;
	application.MessageBox('O campo Valor da Compra  esta incorreto ou  pode ser vazio !!' , 'Aten��o', MB_ICONWARNING);
	abort; 
  end;
  
	 if not TryStrToInt(edtParcela.Text, Parcela) then
  begin
	edtParcela.SetFocus;
	application.MessageBox('Numero da Parcela Invalido' , 'Aten��o', MB_ICONWARNING);
	abort; 
  end;

	if not TryStrToCurr(edtValorParcela.Text, ValorParcela) then
  begin
	edtValorParcela.SetFocus;
	application.MessageBox('O campo parcela  esta incorreto ou  pode ser vazio !!' , 'Aten��o', MB_ICONWARNING);
	abort; 
  end;
  
  if DataVencimento.Date < DataVenda.Date then
  begin
	DataVencimento.SetFocus;
	Application.MessageBox('O Vencimento nao pode ser antes do Dia de Compra ' , 'Aten��o', MB_ICONWARNING );
	abort; 
  end;

  if DataSource1.State in [dsInsert] then
  begin
	 ModuleContasReceber.CDSContasReceberId.AsString:= TUtilitarios.GetId;
	 ModuleContasReceber.CDSContasReceberDATA_CADASTRO.AsDateTime := now;
	 ModuleContasReceber.CDSContasReceberSTATUS.AsString:= 'A';
	 ModuleContasReceber.CDSContasReceberVALOR_ABATIDO.AsCurrency := 0 ;
  end;

  ModuleContasReceber.CDSContasReceberNUMERO_DOCUMENTO.AsString := edtNumDocumento.Text;
  ModuleContasReceber.CDSContasReceberDESCRICAO.AsString:= edtDescricao.Text;
  ModuleContasReceber.CDSContasReceberVALOR_PARCELA.AsCurrency := ValorParcela;
  ModuleContasReceber.CDSContasReceberPARCELA.AsInteger := Parcela;
  ModuleContasReceber.CDSContasReceberVALOR_VENDA.AsCurrency := ValorVenda;
  ModuleContasReceber.CDSContasReceberDATA_VENCIMENTO.AsDateTime := DataVencimento.Date;
  ModuleContasReceber.CDSContasReceberDATA_VENDA.AsDateTime := DataVenda.Date; 


end;

procedure TfrmContasReceber.edtValorParcelaExit(Sender: TObject);
begin

	edtValorParcela.Text:= TUtilitarios.FormatoValor(edtValorParcela.Text)
end;

procedure TfrmContasReceber.edtValorVendaExit(Sender: TObject);
begin

	edtValorVenda.Text:= TUtilitarios.FormatoValor(edtValorVenda.Text);
end;

procedure TfrmContasReceber.FormCreate(Sender: TObject);
begin
    inherited;
  edtValorVenda.OnKeyPress := Utilitarios.TUtilitarios.KeyPressValor; 
  edtValorVenda.OnKeyPress := Utilitarios.TUtilitarios.KeyPressValor;

end;

procedure TfrmContasReceber.Pesquisar;
var 
FiltroPesquisa : STRING;
begin
	FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisa.Text, DBGrid1);
	ModuleContasReceber.CDSContasReceber.Close;
	ModuleContasReceber.CDSContasReceber.CommandText:='SELECT * FROM CONTAS_RECEBER WHERE 1 = 1 ' + FiltroPesquisa;
	ModuleContasReceber.CDSContasReceber.open;
  inherited;
	 
end;


procedure TfrmContasReceber.ToggleSwitch1Click(Sender: TObject);
begin
  CardParcela.ActiveCard:= CardParcelamento;
  if ToggleSwitch1.State =  tssOn then
	CardParcela.ActiveCard:= Card2;
	
end;

end.
