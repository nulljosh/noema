import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w24 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 0, false, 0)] }
def m_w24_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w24_never_halts : ¬ Halts m_w24 := never_halts m_w24 m_w24_cert (by decide +kernel)

def m_w25 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 0)] }
def m_w25_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 5], [5, 5, 0, 5, 5, 3, 6, 4, 5], [6, 4, 5, 5, 5, 5, 5, 5, 5], [5, 4, 5, 5, 5, 5, 5, 5, 5], [6, 3, 6, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w25_never_halts : ¬ Halts m_w25 := never_halts m_w25 m_w25_cert (by decide +kernel)

def m_w26 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 0)] }
def m_w26_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 5], [0, 0, 1, 2, 6, 6, 7, 4, 5], [7, 4, 5, 5, 5, 5, 5, 5, 5], [5, 4, 5, 5, 5, 5, 5, 5, 5], [5, 6, 7, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [7, 6, 7, 5, 5, 5, 5, 5, 5], [7, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (2, 7), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 5), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w26_never_halts : ¬ Halts m_w26 := never_halts m_w26 m_w26_cert (by decide +kernel)

def m_w27 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w27_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w27_never_halts : ¬ Halts m_w27 := never_halts m_w27 m_w27_cert (by decide +kernel)

def m_w28 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 0)] }
def m_w28_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 4, 4], [0, 0, 1, 2, 3, 3, 5, 3, 4], [5, 3, 4, 4, 4, 4, 4, 4, 4], [5, 3, 5, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w28_never_halts : ¬ Halts m_w28 := never_halts m_w28 m_w28_cert (by decide +kernel)

def m_w29 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 0)] }
def m_w29_cert : Cert := {
  delta := [[0, 1, 1, 2, 3, 4, 5, 5, 5], [0, 0, 1, 6, 6, 3, 4, 4, 5], [4, 4, 5, 5, 5, 5, 5, 5, 5], [6, 3, 4, 5, 5, 5, 5, 5, 5], [2, 3, 4, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [3, 4, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 4] }
theorem m_w29_never_halts : ¬ Halts m_w29 := never_halts m_w29 m_w29_cert (by decide +kernel)

def m_w30 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w30_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w30_never_halts : ¬ Halts m_w30 := never_halts m_w30 m_w30_cert (by decide +kernel)

def m_w31 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 0, false, 0)] }
def m_w31_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w31_never_halts : ¬ Halts m_w31 := never_halts m_w31 m_w31_cert (by decide +kernel)

def wSmall4 : List Machine := [m_w24, m_w25, m_w26, m_w27, m_w28, m_w29, m_w30, m_w31]
theorem wSmall4_never_halt : ∀ x ∈ wSmall4, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w24_never_halts, List.forall_mem_cons.2 ⟨m_w25_never_halts, List.forall_mem_cons.2 ⟨m_w26_never_halts, List.forall_mem_cons.2 ⟨m_w27_never_halts, List.forall_mem_cons.2 ⟨m_w28_never_halts, List.forall_mem_cons.2 ⟨m_w29_never_halts, List.forall_mem_cons.2 ⟨m_w30_never_halts, List.forall_mem_cons.2 ⟨m_w31_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
