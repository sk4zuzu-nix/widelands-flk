{
  description = "A flake for Widelands";

  inputs.nixpkgs.url = "git+file:./nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "widelands_sk4zuzu";
        version = "v1.2";

        src = fetchFromGitHub {
          owner = "widelands";
          repo = "widelands";
          rev = version;
          sha256 = "sha256-V7eappIMEQMNbf9EGQhv71Fwz0wH679ifi/qAHWwMNU=";
        };

        preConfigure = ''
          cmakeFlags="-DWL_INSTALL_BASEDIR=$out"
        '';

        nativeBuildInputs = [ cmake curl gettext python3 ];

        buildInputs = [
          SDL2 SDL2_image SDL2_mixer SDL2_net SDL2_ttf
          asio
          boost
          doxygen
          libpng lua
          glew
          icu
          zlib
        ];
      };
  };
}
