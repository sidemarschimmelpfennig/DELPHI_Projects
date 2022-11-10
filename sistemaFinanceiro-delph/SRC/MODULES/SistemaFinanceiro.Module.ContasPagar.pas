unit SistemaFinanceiro.Module.ContasPagar;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, 
  SistemaFinanceiro.Model.Entidades.ContasPagar, SistemaFinanceiro.Model.Entidades.ContasPagarDetalhe;

type
  TModuleContasPagar = class(TDataModule)
	 SQLContasPagar: TFDQuery;
    CDSContasPagar: TClientDataSet;
	 DSPContasPagar: TDataSetProvider;
    CDSContasPagarID: TStringField;
    CDSContasPagarNUMERO_DOCUMENTO: TStringField;
    CDSContasPagarDESCRICAO: TStringField;
    CDSContasPagarPARCELA: TIntegerField;
    CDSContasPagarVALOR_PARCELA: TFMTBCDField;
    CDSContasPagarVALOR_COMPRA: TFMTBCDField;
    CDSContasPagarVALOR_ABATIDO: TFMTBCDField;
    CDSContasPagarDATA_COMPRA: TDateField;
    CDSContasPagarDATA_CADASTRO: TDateField;
    CDSContasPagarDATA_VENCIMENTO: TDateField;
    CDSContasPagarDATA_PAGAMENTO: TDateField;
    CDSContasPagarSTATUS: TStringField;
  private
    { Private declarations }
  public
	 { Public declarations }
	 
	 function GetContaPagar  (ID: string ) :  TModelContasPagar;
	 procedure BaixarContaPagar (BaixaPagar: TModelContaPagarDetalhe);

  end;

var
  ModuleContasPagar: TModuleContasPagar;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SistemaFinanceiro.Module.Conexao, Utilitarios;

{$R *.dfm}

{ TModuleContasPagar }

procedure TModuleContasPagar.BaixarContaPagar(BaixaPagar: TModelContaPagarDetalhe);
var 
 ContaPagar: TModelContasPagar;
 SQLGravar: TFDQuery; 
 SQL: string; 
begin
 ContaPagar := GetContaPagar(BaixaPagar.IDContaPagar);
 
  try
	  ContaPagar.ValorAbatido := ContaPagar.ValorAbatido + BaixaPagar.Valor;
	  if ContaPagar.ValorAbatido >= ContaPagar.ValorParcela then
		begin
			ContaPagar.Status := 'B';
			ContaPagar.DataPagamento := now;
		end;
		SQLGravar := TFDQuery.Create(nil);
		try
		{Codigo SQL ========================================================}
		SQLGravar.Connection := ModuleConexao.FBCONEXAO; 

		SQLContasPagar.Edit ;
		SQL := 'UPDATE CONTAS_PAGAR SET VALOR_ABATIDO = :VALORABATIDO, '  +
		'VALOR_PARCELA = :VALORPARCELA, DATA_PAGAMENTO = :DATAPAGAMENTO,STATUS = :STATUS WHERE ID = :IDCONTAPAGAR;' ;
		SQLGravar.SQL.Clear;
		SQLGravar.SQL.ADD(SQL);
	
		SQLGravar.ParamByName('VALORABATIDO').AsCurrency := ContaPagar.ValorAbatido;
		SQLGravar.ParamByName('VALORPARCELA').AsCurrency := ContaPagar.ValorParcela;
		SQLGravar.ParamByName('STATUS').AsString := ContaPagar.Status;
		SQLGravar.ParamByName('DATAPAGAMENTO').AsDateTime := ContaPagar.DataPagamento;
		SQLGravar.ParamByName('IDCONTAPAGAR').AsString := ContaPagar.ID;
	  
		SQL :='INSERT INTO CONTAS_PAGAR_DETALHES (ID, ID_CONTA_PAGAR, DETALHES, VALOR, DATA, USUARIO) VALUES (:IDDETALHE,:IDCONTAPAGAR, :DETALHES, :VALOR, :DATA, :USUARIO);';
		SQLGravar.SQL.Clear;
		SQLGravar.SQL.ADD(SQL);
		
		SQLGravar.ParamByName('IDDETALHE').AsString := TUtilitarios.GetId;
		SQLGravar.ParamByName('DETALHES').AsString := BaixaPagar.Detalhes;
		SQLGravar.ParamByName('VALOR').AsCurrency := BaixaPagar.Valor;
		SQLGravar.ParamByName('IDCONTAPAGAR').AsString := ContaPagar.ID;
		SQLGravar.ParamByName('DATA').AsDateTime := BaixaPagar.Data;
		SQLGravar.ParamByName('USUARIO').AsString := BaixaPagar.Usuario;

		SQLGravar.Prepare;
		SQLGravar.ExecSQL;
		  SQLGravar.Post;
		{=====================================================================}
		finally
		  SQLGravar.Free;
		end;
  finally
	ContaPagar.Free;
  end;
end;

function TModuleContasPagar.GetContaPagar(ID: string): TModelContasPagar;
var 
SQLConsulta: TFDQuery;
begin
 SQLConsulta:= TFDQuery.Create(nil);
 try
	 SQLConsulta.Connection := ModuleConexao.FBCONEXAO;
	 SQLConsulta.SQL.Clear;
	 SQLConsulta.SQl.Add('Select * from CONTAS_PAGAR WHERE ID = :ID');
	 SQLConsulta.ParamByName('ID').AsString:= ID ;
	 SQLConsulta.Open;
	 Result:= TModelContasPagar.Create;
	 try
		Result.ID := SQLConsulta.FieldByName('ID').AsString;
		Result.Documento := SQLConsulta.FieldByName('NUMERO_DOCUMENTO').AsString;
		Result.Descricao := SQLConsulta.FieldByName('DESCRICAO').AsString;
		Result.Parcela := SQLConsulta.FieldByName('PARCELA').AsInteger;
		Result.ValorParcela := SQLConsulta.FieldByName('VALOR_PARCELA').AsCurrency;
		Result.ValorCompra := SQLConsulta.FieldByName('VALOR_COMPRA').AsCurrency;
		Result.ValorAbatido := SQLConsulta.FieldByName('VALOR_ABATIDO').AsCurrency;
		Result.DataCompra := SQLConsulta.FieldByName('DATA_COMPRA').AsDateTime;
		Result.DataCadastro := SQLConsulta.FieldByName('DATA_CADASTRO').AsDateTime;
		Result.DataVencimento := SQLConsulta.FieldByName('DATA_VENCIMENTO').AsDateTime;
		Result.DataPagamento := SQLConsulta.FieldByName('DATA_PAGAMENTO').AsDateTime;
		Result.Status := SQLConsulta.FieldByName('STATUS').AsString;
	 except
	  Result.Free;
	  raise
	  
	 end;

 finally
	 SQLConsulta.Free;
 end;

end;

end.





