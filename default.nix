let
  stable =
    import
      (fetchTarball {
        # 20.03 as of 2020-05-02
        url = https://github.com/NixOS/nixpkgs-channels/archive/ab3adfe.tar.gz;
        sha256 = "1m4wvrrcvif198ssqbdw897c8h84l0cy7q75lyfzdsz9khm1y2n1";
      }) { };

  unstable =
    import
      (fetchTarball {
        # unstable as of 2020-05-02
        url = https://github.com/NixOS/nixpkgs-channels/archive/10100a9.tar.gz;
        sha256 = "011f36kr3c1ria7rag7px26bh73d1b0xpqadd149bysf4hg17rln";
      }) { };
in
{
  backofficeEnv = with stable; stdenv.mkDerivation {
    name = "backoffice";
    buildInputs = [
      ## base
      stdenv
      git
      ## erlang
      beam.packages.erlangR22.elixir_1_10 # Elixir 1.10.1
      erlangR22 # Erlang/OTP 22.1.7
      ## node
      inotifyTools
      nodejs-12_x # v12.15.0
      (yarn.override { nodejs = nodejs-12_x; }) # 1.22.0
    ];
  };
}
