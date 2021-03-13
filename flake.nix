{
  description = "A flake for Widelands";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "widelands_sk4zuzu";
        version = "248b10839ae0815f9c75741bcc54478e38b1e8d7";

        src = fetchFromGitHub {
          owner = "widelands";
          repo = "widelands";
          rev = version;
          sha256 = "sha256-ElkUAZ89Zmp7eHNV2bPuOtMGhnftLJfIH6gDJJBABvw=";
        };

        preConfigure = ''
          cmakeFlags="-DWL_INSTALL_BASEDIR=$out"
        '';

        nativeBuildInputs = [ cmake curl python gettext ];

        buildInputs = [
          boost libpng zlib glew lua doxygen icu
          SDL2 SDL2_image SDL2_mixer SDL2_net SDL2_ttf
        ];
      };
  };
}
