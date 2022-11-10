unit SistemaFinanceiro.Module.Caixa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  Datasnap.DBClient,Utilitarios.Recebimento.Caixa,SistemaFinanceiro.Module.Conexao;

type
  TModuleCaixa = class(TDataModule)
    CDSCaixa: TClientDataSet;
    DSPCaixa: TDataSetProvider;
    SQLCaixa: TFDQuery;
    CDSCaixaID: TStringField;
    CDSCaixaNUMERO_DOC: TStringField;
    CDSCaixaDESCRICAO: TStringField;
    CDSCaixaVALOR: TFMTBCDField;
	 CDSCaixaDATA_CADASTRO: TDateField;
    CDSCaixaTIPO: TStringField;
  private
	 { Private declarations }
	 function GetSaldoAnterior(Data : TDate ): currency;
	 function GetTotalEntradas(DataInicial, DataFinal : TDate ): currency;
	 function GetTotalSaidasCaixa(DataInicial, DataFinal : TDate ): currency;

		public
	 { Public declarations }
	 function ResumoCaixa(DataInicial, DataFinal : TDate ): TModelResumoCaixa;
  end;

var
  ModuleCaixa: TModuleCaixa;

implementation


 

{%CLASSGROUP 'Vcl.Controls.TControl'}



{$R *.dfm}

{ TModuleCaixa }

function TModuleCaixa.GetSaldoAnterior(Data: TDate): currency;
var 
SQLConsulta: TFDQuery;
TotalEntradas: Currency;
TotalSaidas: Currency;
begin
  SQLConsulta:= TFDQuery.Create(nil);
  try
	//Entradas =====
	SQLConsulta.Connection := ModuleConexao.FBCONEXAO;
	SQLConsulta.SQL.Clear;
	SQLConsulta.SQL.Add('SELECT SUM(VALOR) AS VALOR  FROM CAIXA WHERE TIPO = ''R''  ');
	SQLConsulta.SQL.Add('AND DATA_CADASTRO < :DATA ');
	SQLConsulta.ParamByName('DATA').AsDate := Data;
	SQLConsulta.Open;
	TotalEntradas := SQLConsulta.FieldByName('VALOR').AsCurrency;
	//Saidas ======
	SQLConsulta.SQL.Clear;
	SQLConsulta.SQL.Add('SELECT SUM(VALOR) AS VALOR FROM CAIXA WHERE TIPO =''D''  ');
	SQLConsulta.SQL.Add('AND DATA_CADASTRO < :DATA ');
	SQLConsulta.ParamByName('DATA').AsDate := Data;
	SQLConsulta.Open;
	TotalSaidas := SQLConsulta.FieldByName('VALOR').AsCurrency;
  finally
	 SQLConsulta.Free;
  end;
  Result:= TotalEntradas - TotalSaidas;
  
end;

function TModuleCaixa.GetTotalEntradas(DataInicial, DataFinal: TDate): currency;
var 
SQLConsulta: TFDQuery;
begin
  Result:= 0;
  SQLConsulta:= TFDQuery.Create(nil);
  try
	SQLConsulta.Connection := ModuleConexao.FBCONEXAO;
	SQLConsulta.SQL.Clear;
	SQLConsulta.SQL.Add('SELECT SUM(VALOR) AS VALOR FROM CAIXA WHERE TIPO = ''R''  ');
	SQLConsulta.SQL.Add('AND DATA_CADASTRO BETWEEN :DATAINICIAL AND :DATAFINAL ');
	SQLConsulta.ParamByName('DATAINICIAL').AsDate := DataInicial;
	SQLConsulta.ParamByName('DATAFINAL').AsDate := DataFinal; 
	SQLConsulta.Open;
	Result := SQLConsulta.FieldByName('VALOR').AsCurrency; 
  finally
	 SQLConsulta.Free;
  end;


end;

function TModuleCaixa.GetTotalSaidasCaixa(DataInicial, DataFinal: TDate): currency;
var
     SQLConsulta: TFDQuery;
begin
  Result:= 0;                         
  SQLConsulta:= TFDQuery.Create(nil);
  try
	SQLConsulta.Connection := ModuleConexao.FBCONEXAO;
	SQLConsulta.SQL.Clear;
	SQLConsulta.SQL.Add('SELECT SUM(VALOR) AS VALOR FROM CAIXA WHERE TIPO = ''D''  ');
	SQLConsulta.SQL.Add('AND DATA_CADASTRO BETWEEN :DATAINICIAL AND :DATAFINAL  ');
	SQLConsulta.ParamByName('DATAINICIAL').AsDate := DataInicial;
	SQLConsulta.ParamByName('DATAFINAL').AsDate := DataFinal; 
	SQLConsulta.Open;
	Result := SQLConsulta.FieldByName('VALOR').AsCurrency; 
  finally
	 SQLConsulta.Free;
  end;
end;
function TModuleCaixa.ResumoCaixa(DataInicial, DataFinal: TDate): TModelResumoCaixa;
begin
	if DataInicial > DataFinal then
	  raise Exception.Create('Data inicial maior que a final');
	Result:= TModelResumoCaixa.Create;
	try
	  Result.SaldoInicial := GetSaldoAnterior(DataInicial);
	  Result.ValorEntradas := GetTotalEntradas(DataInicial, DataFinal);
	  Result.ValorSaidas := GetTotalSaidasCaixa(DataInicial, DataFinal);
	except
	 Result.Free;
	 raise
	end;
end;

end.
