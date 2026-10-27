import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w192 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 0)] }
def m_w192_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w192_never_halts : ¬ Halts m_w192 := never_halts m_w192 m_w192_cert (by decide +kernel)

def m_w193 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w193_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [6, 5, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w193_never_halts : ¬ Halts m_w193 := never_halts m_w193 m_w193_cert (by decide +kernel)

def m_w194 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w194_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 2, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 2, 4, 1, 1, 1, 1, 1, 1], [1, 2, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w194_never_halts : ¬ Halts m_w194 := never_halts m_w194 m_w194_cert (by decide +kernel)

def m_w195 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 1)] }
def m_w195_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w195_never_halts : ¬ Halts m_w195 := never_halts m_w195 m_w195_cert (by decide +kernel)

def m_w196 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 0)] }
def m_w196_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w196_never_halts : ¬ Halts m_w196 := never_halts m_w196 m_w196_cert (by decide +kernel)

def m_w197 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w197_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w197_never_halts : ¬ Halts m_w197 := never_halts m_w197 m_w197_cert (by decide +kernel)

def m_w198 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 0, false, 0)] }
def m_w198_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w198_never_halts : ¬ Halts m_w198 := never_halts m_w198 m_w198_cert (by decide +kernel)

def m_w199 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 1, 0, true, 0)] }
def m_w199_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 4, 4], [0, 1, 0, 5, 3, 5, 2, 3, 4], [2, 3, 4, 4, 4, 4, 4, 4, 4], [5, 3, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [2, 3, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2] }
theorem m_w199_never_halts : ¬ Halts m_w199 := never_halts m_w199 m_w199_cert (by decide +kernel)

def wSmall25 : List Machine := [m_w192, m_w193, m_w194, m_w195, m_w196, m_w197, m_w198, m_w199]
theorem wSmall25_never_halt : ∀ x ∈ wSmall25, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w192_never_halts, List.forall_mem_cons.2 ⟨m_w193_never_halts, List.forall_mem_cons.2 ⟨m_w194_never_halts, List.forall_mem_cons.2 ⟨m_w195_never_halts, List.forall_mem_cons.2 ⟨m_w196_never_halts, List.forall_mem_cons.2 ⟨m_w197_never_halts, List.forall_mem_cons.2 ⟨m_w198_never_halts, List.forall_mem_cons.2 ⟨m_w199_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
