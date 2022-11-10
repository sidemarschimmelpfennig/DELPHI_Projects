program SistemaFinanceiro;

uses
  Vcl.Forms,
  SistemaFinanceiro.View.CadastroPadrao in 'SRC\VIEWS\SistemaFinanceiro.View.CadastroPadrao.pas' {frmCadastroPadrao},
  SistemaFinanceiro.View.Splash in 'SRC\VIEWS\SistemaFinanceiro.View.Splash.pas' {frmSplash},
  SistemaFinanceiro.View.FormPrincipal in 'SRC\VIEWS\SistemaFinanceiro.View.FormPrincipal.pas' {frmPrincipal},
  SistemaFinanceiro.Module.Conexao in 'SRC\MODULES\SistemaFinanceiro.Module.Conexao.pas' {ModuleConexao: TDataModule},
  SistemaFinanceiro.View.Usuarios in 'SRC\VIEWS\SistemaFinanceiro.View.Usuarios.pas' {frmUsuarios},
  SistemaFinanceiro.Module.Usuarios in 'SRC\MODULES\SistemaFinanceiro.Module.Usuarios.pas' {ModuleUsuarios: TDataModule},
  Utilitarios in 'SRC\UTILS\Utilitarios.pas',
  SistemaFinanceiro.View.Login in 'SRC\VIEWS\SistemaFinanceiro.View.Login.pas' {frmLogin},
  Utilitarios.usuarios in 'SRC\UTILS\Utilitarios.usuarios.pas',
  SistemaFinanceiro.Module.UltimoLogin in 'SRC\MODULES\SistemaFinanceiro.Module.UltimoLogin.pas' {ModuleLogin: TDataModule},
  SistemaFinanceiro.View.RedefinirSenha in 'SRC\VIEWS\SistemaFinanceiro.View.RedefinirSenha.pas' {frmRedefinirSenha},
  SistemaFinanceiro.Module.Caixa in 'SRC\MODULES\SistemaFinanceiro.Module.Caixa.pas' {ModuleCaixa: TDataModule},
  SistemaFinanceiro.View.Caixa in 'SRC\VIEWS\SistemaFinanceiro.View.Caixa.pas' {frmCaixa},
  SistemaFinanceiro.View.Caixa.Saldo in 'SRC\VIEWS\SistemaFinanceiro.View.Caixa.Saldo.pas' {frmCaixaSaldo},
  Utilitarios.Recebimento.Caixa in 'SRC\UTILS\Utilitarios.Recebimento.Caixa.pas',
  SistemaFinanceiro.Module.ContasPagar in 'SRC\MODULES\SistemaFinanceiro.Module.ContasPagar.pas' {ModuleContasPagar: TDataModule},
  SistemaFinanceiro.View.ContasPagar in 'SRC\VIEWS\SistemaFinanceiro.View.ContasPagar.pas' {frmContasPagar},
  SistemaFinanceiro.Module.ContasReceber in 'SRC\MODULES\SistemaFinanceiro.Module.ContasReceber.pas' {ModuleContasReceber: TDataModule},
  SistemaFinanceiro.View.ContasReceber in 'SRC\VIEWS\SistemaFinanceiro.View.ContasReceber.pas' {frmContasReceber},
  SistemaFinanceiro.View.ContasPagar.Baixar in 'SRC\VIEWS\SistemaFinanceiro.View.ContasPagar.Baixar.pas' {frmContasPagarBaixar},
  SistemaFinanceiro.Model.Entidades.ContasPagar in 'SRC\MODEL\SistemaFinanceiro.Model.Entidades.ContasPagar.pas',
  SistemaFinanceiro.Model.Entidades.ContasPagarDetalhe in 'SRC\MODEL\SistemaFinanceiro.Model.Entidades.ContasPagarDetalhe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TModuleConexao, ModuleConexao);
  Application.CreateForm(TModuleUsuarios, ModuleUsuarios);
  Application.CreateForm(TModuleCaixa, ModuleCaixa);
  Application.CreateForm(TModuleContasReceber, ModuleContasReceber);
  Application.CreateForm(TModuleContasPagar, ModuleContasPagar);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TModuleLogin, ModuleLogin);
  Application.CreateForm(TfrmRedefinirSenha, frmRedefinirSenha);
  Application.CreateForm(TfrmCaixa, frmCaixa);
  Application.CreateForm(TfrmCaixaSaldo, frmCaixaSaldo);
  Application.CreateForm(TfrmContasPagar, frmContasPagar);
  Application.CreateForm(TfrmContasReceber, frmContasReceber);
  Application.CreateForm(TfrmContasPagarBaixar, frmContasPagarBaixar);
  Application.Run;
end.
