import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w144 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 1), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w144_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [1, 1, 5, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w144_never_halts : ¬ Halts m_w144 := never_halts m_w144 m_w144_cert (by decide +kernel)

def m_w145 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w145_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [1, 1, 5, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w145_never_halts : ¬ Halts m_w145 := never_halts m_w145 m_w145_cert (by decide +kernel)

def m_w146 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (1, 0, 2, false, 1), (1, 1, 2, false, 0), (1, 2, 0, true, 1)] }
def m_w146_cert : Cert := {
  delta := [[0, 1, 1, 2, 3, 3, 4, 5, 4], [1, 3, 1, 3, 3, 3, 4, 3, 4], [6, 3, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [6, 3, 4, 3, 3, 3, 3, 3, 3], [3, 3, 4, 3, 3, 3, 3, 3, 3], [6, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w146_never_halts : ¬ Halts m_w146 := never_halts m_w146 m_w146_cert (by decide +kernel)

def m_w147 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 0, true, 1), (1, 0, 2, false, 1), (1, 1, 2, false, 0), (1, 2, 0, true, 0)] }
def m_w147_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 4, 5, 4], [6, 3, 1, 3, 3, 3, 2, 3, 5], [7, 3, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [7, 3, 4, 3, 3, 3, 3, 3, 3], [3, 3, 2, 3, 3, 3, 3, 3, 3], [1, 3, 3, 3, 3, 2, 5, 3, 3], [7, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [3], reachTape := [0, 1, 3, 6],
  rel := [(0, 0), (0, 1), (0, 3), (0, 6), (1, 0), (1, 1), (1, 3), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 6), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 3), (7, 6), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w147_never_halts : ¬ Halts m_w147 := never_halts m_w147 m_w147_cert (by decide +kernel)

def m_w148 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 1, true, 1), (1, 2, 2, false, 0)] }
def m_w148_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w148_never_halts : ¬ Halts m_w148 := never_halts m_w148 m_w148_cert (by decide +kernel)

def m_w149 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w149_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [6, 5, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w149_never_halts : ¬ Halts m_w149 := never_halts m_w149 m_w149_cert (by decide +kernel)

def m_w150 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (1, 0, 2, false, 1), (1, 1, 1, true, 1), (1, 2, 0, true, 1)] }
def m_w150_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 3], [1, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 2, 3, 2, 2, 2, 2, 2, 2], [2, 2, 3, 2, 2, 2, 2, 2, 2]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (4, 0), (4, 2), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w150_never_halts : ¬ Halts m_w150 := never_halts m_w150 m_w150_cert (by decide +kernel)

def m_w151 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 1, true, 1), (1, 2, 0, false, 0)] }
def m_w151_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 4, 6] }
theorem m_w151_never_halts : ¬ Halts m_w151 := never_halts m_w151 m_w151_cert (by decide +kernel)

def wSmall19 : List Machine := [m_w144, m_w145, m_w146, m_w147, m_w148, m_w149, m_w150, m_w151]
theorem wSmall19_never_halt : ∀ x ∈ wSmall19, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w144_never_halts, List.forall_mem_cons.2 ⟨m_w145_never_halts, List.forall_mem_cons.2 ⟨m_w146_never_halts, List.forall_mem_cons.2 ⟨m_w147_never_halts, List.forall_mem_cons.2 ⟨m_w148_never_halts, List.forall_mem_cons.2 ⟨m_w149_never_halts, List.forall_mem_cons.2 ⟨m_w150_never_halts, List.forall_mem_cons.2 ⟨m_w151_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
