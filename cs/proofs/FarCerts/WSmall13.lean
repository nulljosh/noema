import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w96 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_w96_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w96_never_halts : ¬ Halts m_w96 := never_halts m_w96 m_w96_cert (by decide +kernel)

def m_w97 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 1), (1, 2, 2, true, 0)] }
def m_w97_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 2, 2, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 1, 1, 1, 1, 1, 1, 1], [1, 2, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w97_never_halts : ¬ Halts m_w97 := never_halts m_w97 m_w97_cert (by decide +kernel)

def m_w98 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w98_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w98_never_halts : ¬ Halts m_w98 := never_halts m_w98 m_w98_cert (by decide +kernel)

def m_w99 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w99_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w99_never_halts : ¬ Halts m_w99 := never_halts m_w99 m_w99_cert (by decide +kernel)

def m_w100 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 0, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w100_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [2, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w100_never_halts : ¬ Halts m_w100 := never_halts m_w100 m_w100_cert (by decide +kernel)

def m_w101 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 1), (0, 2, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w101_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 4, 4, 5], [0, 5, 1, 6, 5, 4, 3, 3, 5], [7, 4, 5, 5, 5, 5, 5, 5, 5], [7, 3, 5, 5, 5, 5, 5, 5, 5], [5, 3, 5, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [5, 4, 5, 5, 5, 5, 5, 5, 5], [7, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6), (7, 0), (7, 1), (7, 5), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w101_never_halts : ¬ Halts m_w101 := never_halts m_w101 m_w101_cert (by decide +kernel)

def m_w102 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w102_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w102_never_halts : ¬ Halts m_w102 := never_halts m_w102 m_w102_cert (by decide +kernel)

def m_w103 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w103_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [2, 4, 1, 1, 1, 1, 1, 1, 1], [3, 5, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w103_never_halts : ¬ Halts m_w103 := never_halts m_w103 m_w103_cert (by decide +kernel)

def wSmall13 : List Machine := [m_w96, m_w97, m_w98, m_w99, m_w100, m_w101, m_w102, m_w103]
theorem wSmall13_never_halt : ∀ x ∈ wSmall13, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w96_never_halts, List.forall_mem_cons.2 ⟨m_w97_never_halts, List.forall_mem_cons.2 ⟨m_w98_never_halts, List.forall_mem_cons.2 ⟨m_w99_never_halts, List.forall_mem_cons.2 ⟨m_w100_never_halts, List.forall_mem_cons.2 ⟨m_w101_never_halts, List.forall_mem_cons.2 ⟨m_w102_never_halts, List.forall_mem_cons.2 ⟨m_w103_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
