unit SistemaFinanceiro.Module.UltimoLogin;

interface

uses
  System.SysUtils, System.Classes;

type
  TModuleLogin = class(TDataModule)
  private
	 const ARQUIVOCONFIGURACAO = 'SistemaFinanceiro.cfg'; 
	 function GetConfiguracao(secao,parametro, valorPadrao : String):string;
	 procedure SetConfiguracao (secao,parametro, valorPadrao : String);
	 //function DataUltimoCadastro: string;
	 { Private declarations }
  public
	 { Public declarations }
	 function DataUltimoAcesso:string; overload;
	 procedure DataUltimoAcesso(aValue:TDateTime);overload;
	 function UsuarioUltimoAcesso: string; overload;
	 procedure UsuarioUltimoAcesso(aValue: String);overload;
  end;

var
  ModuleLogin: TModuleLogin;

implementation
uses
System.IniFiles, Vcl.forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TModuleLogin.DataUltimoAcesso: string;
begin
	Result:= GetConfiguracao('ACESSO','Data','');
end;

procedure TModuleLogin.DataUltimoAcesso(aValue: TDateTime);
begin
  SetConfiguracao('ACESSO', 'Data' ,DateTimeToStr(aValue));
end;

{function TDataModule1.DataUltimoCadastro: string;
begin
	
end;}

function TModuleLogin.GetConfiguracao(secao, parametro,
  valorPadrao: String): string;
  var 
  LArquivoConfig: TIniFile;
begin
  LArquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName)+ ARQUIVOCONFIGURACAO );
  try
	 Result:= LArquivoConfig.ReadString(secao, parametro, valorPadrao )
  finally
	 LArquivoConfig.Free;
  end;
end;

procedure TModuleLogin.SetConfiguracao(secao, parametro, valorPadrao: String);
var 
  LArquivoConfig: TIniFile;
begin
  LArquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName)+ ARQUIVOCONFIGURACAO );
  try
	LArquivoConfig.WriteString(secao, parametro, valorPadrao );
finally
	LArquivoConfig.Free;
end;

end;

function TModuleLogin.UsuarioUltimoAcesso: string;
begin
  Result:= GetConfiguracao('ACESSO', 'Usuario', '')
end;

procedure TModuleLogin.UsuarioUltimoAcesso(aValue: String);
begin
  SetConfiguracao('ACESSO', 'Usuario', aValue);
end;

end.
