unit Utilitarios.Recebimento.Caixa;

interface
 type 
 TModelResumoCaixa = class
	 private
    FSaldoInicial: Currency;
    FValorEntradas: currency;
	 FValorSaidas: Currency;
	 procedure setSaldoInicial(Const Value: Currency); 
	 procedure setValorEntradas(Const Value: Currency);
	 procedure setValorSaidas(Const Value: Currency);
	 public
		property SaldoInicial: Currency read FSaldoInicial write setSaldoInicial;
		property ValorEntradas: currency read FValorEntradas write setValorEntradas;
		property ValorSaidas: Currency read FValorSaidas write setValorSaidas;
		function SaldoParcial: Currency;
		function SaldoFinal: Currency;
 end;
implementation

{ TModelResumoCaixa }

function TModelResumoCaixa.SaldoFinal: Currency;
begin
	Result := FSaldoInicial + SaldoParcial; 
end;

function TModelResumoCaixa.SaldoParcial: Currency;
begin
	Result := FValorEntradas - FValorSaidas
end;

procedure TModelResumoCaixa.setSaldoInicial(const Value: Currency);
begin
FSaldoInicial := Value
end;

procedure TModelResumoCaixa.setValorEntradas(const Value: Currency);
begin
  FValorEntradas := Value;
end;

procedure TModelResumoCaixa.setValorSaidas(const Value: Currency);
begin
	FValorSaidas := Value;
end;

end.
