{
  description = "templates flake";

  outputs = {self, ...}: {
    templates = {
      flutter = {
        path = ./flakes/flutter;
        description = "Standard flutter flake";
      };
      dart = {
        path = ./flakes/dart;
        description = "Just dart";
      };
      nodejs = {
        path = ./flakes/nodejs;
        description = "Standard nodejs";
      };
      wireguard = {
        path = ./flakes/wireguard;
        description = "wireguard";
      };
      lua = {
        path = ./flakes/lua;
        description = "Just the lua language";
      };
      elixir = {
        path = ./flakes/elixir;
        description = "just elixir";
      };
      phoenix = {
        path = ./flakes/phoenix;
        description = "phoenix framework";
      };
    };
  };
}
