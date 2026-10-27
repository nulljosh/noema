import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w48 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 0, false, 1), (1, 2, 1, true, 0)] }
def m_w48_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 3, 3, 4], [1, 1, 3, 3, 3, 3, 2, 2, 3], [2, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [2, 2, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w48_never_halts : ¬ Halts m_w48 := never_halts m_w48 m_w48_cert (by decide +kernel)

def m_w49 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 1), (1, 1, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w49_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 6], [1, 4, 4, 4, 4, 4, 5, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4], [5, 5, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [7, 5, 4, 4, 4, 4, 4, 4, 4], [4, 5, 4, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 7)],
  z := [0], z2 := [2, 5, 7] }
theorem m_w49_never_halts : ¬ Halts m_w49 := never_halts m_w49 m_w49_cert (by decide +kernel)

def m_w50 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 1), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w50_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w50_never_halts : ¬ Halts m_w50 := never_halts m_w50 m_w50_cert (by decide +kernel)

def m_w51 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w51_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w51_never_halts : ¬ Halts m_w51 := never_halts m_w51 m_w51_cert (by decide +kernel)

def m_w52 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 1), (1, 1, 1, true, 0), (1, 2, 1, false, 0)] }
def m_w52_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 5], [1, 0, 3, 3, 6, 3, 2, 2, 3], [2, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [2, 4, 3, 3, 3, 3, 3, 3, 3], [6, 2, 3, 3, 3, 3, 3, 3, 3], [3, 5, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2] }
theorem m_w52_never_halts : ¬ Halts m_w52 := never_halts m_w52 m_w52_cert (by decide +kernel)

def m_w53 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 1, false, 0)] }
def m_w53_cert : Cert := {
  delta := [[0, 1, 1, 2, 3, 3, 4, 4, 5], [1, 1, 3, 3, 3, 3, 4, 4, 3], [6, 5, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [6, 4, 3, 3, 3, 3, 3, 3, 3], [3, 4, 3, 3, 3, 3, 3, 3, 3], [6, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w53_never_halts : ¬ Halts m_w53 := never_halts m_w53 m_w53_cert (by decide +kernel)

def m_w54 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 0), (1, 2, 1, false, 0)] }
def m_w54_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 3, 3, 5], [6, 1, 4, 4, 4, 4, 2, 5, 4], [7, 5, 4, 4, 4, 4, 4, 4, 4], [7, 3, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [1, 4, 4, 4, 2, 4, 5, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1, 4, 6],
  rel := [(0, 0), (0, 1), (0, 4), (0, 6), (1, 0), (1, 1), (1, 4), (1, 6), (2, 0), (2, 1), (2, 2), (2, 4), (2, 6), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 6), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w54_never_halts : ¬ Halts m_w54 := never_halts m_w54 m_w54_cert (by decide +kernel)

def m_w55 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w55_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w55_never_halts : ¬ Halts m_w55 := never_halts m_w55 m_w55_cert (by decide +kernel)

def wSmall7 : List Machine := [m_w48, m_w49, m_w50, m_w51, m_w52, m_w53, m_w54, m_w55]
theorem wSmall7_never_halt : ∀ x ∈ wSmall7, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w48_never_halts, List.forall_mem_cons.2 ⟨m_w49_never_halts, List.forall_mem_cons.2 ⟨m_w50_never_halts, List.forall_mem_cons.2 ⟨m_w51_never_halts, List.forall_mem_cons.2 ⟨m_w52_never_halts, List.forall_mem_cons.2 ⟨m_w53_never_halts, List.forall_mem_cons.2 ⟨m_w54_never_halts, List.forall_mem_cons.2 ⟨m_w55_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
