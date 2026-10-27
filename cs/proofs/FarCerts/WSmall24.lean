import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w184 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w184_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w184_never_halts : ¬ Halts m_w184 := never_halts m_w184 m_w184_cert (by decide +kernel)

def m_w185 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 1), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w185_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [2, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w185_never_halts : ¬ Halts m_w185 := never_halts m_w185 m_w185_cert (by decide +kernel)

def m_w186 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w186_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [7, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 6, 1, 1, 1, 1, 1, 1], [7, 3, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w186_never_halts : ¬ Halts m_w186 := never_halts m_w186 m_w186_cert (by decide +kernel)

def m_w187 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 1, true, 1)] }
def m_w187_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w187_never_halts : ¬ Halts m_w187 := never_halts m_w187 m_w187_cert (by decide +kernel)

def m_w188 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 0)] }
def m_w188_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 4, 4], [0, 1, 0, 5, 3, 5, 2, 3, 4], [2, 3, 4, 4, 4, 4, 4, 4, 4], [5, 3, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [2, 3, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2] }
theorem m_w188_never_halts : ¬ Halts m_w188 := never_halts m_w188 m_w188_cert (by decide +kernel)

def m_w189 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w189_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [7, 1, 5, 1, 1, 1, 1, 1, 1], [1, 3, 6, 1, 1, 1, 1, 1, 1], [7, 3, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w189_never_halts : ¬ Halts m_w189 := never_halts m_w189 m_w189_cert (by decide +kernel)

def m_w190 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 2, false, 0)] }
def m_w190_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w190_never_halts : ¬ Halts m_w190 := never_halts m_w190 m_w190_cert (by decide +kernel)

def m_w191 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 1)] }
def m_w191_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w191_never_halts : ¬ Halts m_w191 := never_halts m_w191 m_w191_cert (by decide +kernel)

def wSmall24 : List Machine := [m_w184, m_w185, m_w186, m_w187, m_w188, m_w189, m_w190, m_w191]
theorem wSmall24_never_halt : ∀ x ∈ wSmall24, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w184_never_halts, List.forall_mem_cons.2 ⟨m_w185_never_halts, List.forall_mem_cons.2 ⟨m_w186_never_halts, List.forall_mem_cons.2 ⟨m_w187_never_halts, List.forall_mem_cons.2 ⟨m_w188_never_halts, List.forall_mem_cons.2 ⟨m_w189_never_halts, List.forall_mem_cons.2 ⟨m_w190_never_halts, List.forall_mem_cons.2 ⟨m_w191_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
