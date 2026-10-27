import FarCerts.Halt

set_option maxRecDepth 100000

namespace FAR

def halts17 : List (Machine × Nat) := [
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 2), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 2), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 10),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 8),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 9),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 2), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 1), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 11),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 0, true, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 9),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 0)] }, 6),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 0), (2, 1, 1, true, 2)] }, 8),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2)] }, 2),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (2, 0, 1, true, 1)] }, 4),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }, 6),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }, 16),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, false, 0), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 0, false, 0), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (2, 0, 1, true, 1), (2, 1, 1, false, 0)] }, 6),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, true, 1), (2, 1, 1, false, 0)] }, 10),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, true, 1), (2, 1, 1, false, 0)] }, 12),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (2, 0, 1, false, 0)] }, 4),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 6),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 10),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 9),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 2), (2, 0, 1, false, 0)] }, 7),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 1), (2, 0, 1, false, 0)] }, 6),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 1), (2, 0, 1, false, 0), (2, 1, 1, true, 2)] }, 8),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 1), (2, 0, 1, false, 0), (2, 1, 1, true, 0)] }, 10),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, false, 0)] }, 8),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, true, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, false, 0)] }, 9),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, false, 0)] }, 13),
  ({ S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 2), (1, 0, 0, false, 2), (1, 1, 1, true, 0), (2, 0, 1, false, 0)] }, 9)
]

theorem halts17_halt : ∀ x ∈ halts17, Halts x.1 := all_halt halts17 (by decide +kernel)

end FAR
