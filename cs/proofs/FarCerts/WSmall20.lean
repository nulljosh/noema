import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w152 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 2, true, 1), (1, 0, 2, false, 1), (1, 1, 1, true, 0), (1, 2, 0, true, 1)] }
def m_w152_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 3, 3, 4, 3], [1, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 2, 3, 2, 2, 2, 2, 2, 2], [2, 2, 3, 2, 2, 2, 2, 2, 2]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (4, 0), (4, 2), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w152_never_halts : ¬ Halts m_w152 := never_halts m_w152 m_w152_cert (by decide +kernel)

def m_w153 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 0, true, 1), (1, 0, 2, false, 1), (1, 1, 1, true, 0), (1, 2, 0, true, 1)] }
def m_w153_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 3, 3, 4, 3], [1, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 2, 3, 2, 2, 2, 2, 2, 2], [2, 2, 3, 2, 2, 2, 2, 2, 2]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (4, 0), (4, 2), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w153_never_halts : ¬ Halts m_w153 := never_halts m_w153 m_w153_cert (by decide +kernel)

def m_w154 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 1, false, 0)] }
def m_w154_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 5, 6], [1, 0, 1, 2, 5, 5, 6, 7, 6], [8, 5, 6, 6, 6, 6, 6, 6, 6], [6, 5, 6, 6, 6, 6, 6, 6, 6], [8, 6, 4, 6, 6, 6, 6, 6, 6], [8, 5, 4, 6, 6, 6, 6, 6, 6], [6, 6, 6, 6, 6, 6, 6, 6, 6], [6, 6, 4, 6, 6, 6, 6, 6, 6], [8, 6, 6, 6, 6, 6, 6, 6, 6]],
  acc := [true, true, false, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [6], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 6), (1, 0), (1, 1), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (2, 8), (3, 0), (3, 1), (3, 3), (3, 6), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (4, 8), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 6), (7, 7), (8, 0), (8, 1), (8, 6), (8, 8)],
  z := [0], z2 := [2, 8] }
theorem m_w154_never_halts : ¬ Halts m_w154 := never_halts m_w154 m_w154_cert (by decide +kernel)

def m_w155 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 1, false, 0), (1, 2, 1, true, 1)] }
def m_w155_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w155_never_halts : ¬ Halts m_w155 := never_halts m_w155 m_w155_cert (by decide +kernel)

def m_w156 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w156_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w156_never_halts : ¬ Halts m_w156 := never_halts m_w156 m_w156_cert (by decide +kernel)

def m_w157 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w157_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w157_never_halts : ¬ Halts m_w157 := never_halts m_w157 m_w157_cert (by decide +kernel)

def m_w158 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 0, true, 0), (1, 2, 0, true, 1)] }
def m_w158_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 2, 4, 2], [0, 1, 1, 4, 3, 3, 2, 4, 2], [5, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w158_never_halts : ¬ Halts m_w158 := never_halts m_w158 m_w158_cert (by decide +kernel)

def m_w159 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w159_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w159_never_halts : ¬ Halts m_w159 := never_halts m_w159 m_w159_cert (by decide +kernel)

def wSmall20 : List Machine := [m_w152, m_w153, m_w154, m_w155, m_w156, m_w157, m_w158, m_w159]
theorem wSmall20_never_halt : ∀ x ∈ wSmall20, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w152_never_halts, List.forall_mem_cons.2 ⟨m_w153_never_halts, List.forall_mem_cons.2 ⟨m_w154_never_halts, List.forall_mem_cons.2 ⟨m_w155_never_halts, List.forall_mem_cons.2 ⟨m_w156_never_halts, List.forall_mem_cons.2 ⟨m_w157_never_halts, List.forall_mem_cons.2 ⟨m_w158_never_halts, List.forall_mem_cons.2 ⟨m_w159_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
