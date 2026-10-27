import FarCerts.Translated

set_option maxRecDepth 100000

namespace FAR

def wTranslated35 : List (Machine × Bool × Nat × Nat × Nat) := [
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, true, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, false, 0, 9, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, false, 5, 5, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, false, 0, 9, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, true, 8, 7, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, false, 3, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, false, 0, 9, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }, true, 8, 7, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 0)] }, false, 0, 6, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, false, 1)] }, true, 2, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 0, true, 1)] }, false, 1, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 0, true, 0)] }, false, 0, 6, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 0, false, 1)] }, true, 2, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 3, 3, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, true, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 0, 7, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 2, true, 1)] }, false, 10, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 2, false, 0)] }, true, 6, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 1)] }, false, 10, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }, false, 12, 7, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }, true, 6, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, true, 0)] }, true, 6, 7, 2),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 1)] }, true, 6, 7, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 0)] }, true, 6, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, true, 1)] }, false, 3, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, true, 0)] }, false, 0, 11, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 1)] }, true, 6, 7, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 3, 3, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 0, 7, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 10, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 3, 3, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, false, 0, 7, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }, true, 6, 5, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 0)] }, false, 0, 4, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 1, false, 1)] }, true, 2, 3, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 1)] }, false, 1, 3, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }, false, 0, 4, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 0, false, 1)] }, true, 2, 3, 1),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 1)] }, false, 1, 1, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 0)] }, false, 0, 2, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 1)] }, true, 2, 1, 0),
  ({ S := 3, n := 2, rules := [(0, 0, 0, true, 0)] }, false, 0, 1, 0)
]

theorem wTranslated35_never_halt : ∀ x ∈ wTranslated35, ¬ Halts x.1 := all_tcycle wTranslated35 (by decide +kernel)

end FAR
