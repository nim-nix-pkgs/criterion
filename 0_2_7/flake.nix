{
  description = ''Statistic-driven microbenchmark framework'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-criterion-0_2_7.flake = false;
  inputs.src-criterion-0_2_7.ref   = "refs/tags/0.2.7";
  inputs.src-criterion-0_2_7.owner = "disruptek";
  inputs.src-criterion-0_2_7.repo  = "criterion";
  inputs.src-criterion-0_2_7.type  = "github";
  
  inputs."github.com/disruptek/balls".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/balls".ref   = "master";
  inputs."github.com/disruptek/balls".repo  = "github.com/disruptek/balls";
  inputs."github.com/disruptek/balls".dir   = "";
  inputs."github.com/disruptek/balls".type  = "github";
  inputs."github.com/disruptek/balls".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/balls".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-criterion-0_2_7"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-criterion-0_2_7";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}