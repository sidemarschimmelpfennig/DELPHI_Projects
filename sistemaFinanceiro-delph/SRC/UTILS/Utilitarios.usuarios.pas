unit Utilitarios.usuarios;

interface
type
EntidadeUsuarios = class
	private
	 FNome: String;
	 FLogin: string;
	 FId: string;
    Fsenha: string;
    FSenhaTemporaria: Boolean;
	 
	public
	 property Nome: String read FNome write FNome;
	 property Login: String read FLogin write FLogin;
	 property Id: string read FId write FId;
	 property senha: string read Fsenha write Fsenha;
	 property SenhaTemporaria: Boolean read FSenhaTemporaria write FSenhaTemporaria;
end;         

implementation

{ EntidadeUsuarios }



end.
