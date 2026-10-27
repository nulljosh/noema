import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w240 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w240_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 2, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 2, 1, 1, 1, 1, 1, 1, 1], [1, 2, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w240_never_halts : ¬ Halts m_w240 := never_halts m_w240 m_w240_cert (by decide +kernel)

def m_w241 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w241_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w241_never_halts : ¬ Halts m_w241 := never_halts m_w241 m_w241_cert (by decide +kernel)

def m_w242 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w242_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [2, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w242_never_halts : ¬ Halts m_w242 := never_halts m_w242 m_w242_cert (by decide +kernel)

def m_w243 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 0), (1, 2, 1, false, 0)] }
def m_w243_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 6], [7, 7, 4, 2, 3, 4, 4, 4, 4], [8, 5, 4, 4, 4, 4, 4, 4, 4], [4, 5, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [2, 4, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [1, 1, 1, 4, 4, 4, 5, 5, 6], [8, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [4], reachTape := [0, 1, 4, 7],
  rel := [(0, 0), (0, 1), (0, 4), (0, 7), (1, 0), (1, 1), (1, 4), (1, 7), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 7), (2, 8), (3, 0), (3, 1), (3, 3), (3, 4), (3, 7), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (6, 0), (6, 1), (6, 4), (6, 6), (6, 7), (7, 0), (7, 1), (7, 4), (7, 7), (8, 0), (8, 1), (8, 4), (8, 7), (8, 8)],
  z := [0], z2 := [2, 8] }
theorem m_w243_never_halts : ¬ Halts m_w243 := never_halts m_w243 m_w243_cert (by decide +kernel)

def m_w244 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_w244_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w244_never_halts : ¬ Halts m_w244 := never_halts m_w244 m_w244_cert (by decide +kernel)

def m_w245 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 0, false, 1), (1, 0, 0, false, 1), (1, 1, 2, false, 0), (1, 2, 2, true, 0)] }
def m_w245_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 6, 5], [1, 3, 0, 3, 3, 4, 2, 3, 6], [2, 3, 6, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 6, 3, 3, 3, 3, 3, 3], [7, 3, 3, 3, 3, 3, 3, 3, 3], [2, 3, 3, 3, 3, 3, 3, 3, 3], [7, 3, 6, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 3), (6, 5), (6, 6), (7, 0), (7, 1), (7, 3), (7, 4), (7, 5), (7, 7)],
  z := [0], z2 := [2] }
theorem m_w245_never_halts : ¬ Halts m_w245 := never_halts m_w245 m_w245_cert (by decide +kernel)

def m_w246 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 1), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w246_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 6, 1, 1, 1, 1, 1, 1], [1, 1, 6, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 6, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 3), (6, 5), (6, 6)],
  z := [0], z2 := [2, 4] }
theorem m_w246_never_halts : ¬ Halts m_w246 := never_halts m_w246 m_w246_cert (by decide +kernel)

def m_w247 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 0, false, 1), (1, 1, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w247_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 2, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w247_never_halts : ¬ Halts m_w247 := never_halts m_w247 m_w247_cert (by decide +kernel)

def wSmall31 : List Machine := [m_w240, m_w241, m_w242, m_w243, m_w244, m_w245, m_w246, m_w247]
theorem wSmall31_never_halt : ∀ x ∈ wSmall31, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w240_never_halts, List.forall_mem_cons.2 ⟨m_w241_never_halts, List.forall_mem_cons.2 ⟨m_w242_never_halts, List.forall_mem_cons.2 ⟨m_w243_never_halts, List.forall_mem_cons.2 ⟨m_w244_never_halts, List.forall_mem_cons.2 ⟨m_w245_never_halts, List.forall_mem_cons.2 ⟨m_w246_never_halts, List.forall_mem_cons.2 ⟨m_w247_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
