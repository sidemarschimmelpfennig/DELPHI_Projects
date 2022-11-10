unit SistemaFinanceiro.Model.Entidades.ContasPagar;

interface
	type TModelContasPagar = class
	private
    FID: String;
    FDocumento: String;
    FDescricao: String;
    FParcela: Integer;
	 FValorParcela: currency;
	 FValorCompra: currency;
    FValorAbatido: currency;
    FDataCadastro: TDate;
    FDataVencimento: TDate;
    FDataPagamento: TDate;
    FStatus: String;
	 FDataCompra: TDate;
	   procedure SetDataCadastro(const Value: TDate);
      procedure SetDataCompra(const Value: TDate);
      procedure SetDataPagamento(const Value: TDate);
      procedure SetDataVencimento(const Value: TDate);
      procedure SetDescricao(const Value: string);
      procedure SetDocumento(const Value: string);
      procedure SetID(const Value: string);
      procedure SetParcela(const Value: Integer);
      procedure SetStatus(const Value: string);
      procedure SetValorAbatido(const Value: Currency);
      procedure SetValorCompra(const Value: Currency);
		procedure SetValorParcela(const Value: Currency);

	 
	public
	 property ID: String read FID write FID;
	 property Documento: String read FDocumento write FDocumento;
	 property Descricao: String read FDescricao write FDescricao;
	 property Parcela: Integer read FParcela write FParcela;
	 property ValorParcela: currency read FValorParcela write FValorParcela;
	 property ValorCompra: currency read FValorParcela write FValorCompra;
	 property ValorAbatido: currency read FValorAbatido write FValorAbatido;
	 property DataCompra: TDate read FDataCompra write FDataCompra;
	 property DataCadastro: TDate read FDataCadastro write FDataCadastro;
	 property DataVencimento: TDate read FDataVencimento write FDataVencimento;
	 property DataPagamento: TDate read FDataPagamento write FDataPagamento;
	 property Status: String read FStatus write FStatus;
	 
	end;
implementation


{ TModelContasPagar }

procedure TModelContasPagar.SetDataCadastro(const Value: TDate);
begin
  FDataCadastro := value;
end;

procedure TModelContasPagar.SetDataCompra(const Value: TDate);
begin
  FDataCompra := value;
end;

procedure TModelContasPagar.SetDataPagamento(const Value: TDate);
begin
  FDataPagamento := value;
end;

procedure TModelContasPagar.SetDataVencimento(const Value: TDate);
begin
  FDataVencimento := value;
end;

procedure TModelContasPagar.SetDescricao(const Value: string);
begin
  FDescricao := value;
end;

procedure TModelContasPagar.SetDocumento(const Value: string);
begin
 FDocumento := value;
end;

procedure TModelContasPagar.SetID(const Value: string);
begin
  FID := value;
end;

procedure TModelContasPagar.SetParcela(const Value: Integer);
begin
  FParcela := value;
end;

procedure TModelContasPagar.SetStatus(const Value: string);
begin
 FStatus := value;
end;

procedure TModelContasPagar.SetValorAbatido(const Value: Currency);
begin
  FValorAbatido := value;
end;

procedure TModelContasPagar.SetValorCompra(const Value: Currency);
begin
  FValorCompra := value;
end;

procedure TModelContasPagar.SetValorParcela(const Value: Currency);
begin
  FValorParcela := value;
end;

end.
