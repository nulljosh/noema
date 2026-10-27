import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w304 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w304_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 2, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 2, 2, 4, 4, 4, 4, 4, 4], [3, 2, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w304_never_halts : ¬ Halts m_w304 := never_halts m_w304 m_w304_cert (by decide +kernel)

def m_w305 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w305_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 6, 3, 1, 1, 1, 1, 1, 1], [7, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w305_never_halts : ¬ Halts m_w305 := never_halts m_w305 m_w305_cert (by decide +kernel)

def m_w306 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 0, true, 1)] }
def m_w306_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w306_never_halts : ¬ Halts m_w306 := never_halts m_w306 m_w306_cert (by decide +kernel)

def m_w307 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 2, true, 1)] }
def m_w307_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 5, 4], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 5, 4, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 5, 4, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w307_never_halts : ¬ Halts m_w307 := never_halts m_w307 m_w307_cert (by decide +kernel)

def m_w308 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w308_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [7, 6, 1, 1, 1, 1, 1, 1, 1], [7, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w308_never_halts : ¬ Halts m_w308 := never_halts m_w308 m_w308_cert (by decide +kernel)

def m_w309 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w309_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 2, 4], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 2, 4, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 4, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w309_never_halts : ¬ Halts m_w309 := never_halts m_w309 m_w309_cert (by decide +kernel)

def m_w310 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 0, false, 0)] }
def m_w310_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 2, 4], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 2, 4, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 2, 4, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w310_never_halts : ¬ Halts m_w310 := never_halts m_w310 m_w310_cert (by decide +kernel)

def m_w311 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w311_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w311_never_halts : ¬ Halts m_w311 := never_halts m_w311 m_w311_cert (by decide +kernel)

def wSmall39 : List Machine := [m_w304, m_w305, m_w306, m_w307, m_w308, m_w309, m_w310, m_w311]
theorem wSmall39_never_halt : ∀ x ∈ wSmall39, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w304_never_halts, List.forall_mem_cons.2 ⟨m_w305_never_halts, List.forall_mem_cons.2 ⟨m_w306_never_halts, List.forall_mem_cons.2 ⟨m_w307_never_halts, List.forall_mem_cons.2 ⟨m_w308_never_halts, List.forall_mem_cons.2 ⟨m_w309_never_halts, List.forall_mem_cons.2 ⟨m_w310_never_halts, List.forall_mem_cons.2 ⟨m_w311_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
