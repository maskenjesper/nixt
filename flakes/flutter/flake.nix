{
  description = "Flutter";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs-unstable,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs-unstable {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      buildToolsVersion = "34.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [buildToolsVersion];
        platformVersions = ["33" "34" "35"];
        abiVersions = ["arm64-v8a"];
      };
      androidSdk = androidComposition.androidsdk;
    in {
      devShells = with pkgs; {
        default = mkShell {
          packages = [
            fish
          ];
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          PATH = "${gst_all_1.gstreamer.dev}/bin";
          GST_PLUGIN_SYSTEM_PATH = "${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0/:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0/";
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/aapt2";
          buildInputs = [
            flutter
            androidSdk
            jdk17
            pkg-config
            gtk3

            glibc

            gst_all_1.gstreamer.dev
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
          ];

        };

      };
    });
}
