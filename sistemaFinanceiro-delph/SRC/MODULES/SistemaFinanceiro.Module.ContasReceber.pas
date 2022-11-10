unit SistemaFinanceiro.Module.ContasReceber;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TModuleContasReceber = class(TDataModule)
    SQLContasReceber: TFDQuery;
    CDSContasReceber: TClientDataSet;
    DSPContasReceber: TDataSetProvider;
    CDSContasReceberID: TStringField;
    CDSContasReceberNUMERO_DOCUMENTO: TStringField;
    CDSContasReceberDESCRICAO: TStringField;
    CDSContasReceberPARCELA: TIntegerField;
    CDSContasReceberVALOR_PARCELA: TFMTBCDField;
    CDSContasReceberVALOR_VENDA: TFMTBCDField;
    CDSContasReceberVALOR_ABATIDO: TFMTBCDField;
    CDSContasReceberDATA_VENDA: TDateField;
    CDSContasReceberDATA_CADASTRO: TDateField;
    CDSContasReceberDATA_VENCIMENTO: TDateField;
    CDSContasReceberDATA_RECEBIMENTO: TDateField;
    CDSContasReceberSTATUS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleContasReceber: TModuleContasReceber;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SistemaFinanceiro.Module.Conexao;

{$R *.dfm}

end.
