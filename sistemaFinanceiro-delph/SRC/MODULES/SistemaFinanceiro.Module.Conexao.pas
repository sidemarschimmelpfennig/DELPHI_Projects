unit SistemaFinanceiro.Module.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TModuleConexao = class(TDataModule)
    FBCONEXAO: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
	 const CONFIGURARQUIVO = 'SistemaFinanceiro.cfg';
	 { Private declarations }
  public
	 { Public declarations }
	 procedure CarregarConfiguracoes;
	 procedure Conectar;
	 procedure Desconectar;
  end;

var
  ModuleConexao: TModuleConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TModuleConexao.CarregarConfiguracoes;
var 
ParametroNome: string;
ParametroValor: string;
Contador:Integer;
ListaParametro: TStringList;
begin
	FBCONEXAO.Params.Clear;
  if not FileExists(CONFIGURARQUIVO) then
	 raise Exception.Create('Erro ,Necessario o arquivo SistemaFinanceiro.cfg ');
  ListaParametro := TStringList.Create;
  try
	  ListaParametro.LoadFromFile(CONFIGURARQUIVO);
	  for Contador := 0 to Pred(ListaParametro.Count) do
			begin
				if ListaParametro[Contador].IndexOf('=') > 0 then
				  begin
					  ParametroNome:= ListaParametro[Contador].Split(['=']) [0].Trim;
					  ParametroValor:= ListaParametro[Contador].Split(['=']) [1].Trim;
					  FBCONEXAO.Params.Add(ParametroNome + '=' + ParametroValor);
				  end;

			end;
		  
  finally
  ListaParametro.Free;
  end;
end;

procedure TModuleConexao.Conectar;
begin
	FBCONEXAO.Connected;
end;

procedure TModuleConexao.DataModuleCreate(Sender: TObject);
begin
CarregarConfiguracoes;
Conectar;
end;

procedure TModuleConexao.Desconectar;
begin
	 FBCONEXAO.Connected := False;
end;

end.
