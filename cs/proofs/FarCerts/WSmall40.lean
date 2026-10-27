import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w312 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w312_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 8, 1, 1, 1, 1, 1, 1, 1], [7, 5, 1, 1, 1, 1, 1, 1, 1], [1, 8, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 7), (8, 0), (8, 1), (8, 3), (8, 6), (8, 8)],
  z := [0], z2 := [2, 7] }
theorem m_w312_never_halts : ¬ Halts m_w312 := never_halts m_w312 m_w312_cert (by decide +kernel)

def m_w313 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w313_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 3, 1, 1, 1, 1, 1, 1, 1], [7, 5, 1, 1, 1, 1, 1, 1, 1], [1, 3, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w313_never_halts : ¬ Halts m_w313 := never_halts m_w313 m_w313_cert (by decide +kernel)

def m_w314 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 0, false, 0)] }
def m_w314_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [7, 3, 1, 1, 1, 1, 1, 1, 1], [4, 5, 1, 1, 1, 1, 1, 1, 1], [1, 3, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 4, 7] }
theorem m_w314_never_halts : ¬ Halts m_w314 := never_halts m_w314 m_w314_cert (by decide +kernel)

def m_w315 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w315_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 2, 3], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 3, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w315_never_halts : ¬ Halts m_w315 := never_halts m_w315 m_w315_cert (by decide +kernel)

def m_w316 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (0, 2, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w316_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2, 4], [0, 5, 1, 3, 4, 3, 2, 2, 4], [6, 2, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [1, 5, 5, 3, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 4), (0, 5), (1, 0), (1, 1), (1, 4), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w316_never_halts : ¬ Halts m_w316 := never_halts m_w316 m_w316_cert (by decide +kernel)

def m_w317 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w317_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 2, 3], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 2, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w317_never_halts : ¬ Halts m_w317 := never_halts m_w317 m_w317_cert (by decide +kernel)

def m_w318 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w318_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 5, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 5, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 5, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w318_never_halts : ¬ Halts m_w318 := never_halts m_w318 m_w318_cert (by decide +kernel)

def m_w319 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w319_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 2, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 2, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w319_never_halts : ¬ Halts m_w319 := never_halts m_w319 m_w319_cert (by decide +kernel)

def wSmall40 : List Machine := [m_w312, m_w313, m_w314, m_w315, m_w316, m_w317, m_w318, m_w319]
theorem wSmall40_never_halt : ∀ x ∈ wSmall40, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w312_never_halts, List.forall_mem_cons.2 ⟨m_w313_never_halts, List.forall_mem_cons.2 ⟨m_w314_never_halts, List.forall_mem_cons.2 ⟨m_w315_never_halts, List.forall_mem_cons.2 ⟨m_w316_never_halts, List.forall_mem_cons.2 ⟨m_w317_never_halts, List.forall_mem_cons.2 ⟨m_w318_never_halts, List.forall_mem_cons.2 ⟨m_w319_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
