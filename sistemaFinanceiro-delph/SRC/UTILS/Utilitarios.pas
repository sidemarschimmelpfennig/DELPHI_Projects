unit Utilitarios;
interface
uses
 Vcl.Grids, Vcl.DBGrids;
type
  TUtilitarios = class 
	  class function GetId:String;
	  class function LikeFind(Pesquisa : String; Grid: TDBGrid):string;
	  class function FormatoMoeda(aValue: currency):String;
	  class function FormatoValor(aValue: currency; Decimais: Integer = 2 ) :string ; overload;
	  class function FormatoValor(aValue: string;  Decimais: Integer = 2 ) :string ; overload;
	  class procedure KeyPressValor (Sender: TObject; var Key: Char);
	  class function TruncarValor (aValue: Currency ;Decimais: Integer = 2 ): Currency ;
  end;
implementation
 uses
 System.SysUtils, Vcl.StdCtrls, Winapi.Windows, system.math ;
{ TUtilitarios }

class procedure TUtilitarios.KeyPressValor(Sender: TObject;
  var Key: Char);
begin
  if key = FormatSettings.ThousandSeparator then
	 begin
	  Key:= FormatSettings.DecimalSeparator; 
	 end;
	if not(CharInSet(key, ['0'..'9', FormatSettings.DecimalSeparator , chr(8) ])) then
	begin
	  Key:= #0; 
	end;
	if (Key = FormatSettings.DecimalSeparator) and (pos(Key , TEdit(Sender).Text)> 0  )  then
	begin
	  Key:= #0;
	end
end;

class function TUtilitarios.FormatoMoeda(aValue: currency): String;
begin
  Result := Format('%m', [aValue] )   
end;

class function TUtilitarios.FormatoValor(aValue: currency;
  Decimais: Integer): string;
begin
  aValue := TruncarValor(aValue, Decimais);
  Result := FormatCurr('0.' + StringOfChar('0' , Decimais), aValue )
end;

class function TUtilitarios.FormatoValor(aValue: string;
  Decimais: Integer): string;
  var
  LValor: Currency;
begin
  LValor:= 0;
  TryStrToCurr(aValue, LValor);
  Result:= FormatoValor(LValor, Decimais);
end;

class function TUtilitarios.GetId: String;
begin
Result:= TGUID.NewGuid.ToString;
Result:= StringReplace(Result,'{','', [rfReplaceAll]);
Result:= StringReplace(Result,'}','', [rfReplaceAll]);
end;

class function TUtilitarios.LikeFind(Pesquisa: String; Grid: TDBGrid): string;
var
	LContador: Integer;
begin
	Result:= '';
	if Trim(Pesquisa) = '' then
	 exit  ;
	for LContador := 0 to Pred(Grid.Columns.Count) do
		Result :=  Result + Grid.Columns.Items[LContador].FieldName + ' LIKE ' + QuotedStr('%' + Trim(Pesquisa)+ '%') + ' OR ';
  
	Result:= ' AND (' + Copy(Result, 1 , Length(Result) -4) + ')'   
end;

class function TUtilitarios.TruncarValor(aValue: Currency;
  Decimais: Integer): Currency;
var 
LFator: Double;
begin
	LFator := Power(10, Decimais);
	Result := Trunc(aValue*LFator)/ LFator;
end;

end.
