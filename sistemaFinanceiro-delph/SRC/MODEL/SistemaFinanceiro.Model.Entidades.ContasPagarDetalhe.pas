unit SistemaFinanceiro.Model.Entidades.ContasPagarDetalhe;

interface
	type 
	TModelContaPagarDetalhe = class
	private
		FID: String;
		FIDContaPagar: String ;
		FDetalhes: String;
		FValor: Currency;
		FData: TDate;
		FUsuario: String;
		procedure SetData(const value:TDate);
		procedure SetDetalhes(const value: string);
		procedure SetIDContaPagar(const value:String);
		procedure SetValor(const value:Currency);
		procedure SetUsuario(const value:String);
		procedure SetID(const value: String);
	public
		property ID: String read FID write FID;
		property IDContaPagar: String read FIDContaPagar write FIDContaPagar;
		property Detalhes: String read FDetalhes write FDetalhes;
		property Valor: Currency read FValor write FValor;
		property Data: TDate read FData write FData;
		property Usuario: String read FUsuario write FUsuario;
	end;
implementation             

{ TModelContaPagarDetalhe }

procedure TModelContaPagarDetalhe.SetData(const value: TDate);
begin

end;

procedure TModelContaPagarDetalhe.SetDetalhes(const value: string);
begin

end;

procedure TModelContaPagarDetalhe.SetID(const value: String);
begin

end;

procedure TModelContaPagarDetalhe.SetIDContaPagar(const value: String);
begin

end;

procedure TModelContaPagarDetalhe.SetUsuario(const value: String);
begin

end;

procedure TModelContaPagarDetalhe.SetValor(const value: Currency);
begin

end;

end.
