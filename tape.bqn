ast ← •Import "ast.bqn"
⟨T, d⟩ ← •Import "chainrules.bqn"


# Construct a Wengert list (new class) from a function as an object of class Wengert list
# Traverse it forwards for primal pass as a method of Wengert list
# Traverse it backwards for backward pass as a method of Wengert list
# The Wengert list methods are
# 1. init: convert the given tacit block into a forward Wengert list and its dual, store as properties
# 2. forward: evaluate the forward list at the input
# 3. backward: evaluate the backward list in reverse

# Test whether a decomposed tacit expression needs to be decomposed further
Final ← {1=≠𝕩 ? 1 ; ¬1<⌈´≠¨𝕩}

# Take an AST and return a Wengert list (tape) where the names of intermediate
# variables are relative to their distance from the instruction in question.
RWL ← {
  𝕊 a: 1 𝕊 a;
  c 𝕊 a: Rec ← 𝕊
  {
    1: { # If final
      {
        ⟨2,f,g⟩:   ⟨⟨1, G⟩, ⟨c, F⟩⟩;
        ⟨3,f,b,g⟩: ⟨⟨1, c⟩, F B G⟩;
        ⟨4,f,r⟩:   ⟨⟨c, F _r⟩⟩;
        ⟨5,f,r,g⟩: ⟨⟨c, F _r_ G⟩⟩;
        ⟨⟨⟨1, c⟩,a⟩⟩
      } a
    };
    0: { # If not final
      ⟨2,f,g⟩: Rec g, Rec f;
      ⟨3,f,b,g⟩: {
        i←Rec g
        j←(1+≠i) Rec f
        k←(1+≠j) Rec b
        i∾j∾k
      };
      ⟨4,f,u⟩: "You hit a 4, good luck";
      ⟨5,f,r,g⟩: { # Partially applied dyads
        i←Rec g
        j←(1+≠i)Rec f
        k←(1+≠j)Rec r
        i∾j∾k
      }
    } a
  } Final a
}

# Turn a relative Wengert list into an (absolute) Wengert list
AWL ← (↕∘≠-⊢)⌾(⊑¨)

# Differentiate an entry in an AWL or RWL
Diff ← {
  𝕊 f: 2;
  args 𝕊 f: 3
}

F ← (2⊸+) + (2⊸+)
tr ← AST ⊑⟨f⟩
list ← AWL RWL tr
l← ⟨⟨1, 2⟩, ⟨1, 0⟩, ⟨1, 3⟩, 2‿2, 2‿2, 3‿3⟩

# Evaluate a given Wengert list 𝕨 at an argument 𝕩
Eval ← {
  x𝕊a: # Pop and match on tail instruction pair: ⟨argument pointer(s), operation⟩
  {
    # Base case: match on (number of) argument pointers
    ⟨¯1, f⟩: F a;
    ⟨⟨¯1, ¯1⟩, f⟩: F´⟨a, a⟩;
    # Recursive case: new instruction list goes up to where the last one points to
    ⟨ap, op⟩: x_rest ← ({𝕩⊏x}(↕1⊸+))¨ap # Note that Self isn't needed with Before (⊸) and After (⟜), which essentially have a copy built in: for example F⊸G 𝕩 is the same as F⊸G˜ 𝕩 by definition.
    {
      ⟨ap1, ap2⟩: ((⊑x_rest) Eval a) Op ((¯1⊑x_rest) Eval a);
      𝕩: x_rest Eval a
    } ap
  }¯1⊑x
}

•Show list
•Show list Eval 3
•Show RWL tr
RWL AST ⊑⟨⊢+⊢⟩


# Problems:
# - If the function doesn't emit a vector of instructions, its relative Wengert list
#   is a single instruction not a list of instructions and so AWL wengert_list won't work
# - Some functions aren't work with RWL properly