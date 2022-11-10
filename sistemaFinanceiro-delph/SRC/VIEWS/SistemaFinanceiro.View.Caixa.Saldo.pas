unit SistemaFinanceiro.View.Caixa.Saldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.WinXPanels, System.DateUtils;

type
  TfrmCaixaSaldo = class(TForm)
	 pnPrincipal: TPanel;
    pnTop: TPanel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    dtIncial: TDateTimePicker;
    dtFinal: TDateTimePicker;
    lblDTFim: TLabel;
    lblDTIni: TLabel;
    Panel1: TPanel;
    lblIniciaCaixa: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    lblSaida: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    lblParcial: TLabel;
    Label8: TLabel;
    Panel5: TPanel;
    lblSaldoTotal: TLabel;
    Label10: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    lblEntrada: TLabel;
    Label6: TLabel;
    StackPanel1: TStackPanel;
    procedure FormShow(Sender: TObject);
	 procedure btnPesquisarClick(Sender: TObject);
  private
	 { Private declarations }
	 procedure Pesquise;
  public
    { Public declarations }
  end;

var
  frmCaixaSaldo: TfrmCaixaSaldo;

implementation

{$R *.dfm}

uses Utilitarios.Recebimento.Caixa, SistemaFinanceiro.Module.Caixa,
  SistemaFinanceiro.Module.UltimoLogin, SistemaFinanceiro.View.Caixa,
  Utilitarios;

{ TfrmCaixaSaldo }

procedure TfrmCaixaSaldo.btnPesquisarClick(Sender: TObject);
begin
 Pesquise;

end;

procedure TfrmCaixaSaldo.FormShow(Sender: TObject);
begin
Pesquise;
dtIncial.Date := IncDay(now , -7 );
dtFinal.Date:= now;
end;

procedure TfrmCaixaSaldo.Pesquise;
var
	ResumoCaixa :  TModelResumoCaixa;
begin
	lblParcial.Caption := '' ;
	lblEntrada.Caption := '' ;
	lblSaldoTotal.Caption := '';
	lblIniciaCaixa.Caption := '';
	lblSaida.Caption := '';
	ResumoCaixa:= ModuleCaixa.ResumoCaixa(dtIncial.Date,dtFinal.Date);
	try                        
		lblParcial.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoParcial) ;
		lblEntrada.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.ValorEntradas) ;
		lblIniciaCaixa.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoInicial);
		lblSaida.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.ValorSaidas);
		lblSaldoTotal.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoFinal);
	finally
		ResumoCaixa.Free;
	end;
end;

end.
