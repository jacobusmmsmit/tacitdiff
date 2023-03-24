# Original code by saltysylvi
# https://saltysylvi.github.io/blog/bqn-macros.html

# Decompose a tacit phrase into an abstract syntax tree

AST⇐

AST ← {
     𝕊: {2>⊑𝕩 ? 1⊑𝕩; AST¨⌾(1⊸↓)𝕩} •Decompose 𝕩;
     𝕊⁼: U ← AST⁼¨ 1⊸↓
       {
         0=≡𝕩 ? 𝕩 ;
         2=⊑𝕩 ? g‿h←U𝕩 ⋄ G H;
         3=⊑𝕩 ? f‿g‿h←U𝕩 ⋄ F G H;
         4=⊑𝕩 ? f‿r←U𝕩 ⋄ F _r;
         5=⊑𝕩 ? f‿r‿g←U𝕩 ⋄ F _r_ G
       } 𝕩
   }