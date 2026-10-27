import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w8 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 0), (1, 0, 2, false, 1), (1, 1, 0, true, 1), (1, 2, 1, false, 0)] }
def m_w8_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 4, 1, 1, 1, 1, 1, 1, 1], [3, 4, 1, 1, 1, 1, 1, 1, 1], [2, 4, 4, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w8_never_halts : ¬ Halts m_w8 := never_halts m_w8 m_w8_cert (by decide +kernel)

def m_w9 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 2, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w9_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w9_never_halts : ¬ Halts m_w9 := never_halts m_w9 m_w9_cert (by decide +kernel)

def m_w10 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w10_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [2, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w10_never_halts : ¬ Halts m_w10 := never_halts m_w10 m_w10_cert (by decide +kernel)

def m_w11 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 2, false, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w11_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 3, 4, 5, 2], [5, 1, 5, 5, 3, 5, 6, 5, 2], [6, 5, 2, 5, 5, 5, 5, 5, 5], [5, 5, 2, 5, 5, 5, 5, 5, 5], [6, 5, 3, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w11_never_halts : ¬ Halts m_w11 := never_halts m_w11 m_w11_cert (by decide +kernel)

def m_w12 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 0), (0, 2, 2, false, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w12_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 2, 4, 2], [5, 1, 5, 4, 3, 4, 2, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [1, 4, 1, 3, 4, 2, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1, 4, 5],
  rel := [(0, 0), (0, 1), (0, 4), (0, 5), (1, 0), (1, 1), (1, 4), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w12_never_halts : ¬ Halts m_w12 := never_halts m_w12 m_w12_cert (by decide +kernel)

def m_w13 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w13_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 1, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 2, 1, 1, 1, 1, 1, 1], [1, 1, 2, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w13_never_halts : ¬ Halts m_w13 := never_halts m_w13 m_w13_cert (by decide +kernel)

def m_w14 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w14_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w14_never_halts : ¬ Halts m_w14 := never_halts m_w14 m_w14_cert (by decide +kernel)

def m_w15 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w15_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w15_never_halts : ¬ Halts m_w15 := never_halts m_w15 m_w15_cert (by decide +kernel)

def wSmall2 : List Machine := [m_w8, m_w9, m_w10, m_w11, m_w12, m_w13, m_w14, m_w15]
theorem wSmall2_never_halt : ∀ x ∈ wSmall2, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w8_never_halts, List.forall_mem_cons.2 ⟨m_w9_never_halts, List.forall_mem_cons.2 ⟨m_w10_never_halts, List.forall_mem_cons.2 ⟨m_w11_never_halts, List.forall_mem_cons.2 ⟨m_w12_never_halts, List.forall_mem_cons.2 ⟨m_w13_never_halts, List.forall_mem_cons.2 ⟨m_w14_never_halts, List.forall_mem_cons.2 ⟨m_w15_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
