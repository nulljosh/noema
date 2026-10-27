import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w280 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 2, true, 1)] }
def m_w280_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 4, 5], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 4, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 4, 5, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w280_never_halts : ¬ Halts m_w280 := never_halts m_w280 m_w280_cert (by decide +kernel)

def m_w281 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w281_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w281_never_halts : ¬ Halts m_w281 := never_halts m_w281 m_w281_cert (by decide +kernel)

def m_w282 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w282_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 4, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 4, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 4, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w282_never_halts : ¬ Halts m_w282 := never_halts m_w282 m_w282_cert (by decide +kernel)

def m_w283 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w283_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 4, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 4, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w283_never_halts : ¬ Halts m_w283 := never_halts m_w283 m_w283_cert (by decide +kernel)

def m_w284 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w284_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 3, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 3, 2, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w284_never_halts : ¬ Halts m_w284 := never_halts m_w284 m_w284_cert (by decide +kernel)

def m_w285 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w285_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w285_never_halts : ¬ Halts m_w285 := never_halts m_w285 m_w285_cert (by decide +kernel)

def m_w286 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w286_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [7, 1, 8, 1, 1, 1, 1, 1, 1], [1, 1, 8, 1, 1, 1, 1, 1, 1], [7, 1, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 6, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 7), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (7, 0), (7, 1), (7, 7), (8, 0), (8, 1), (8, 3), (8, 5), (8, 8)],
  z := [0], z2 := [2, 7] }
theorem m_w286_never_halts : ¬ Halts m_w286 := never_halts m_w286 m_w286_cert (by decide +kernel)

def m_w287 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w287_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [7, 1, 3, 1, 1, 1, 1, 1, 1], [1, 1, 3, 1, 1, 1, 1, 1, 1], [7, 1, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 7), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w287_never_halts : ¬ Halts m_w287 := never_halts m_w287 m_w287_cert (by decide +kernel)

def wSmall36 : List Machine := [m_w280, m_w281, m_w282, m_w283, m_w284, m_w285, m_w286, m_w287]
theorem wSmall36_never_halt : ∀ x ∈ wSmall36, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w280_never_halts, List.forall_mem_cons.2 ⟨m_w281_never_halts, List.forall_mem_cons.2 ⟨m_w282_never_halts, List.forall_mem_cons.2 ⟨m_w283_never_halts, List.forall_mem_cons.2 ⟨m_w284_never_halts, List.forall_mem_cons.2 ⟨m_w285_never_halts, List.forall_mem_cons.2 ⟨m_w286_never_halts, List.forall_mem_cons.2 ⟨m_w287_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
