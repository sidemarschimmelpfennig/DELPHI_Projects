unit SistemaFinanceiro.View.ContasPagar.Baixar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmContasPagarBaixar = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblNumDocumento: TLabel;
    lblParcela: TLabel;
    lblVencimento: TLabel;
    lblValorParcela: TLabel;
    lblValorAbatido: TLabel;
    lbObservação: TLabel;
	 lblValor: TLabel;
	 edtObservacao: TEdit;
	 edtValor: TEdit;
	 btnSalve: TButton;
	 btnCancelar: TButton;
	 ImageList1: TImageList;
	 procedure btnCancelarClick(Sender: TObject);
	 procedure btnSalveClick(Sender: TObject);
	 procedure edtValorExit(Sender: TObject);
	 procedure FormCreate(Sender: TObject);
  private
	  FID : string;
	 { Private declarations }
  public
	 { Public declarations }
	 procedure BaixarContaPagar (ID: string  );
  end;

var
  frmContasPagarBaixar: TfrmContasPagarBaixar;

implementation

{$R *.dfm}

uses SistemaFinanceiro.Model.Entidades.ContasPagar, SistemaFinanceiro.Module.ContasPagar, Utilitarios, Utilitarios.Recebimento.Caixa,
  SistemaFinanceiro.Model.Entidades.ContasPagarDetalhe, SistemaFinanceiro.Module.Usuarios;

{ TfrmContasPagarBaixar }

procedure TfrmContasPagarBaixar.BaixarContaPagar(ID: string);
var
ContaPagar: TModelContasPagar; 
begin
  FID := Trim(ID);
  if FID.IsEmpty then
  raise Exception.Create('Id de Conta Invalido !!');

  ContaPagar := ModuleContasPagar.GetContaPagar(FID);
	try
	  if ContaPagar.Status = 'B' then
		 raise exception.Create('Não é possivel baixar um documento baixado');
	  if ContaPagar.Status = 'C' then
		 raise Exception.Create('Não é possivel baixar um documento cancelado');
	  lblNumDocumento.Caption := ContaPagar.Documento;
	  lblParcela.Caption:= IntToStr(ContaPagar.Parcela);
	  lblVencimento.Caption:= FormatDateTime('dd/mm/yyyy',ContaPagar.DataVencimento);
	  lblValorAbatido.Caption:= Utilitarios.TUtilitarios.FormatoValor( ContaPagar.ValorAbatido);
	  lblValorParcela.Caption := Utilitarios.TUtilitarios.FormatoValor( ContaPagar.ValorParcela);
	  edtValor.Text :=  '';
	  edtObservacao.Text := '';
	  finally
	 ContaPagar.Free;
	end;
  Self.ShowModal;
  
end;

procedure TfrmContasPagarBaixar.btnCancelarClick(Sender: TObject);
begin
ModalResult := mrCancel; 
end;

procedure TfrmContasPagarBaixar.btnSalveClick(Sender: TObject);
var
ContasPagarDetalhe : TModelContaPagarDetalhe;
ValorAbatido : Currency;
begin
 if Trim(edtObservacao.Text)= '' then
 begin
	 edtObservacao.SetFocus;
	 Application.MessageBox('Preencha o campo','Atenção', MB_ICONWARNING);
	 abort;
 end;
  ValorAbatido := 0;
  TryStrToCurr(edtValor.Text, ValorAbatido);
  
 if ValorAbatido <= 0 then
 begin
	 edtValor.SetFocus;
	 Application.MessageBox('Preencha o campo','Atenção', MB_ICONWARNING);
	 abort;
 end;

 ContasPagarDetalhe := TModelContaPagarDetalhe.Create;
 try 
  ContasPagarDetalhe.IDContaPagar := FID;
  ContasPagarDetalhe.Detalhes := edtObservacao.Text;
  ContasPagarDetalhe.Valor := ValorAbatido;
  ContasPagarDetalhe.Data := now;
  ContasPagarDetalhe.Usuario := ModuleUsuarios.GetUsuarioLogado.Id;

  try
	 ModuleContasPagar.BaixarContaPagar(ContasPagarDetalhe);
	 Application.MessageBox('Documento Baixado com sucesso','Mensagem',MB_ICONINFORMATION + MB_OK);
	 ModalResult := mrOK;
  except on E: Exception do 
	 Application.MessageBox(PWideChar(E.Message),'Erro na exibição contate o suporte',MB_ICONWARNING + MB_OK)

  end;
  
 
 finally
	 ContasPagarDetalhe.Free;
 end;
 
end;

procedure TfrmContasPagarBaixar.edtValorExit(Sender: TObject);
begin
 edtValor.Text:= TUtilitarios.FormatoValor(edtValor.Text)
end;

procedure TfrmContasPagarBaixar.FormCreate(Sender: TObject);
begin
edtValor.OnKeyPress := TUtilitarios.KeyPressValor;
end;

end.
