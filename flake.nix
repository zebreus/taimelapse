{
  description = "Create timelapse videos with AI upscaling";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        pkgs = import nixpkgs { inherit system; };

        name = "taimelapse";
        packages.default = (with pkgs;   stdenv.mkDerivation
          rec {
            pname = "taimelapse";
            version = "0.0.0";

            src = ./.;

            buildInputs = [
              argbash
              ffmpeg
              imagemagick
              realesrgan-ncnn-vulkan
              bc

              nixpkgs-fmt
              nil
            ];

            buildPhase = ''
              argbash $src/taimelapse.argbash -o taimelapse.sh --type bash-script
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp taimelapse.sh $out/bin/${pname}
                
              chmod a+x $out/bin/${pname}
            '';

            meta.mainProgram = "${pname}";
          });
      }
    );
}
