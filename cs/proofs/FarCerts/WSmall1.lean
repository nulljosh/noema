import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w0 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 1), (1, 2, 2, true, 0)] }
def m_w0_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 3, 1, 1, 1, 1, 1, 1, 1], [5, 3, 4, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w0_never_halts : ¬ Halts m_w0 := never_halts m_w0 m_w0_cert (by decide +kernel)

def m_w1 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 0, false, 1), (1, 2, 2, true, 0)] }
def m_w1_cert : Cert := {
  delta := [[0, 1, 2, 3, 1, 4, 1, 1, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 1, 2, 6, 1, 6, 7, 6, 5], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 6, 1, 1, 1, 1, 1, 1, 1], [6, 1, 7, 1, 1, 1, 1, 1, 1], [7, 6, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, true, false, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1, 2],
  rel := [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 7), (4, 0), (4, 1), (4, 2), (4, 4), (5, 0), (5, 1), (5, 2), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 6), (6, 7), (7, 0), (7, 1), (7, 2), (7, 7)],
  z := [0], z2 := [3, 7] }
theorem m_w1_never_halts : ¬ Halts m_w1 := never_halts m_w1 m_w1_cert (by decide +kernel)

def m_w2 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 2, false, 1), (1, 2, 2, false, 0)] }
def m_w2_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 6], [0, 0, 0, 3, 3, 3, 7, 5, 6], [7, 5, 6, 5, 5, 5, 5, 5, 5], [5, 5, 6, 5, 5, 5, 5, 5, 5], [7, 5, 4, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [5, 5, 4, 5, 5, 5, 5, 5, 5], [7, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (2, 7), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 3), (6, 5), (6, 6), (7, 0), (7, 1), (7, 5), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w2_never_halts : ¬ Halts m_w2 := never_halts m_w2 m_w2_cert (by decide +kernel)

def m_w3 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 1), (1, 2, 2, false, 0)] }
def m_w3_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w3_never_halts : ¬ Halts m_w3 := never_halts m_w3 m_w3_cert (by decide +kernel)

def m_w4 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w4_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w4_never_halts : ¬ Halts m_w4 := never_halts m_w4 m_w4_cert (by decide +kernel)

def m_w5 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, true, 1), (1, 0, 2, false, 1), (1, 1, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w5_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 6, 5], [1, 4, 4, 4, 4, 4, 5, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [7, 4, 5, 4, 4, 4, 4, 4, 4], [4, 4, 5, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 7), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 7)],
  z := [0], z2 := [2, 5, 7] }
theorem m_w5_never_halts : ¬ Halts m_w5 := never_halts m_w5 m_w5_cert (by decide +kernel)

def m_w6 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 0, false, 0), (1, 0, 2, false, 1), (1, 2, 1, true, 0)] }
def m_w6_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 2, 4, 4, 5], [0, 0, 1, 3, 3, 6, 2, 4, 7], [2, 4, 3, 4, 4, 4, 4, 4, 4], [2, 4, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [6, 4, 3, 4, 4, 4, 4, 4, 4], [2, 4, 2, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7)],
  z := [0], z2 := [2] }
theorem m_w6_never_halts : ¬ Halts m_w6 := never_halts m_w6 m_w6_cert (by decide +kernel)

def m_w7 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w7_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [6, 5, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w7_never_halts : ¬ Halts m_w7 := never_halts m_w7 m_w7_cert (by decide +kernel)

def wSmall1 : List Machine := [m_w0, m_w1, m_w2, m_w3, m_w4, m_w5, m_w6, m_w7]
theorem wSmall1_never_halt : ∀ x ∈ wSmall1, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w0_never_halts, List.forall_mem_cons.2 ⟨m_w1_never_halts, List.forall_mem_cons.2 ⟨m_w2_never_halts, List.forall_mem_cons.2 ⟨m_w3_never_halts, List.forall_mem_cons.2 ⟨m_w4_never_halts, List.forall_mem_cons.2 ⟨m_w5_never_halts, List.forall_mem_cons.2 ⟨m_w6_never_halts, List.forall_mem_cons.2 ⟨m_w7_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
