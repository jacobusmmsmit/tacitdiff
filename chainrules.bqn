# Original code by saltysylvi
# https://saltysylvi.github.io/blog/bqn-macros.html

⟨T, _d⟩⇐

AST ← •Import "ast.bqn"

T ← {
  ⟨4, f, r⟩: { # constants
    r=⊑⟨˙⟩ ? 0;
    r=⊑⟨˜⟩ ? 2⊸× f
  };  
  ⟨5,f,r,g⟩: { # partially applied dyads
    r‿g≡⊸‿+ ? 1;
    r‿f≡⟜‿+ ? 1;
    r‿g≡⊸‿- ? ¯1;
    r‿f≡⟜‿- ? 1;
    r‿g≡⊸‿× ? f;
    r‿f≡⟜‿× ? g;
    r‿g≡⊸‿÷ ? -f÷⋆⟜2;
    r‿f≡⟜‿÷ ? 1÷g;
    r‿g≡⊸‿⋆ ? (⋆⁼f)⊸× f⊸⋆;
    r‿f≡⟜‿⋆ ?
      g=2 ? g⊸× ;
      g=1 ? 1 ;
      g×⋆⟜(g-1)
  };
  ⟨2,f,g⟩: ⟨3, T g, ×, ⟨2, T f, g⟩⟩; # 2-trains
  ⟨3,f,g,h⟩: { # 3-trains
    g=⊑⟨+⟩ ? ⟨3, T f, +, T h⟩;
    g=⊑⟨-⟩ ? ⟨3, T f, -, T h⟩;
    g=⊑⟨×⟩ ? ⟨3, ⟨3, h, ×, T f⟩, +, ⟨3, f, ×, T h⟩⟩;
    g=⊑⟨÷⟩ ? ⟨3, ⟨3, ⟨3, h, ×, T f⟩, -, ⟨3, f, ×, T h⟩⟩, ÷, ⟨2, ⋆⟜2, h⟩⟩
  };
  𝕩: { # monads
    𝕩=⊑⟨⊢⟩ ? 1;
    𝕩=⊑⟨-⟩ ? ¯1;
    𝕩=⊑⟨÷⟩ ? -1÷⋆⟜2;
    𝕩=⊑⟨⋆⟩ ? ⋆;
    # 𝕩=⊑⟨∘⟩ ? ×;
    0 # everything else presumed 0
  }𝕩
}

_d ← {T⌾AST 𝕗}