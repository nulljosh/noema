import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w72 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 2, 0, true, 0)] }
def m_w72_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 0, 1, 5, 5, 3, 2, 4, 3], [2, 4, 3, 4, 4, 4, 4, 4, 4], [5, 2, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [2, 4, 3, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2] }
theorem m_w72_never_halts : ¬ Halts m_w72 := never_halts m_w72 m_w72_cert (by decide +kernel)

def m_w73 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w73_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w73_never_halts : ¬ Halts m_w73 := never_halts m_w73 m_w73_cert (by decide +kernel)

def m_w74 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 2, true, 1)] }
def m_w74_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 0, 1, 5, 5, 6, 7, 4, 2], [7, 4, 2, 4, 4, 4, 4, 4, 4], [7, 7, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [4, 7, 5, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w74_never_halts : ¬ Halts m_w74 := never_halts m_w74 m_w74_cert (by decide +kernel)

def m_w75 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 2, true, 0)] }
def m_w75_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 0, 1, 2, 5, 3, 6, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [6, 6, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w75_never_halts : ¬ Halts m_w75 := never_halts m_w75 m_w75_cert (by decide +kernel)

def m_w76 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 2, false, 0)] }
def m_w76_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 2], [0, 0, 0, 5, 5, 5, 6, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [6, 6, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w76_never_halts : ¬ Halts m_w76 := never_halts m_w76 m_w76_cert (by decide +kernel)

def m_w77 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 1, true, 1)] }
def m_w77_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 1, 1, 2, 3, 3, 5, 4, 2], [5, 4, 2, 4, 4, 4, 4, 4, 4], [5, 5, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w77_never_halts : ¬ Halts m_w77 := never_halts m_w77 m_w77_cert (by decide +kernel)

def m_w78 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 1, true, 0)] }
def m_w78_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 2], [0, 0, 0, 5, 5, 5, 6, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [6, 6, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w78_never_halts : ¬ Halts m_w78 := never_halts m_w78 m_w78_cert (by decide +kernel)

def m_w79 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 0, true, 0)] }
def m_w79_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 2], [0, 0, 0, 5, 5, 5, 6, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [6, 6, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w79_never_halts : ¬ Halts m_w79 := never_halts m_w79 m_w79_cert (by decide +kernel)

def wSmall10 : List Machine := [m_w72, m_w73, m_w74, m_w75, m_w76, m_w77, m_w78, m_w79]
theorem wSmall10_never_halt : ∀ x ∈ wSmall10, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w72_never_halts, List.forall_mem_cons.2 ⟨m_w73_never_halts, List.forall_mem_cons.2 ⟨m_w74_never_halts, List.forall_mem_cons.2 ⟨m_w75_never_halts, List.forall_mem_cons.2 ⟨m_w76_never_halts, List.forall_mem_cons.2 ⟨m_w77_never_halts, List.forall_mem_cons.2 ⟨m_w78_never_halts, List.forall_mem_cons.2 ⟨m_w79_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
