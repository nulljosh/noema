import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w288 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 0), (1, 1, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w288_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 4, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [7, 1, 3, 1, 1, 1, 1, 1, 1], [1, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 7), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 4, 7] }
theorem m_w288_never_halts : ¬ Halts m_w288 := never_halts m_w288 m_w288_cert (by decide +kernel)

def m_w289 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w289_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 4, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w289_never_halts : ¬ Halts m_w289 := never_halts m_w289 m_w289_cert (by decide +kernel)

def m_w290 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w290_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [7, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 6, 1, 1, 1, 1, 1, 1], [7, 3, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w290_never_halts : ¬ Halts m_w290 := never_halts m_w290 m_w290_cert (by decide +kernel)

def m_w291 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 1, true, 1)] }
def m_w291_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w291_never_halts : ¬ Halts m_w291 := never_halts m_w291 m_w291_cert (by decide +kernel)

def m_w292 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w292_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [7, 1, 5, 1, 1, 1, 1, 1, 1], [1, 3, 6, 1, 1, 1, 1, 1, 1], [7, 3, 6, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w292_never_halts : ¬ Halts m_w292 := never_halts m_w292 m_w292_cert (by decide +kernel)

def m_w293 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w293_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 3, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 3, 2, 4, 4, 4, 4, 4, 4], [4, 3, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w293_never_halts : ¬ Halts m_w293 := never_halts m_w293 m_w293_cert (by decide +kernel)

def m_w294 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 1)] }
def m_w294_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 3, 5], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 3, 5, 4, 4, 4, 4, 4, 4], [4, 3, 5, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w294_never_halts : ¬ Halts m_w294 := never_halts m_w294 m_w294_cert (by decide +kernel)

def m_w295 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w295_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 3, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 3, 2, 4, 4, 4, 4, 4, 4], [3, 3, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w295_never_halts : ¬ Halts m_w295 := never_halts m_w295 m_w295_cert (by decide +kernel)

def wSmall37 : List Machine := [m_w288, m_w289, m_w290, m_w291, m_w292, m_w293, m_w294, m_w295]
theorem wSmall37_never_halt : ∀ x ∈ wSmall37, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w288_never_halts, List.forall_mem_cons.2 ⟨m_w289_never_halts, List.forall_mem_cons.2 ⟨m_w290_never_halts, List.forall_mem_cons.2 ⟨m_w291_never_halts, List.forall_mem_cons.2 ⟨m_w292_never_halts, List.forall_mem_cons.2 ⟨m_w293_never_halts, List.forall_mem_cons.2 ⟨m_w294_never_halts, List.forall_mem_cons.2 ⟨m_w295_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
