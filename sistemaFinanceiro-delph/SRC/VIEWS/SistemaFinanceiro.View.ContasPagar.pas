unit SistemaFinanceiro.View.ContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SistemaFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels,Utilitarios, SistemaFinanceiro.Module.ContasPagar,
  Vcl.ComCtrls, Vcl.WinXCtrls, Datasnap.DBClient, Datasnap.Provider, Vcl.Menus;

type
  TfrmContasPagar = class(TfrmCadastroPadrao)
    Label2: TLabel;
    edtDescricao: TEdit;
    edtValorCompra: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtParcela: TEdit;
    edtNumDocumento: TEdit;
    DataCompra: TDateTimePicker;
    DataVencimento: TDateTimePicker;
    edtValorParcela: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CardParcela: TCardPanel;
    CardParcelamento: TCard;
    Panel2: TPanel;
    Label5: TLabel;
    Label9: TLabel;
    ToggleSwitch1: TToggleSwitch;
    Card2: TCard;
    Label10: TLabel;
    Label11: TLabel;
    edtQuantidade: TEdit;
    edtIntervaloDias: TEdit;
    Button1: TButton;
    Button2: TButton;
    DBGrid2: TDBGrid;
    Label12: TLabel;
    Label13: TLabel;
    DSPArcelas: TDataSource;
    CDSParcelas: TClientDataSet;
    CDSParcelasParcela: TIntegerField;
    CDSParcelasValor: TCurrencyField;
    CDSParcelasVencimento: TDateField;
    CDSParcelasDocumento: TStringField;
    pop: TPopupMenu;
    Baixar1: TMenuItem;
	 procedure btnSalveClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
	 procedure btnIncluirClick(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
	 procedure btnAlterarClick(Sender: TObject);
	
	 procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorCompraExit(Sender: TObject);
    procedure edtValorParcelaExit(Sender: TObject);
    procedure Baixar1Click(Sender: TObject);
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
  frmContasPagar: TfrmContasPagar;

implementation

uses
  System.DateUtils, SistemaFinanceiro.View.ContasPagar.Baixar;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmContasPagar.Baixar1Click(Sender: TObject);
begin
  frmContasPagarBaixar.BaixarContaPagar(DataSource1.DataSet.FieldByName('ID').AsString);
  Pesquisar;
end;

procedure TfrmContasPagar.btnAlterarClick(Sender: TObject);
begin
  if ModuleContasPagar.CDSContasPagarSTATUS.AsString = 'B' then
  begin
Application.MessageBox('O documento ja foi baixado e nao pode ser alterado', 'Informação' ,MB_ICONWARNING);
abort;
  end;
	if ModuleContasPagar.CDSContasPagarSTATUS.AsString = 'C'then
  begin
Application.MessageBox('O documento ja foi Cancelado e nao pode ser alterado', 'Informação' ,MB_ICONWARNING);
abort;
  end;
  
  inherited;
  
  ToggleSwitch1.Enabled := False;
  CardParcela.ActiveCard := CardParcelamento;
  CDSParcelas.EmptyDataSet;

  edtNumDocumento.Text := ModuleContasPagar.CDSContasPagarNUMERO_DOCUMENTO.AsString;
  edtDescricao.Text := ModuleContasPagar.CDSContasPagarDESCRICAO.AsString;
  edtValorCompra.Text := TUtilitarios.FormatoValor(ModuleContasPagar.CDSContasPagarVALOR_COMPRA.AsCurrency);
  DataCompra.DateTime := ModuleContasPagar.CDSContasPagarDATA_COMPRA.AsDateTime;
  edtParcela.Text := ModuleContasPagar.CDSContasPagarPARCELA.AsString;
  edtValorParcela.Text :=TUtilitarios.FormatoValor(ModuleContasPagar.CDSContasPagarVALOR_PARCELA.AsCurrency);
  DataVencimento.DateTime := ModuleContasPagar.CDSContasPagarDATA_VENCIMENTO.AsDateTime;
end;

procedure TfrmContasPagar.btnExcluirClick(Sender: TObject);
begin
	  if ModuleContasPagar.CDSContasPagarSTATUS.AsString = 'C' then
		  begin
			  Application.MessageBox('O documento ja se encontra cancelado' , 'Atenção' , MB_OK );
			  abort;
		  end;
		if Application.MessageBox('Deseja realmente cancelar o   a nota ? ', 'Pergunta', MB_YESNO + MB_ICONQUESTION ) <> mrYes  then
	 exit  ;
	try
		ModuleContasPagar.CDSContasPagar.Edit;
		ModuleContasPagar.CDSContasPagarSTATUS.AsString := 'C';
		ModuleContasPagar.CDSContasPagar.ApplyUpdates(0);
		Application.MessageBox('Registro excluido com Sucesso !! ', 'Informação', MB_OK);
		Pesquisar;
	except on E : exception do  
	  Application.MessageBox(PWideChar(E.Message), 'Erro ao Excluir registro', MB_OK + MB_ICONERROR)
	end;

end;

procedure TfrmContasPagar.btnIncluirClick(Sender: TObject);
begin
  DataCompra.Date := now;
  DataVencimento.Date := now;
  ToggleSwitch1.Enabled := true;
  inherited;

end;

procedure TfrmContasPagar.btnSalveClick(Sender: TObject);
begin
	if ToggleSwitch1.State = tssOn then
	begin
		CadastrarParcelaUnica;
		inherited;
	end
	else
		  CadastrarParcelamento
end;

procedure TfrmContasPagar.Button1Click(Sender: TObject);

var
Contador: INTEGER;
QuantidadeParcelas: INTEGER;
IntervaloParcelas: INTEGER;
ValorCompra: CURRENCY;
ValorParcela: CURRENCY;
ValorResiduo: CURRENCY;
begin
  //inherited;
 if not TryStrToInt(edtQuantidade.Text, QuantidadeParcelas) then
 begin
	 edtQuantidade.SetFocus;
	 Application.MessageBox('Atenção campo de quantidade de parcelas vazio/errado','Atenção', MB_ICONWARNING);
	 Abort;
 end;
if not TryStrToInt(edtIntervaloDias.Text, IntervaloParcelas) then
 begin
	 edtIntervaloDias.SetFocus;
	 Application.MessageBox('Atenção campo de Intervalo entre as  parcelas vazio/errado','Atenção', MB_ICONWARNING);
	 Abort;
 end;
  if not TryStrToCurr(edtValorCompra.Text, ValorCompra) then
 begin
	 edtValorCompra.SetFocus;
	 Application.MessageBox('Atenção campo de Valor da Compra vazio/errado','Atenção', MB_ICONWARNING);
	 Abort;
 end;
	
  //Valores de Calculo de Parcelas 
  ValorParcela := TUtilitarios.TruncarValor(ValorCompra / QuantidadeParcelas);
  ValorResiduo := ValorCompra - ( ValorParcela * QuantidadeParcelas);

	CDSParcelas.EmptyDataSet;

	for Contador := 1 to QuantidadeParcelas do
	begin
	  CDSParcelas.Insert;
	  CDSParcelasParcela.AsInteger := Contador;
	  CDSParcelasValor.AsCurrency := ValorParcela + ValorResiduo;
	  ValorResiduo := 0;
	  CDSParcelasVencimento.AsDateTime := IncDay(DataCompra.Date, (IntervaloParcelas * Contador)); 
	  CDSParcelas.Post;
	end;
end;
  
procedure TfrmContasPagar.Button2Click(Sender: TObject);
begin
  CDSParcelas.EmptyDataSet;

end;

procedure TfrmContasPagar.CadastrarParcelamento;
var 
	Parcela: INTEGER;
	ValorCompra: CURRENCY;
	ValorParcela: CURRENCY;
begin
  
  if not TryStrToCurr(edtValorCompra.Text, ValorCompra) then
  begin
	edtValorCompra.SetFocus;
	application.MessageBox('O campo Valor da Compra  esta incorreto ou  pode ser vazio !!' , 'Atenção', MB_ICONWARNING);
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
		  Application.MessageBox('Numero do documento Invalido', 'Informação', MB_ICONWARNING);
		  Abort;
	  end;
	  if CDSParcelasValor.AsCurrency < 0.01  then
		Begin
			Application.MessageBox('Valor da parcela invalido', 'Informação', MB_ICONWARNING);
			Abort;
		End;
	  CDSParcelas.Next;
  end;
  
	CDSParcelas.First;
	while not CDSParcelas.Eof do
	begin  
		if ModuleContasPagar.CDSContasPagar.State in [dsBrowse, dsInactive] then
		 ModuleContasPagar.CDSContasPagar.Insert;
		
	 ModuleContasPagar.CDSContasPagarID.AsString:= TUtilitarios.GetId;
	 ModuleContasPagar.CDSContasPagarDATA_CADASTRO.AsDateTime:= now;
	 ModuleContasPagar.CDSContasPagarSTATUS.AsString:= 'A';
	 ModuleContasPagar.CDSContasPagarVALOR_ABATIDO.AsCurrency := 0 ;
 
	 //ValorCompra := StrToCurr(edtValorCompra.Text);
	 //Parcela := StrToInt(edtParcela.Text);
	 //ValorParcela := StrToCurr(edtValorParcela.Text); 

	 ModuleContasPagar.CDSContasPagarNUMERO_DOCUMENTO.AsString := CDSParcelasDocumento.AsString;
	 ModuleContasPagar.CDSContasPagarDESCRICAO.AsString:= format('%s - parcela %d', [edtDescricao.Text, CDSParcelasParcela.AsInteger]);
	 ModuleContasPagar.CDSContasPagarVALOR_PARCELA.AsCurrency := CDSParcelasValor.AsCurrency;
	 ModuleContasPagar.CDSContasPagarPARCELA.AsInteger := CDSParcelasParcela.AsInteger;
	 ModuleContasPagar.CDSContasPagarVALOR_COMPRA.AsCurrency := ValorCompra;
	 ModuleContasPagar.CDSContasPagarDATA_VENCIMENTO.AsDateTime := CDSParcelasVencimento.AsDateTime;
	 ModuleContasPagar.CDSContasPagarDATA_COMPRA.AsDateTime := DataCompra.Date; 
	 ModuleContasPagar.CDSContasPagar.Post;
	 ModuleContasPagar.CDSContasPagar.ApplyUpdates(0);
	

	 CDSParcelas.Next;
	end;
	Application.MessageBox('Parcelas cadastradas com sucesso.', 'Atenção', MB_OK + MB_ICONINFORMATION);
	Pesquisar;
	CardPrincipal.ActiveCard := CdPesquisar;
end;

procedure TfrmContasPagar.CadastrarParcelaUnica;
var 
Parcela: INTEGER;
ValorCompra: CURRENCY;
ValorParcela: CURRENCY;
begin
  if Trim(edtNumDocumento.Text) = '' then
  begin
	edtNumDocumento.SetFocus;
	application.MessageBox('O campo não pode ser vazio !!' , 'Atenção', MB_ICONWARNING);
	abort;
  end;
  
  if not TryStrToCurr(edtValorCompra.Text, ValorCompra) then
  begin
	edtValorCompra.SetFocus;
	application.MessageBox('O campo Valor da Compra  esta incorreto ou  pode ser vazio !!' , 'Atenção', MB_ICONWARNING);
	abort; 
  end;
  
	 if not TryStrToInt(edtParcela.Text, Parcela) then
  begin
	edtParcela.SetFocus;
	application.MessageBox('Numero da Parcela Invalido' , 'Atenção', MB_ICONWARNING);
	abort; 
  end;

	if not TryStrToCurr(edtValorParcela.Text, ValorParcela) then
  begin
	edtValorParcela.SetFocus;
	application.MessageBox('O campo parcela  esta incorreto ou  pode ser vazio !!' , 'Atenção', MB_ICONWARNING);
	abort; 
  end;
  
  if DataVencimento.Date < DataCompra.Date then
  begin
	DataVencimento.SetFocus;
	Application.MessageBox('O Vencimento nao pode ser antes do Dia de Compra ' , 'Atenção', MB_ICONWARNING );
	abort; 
  end;

  if DataSource1.State in [dsInsert] then
  begin
	 ModuleContasPagar.CDSContasPagarID.AsString:= TUtilitarios.GetId;
	 ModuleContasPagar.CDSContasPagarDATA_CADASTRO.AsDateTime:= now;
	 ModuleContasPagar.CDSContasPagarSTATUS.AsString:= 'A';
	 ModuleContasPagar.CDSContasPagarVALOR_ABATIDO.AsCurrency := 0 ;
  end;

  ModuleContasPagar.CDSContasPagarNUMERO_DOCUMENTO.AsString := edtNumDocumento.Text;
  ModuleContasPagar.CDSContasPagarDESCRICAO.AsString:= edtDescricao.Text;
  ModuleContasPagar.CDSContasPagarVALOR_PARCELA.AsCurrency := ValorParcela;
  ModuleContasPagar.CDSContasPagarPARCELA.AsInteger := Parcela;
  ModuleContasPagar.CDSContasPagarVALOR_COMPRA.AsCurrency := ValorCompra;
  ModuleContasPagar.CDSContasPagarDATA_VENCIMENTO.AsDateTime := DataVencimento.Date;
  ModuleContasPagar.CDSContasPagarDATA_COMPRA.AsDateTime := DataCompra.Date; 

end;

procedure TfrmContasPagar.edtValorCompraExit(Sender: TObject);
begin
  inherited;
  edtValorCompra.Text:= TUtilitarios.FormatoValor(edtValorCompra.Text);
end;

procedure TfrmContasPagar.edtValorParcelaExit(Sender: TObject);
begin
  inherited;
  edtValorParcela.Text:= TUtilitarios.FormatoValor(edtValorParcela.Text)
end;

procedure TfrmContasPagar.FormCreate(Sender: TObject);
begin
  inherited;
  edtValorCompra.OnKeyPress := Utilitarios.TUtilitarios.KeyPressValor; 
  edtValorParcela.OnKeyPress := Utilitarios.TUtilitarios.KeyPressValor;
end;

procedure TfrmContasPagar.Pesquisar;
var 
FiltroPesquisa : STRING;
begin
	FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisa.Text, DBGrid1);
	ModuleContasPagar.CDSContasPagar.Close;
	ModuleContasPagar.CDSContasPagar.CommandText:='SELECT * FROM CONTAS_PAGAR WHERE 1 = 1 ' + FiltroPesquisa;
	ModuleContasPagar.CDSContasPagar.open;
	inherited;
end;

procedure TfrmContasPagar.ToggleSwitch1Click(Sender: TObject);
begin
  CardParcela.ActiveCard:= Card2;
  if ToggleSwitch1.State =  tssOn then
	CardParcela.ActiveCard:= CardParcelamento;
end;

end.
