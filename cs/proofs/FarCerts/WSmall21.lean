import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w160 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w160_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w160_never_halts : ¬ Halts m_w160 := never_halts m_w160 m_w160_cert (by decide +kernel)

def m_w161 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w161_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w161_never_halts : ¬ Halts m_w161 := never_halts m_w161 m_w161_cert (by decide +kernel)

def m_w162 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 0, false, 0)] }
def m_w162_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [1, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w162_never_halts : ¬ Halts m_w162 := never_halts m_w162 m_w162_cert (by decide +kernel)

def m_w163 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1)] }
def m_w163_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 4, 4], [0, 1, 1, 2, 3, 3, 5, 2, 4], [5, 2, 4, 4, 4, 4, 4, 4, 4], [5, 3, 5, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w163_never_halts : ¬ Halts m_w163 := never_halts m_w163 m_w163_cert (by decide +kernel)

def m_w164 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 0)] }
def m_w164_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 2, 4], [0, 0, 0, 5, 5, 5, 6, 2, 4], [6, 2, 4, 4, 4, 4, 4, 4, 4], [6, 2, 6, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w164_never_halts : ¬ Halts m_w164 := never_halts m_w164 m_w164_cert (by decide +kernel)

def m_w165 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1)] }
def m_w165_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 4, 4], [0, 1, 0, 5, 6, 5, 7, 2, 4], [7, 2, 4, 4, 4, 4, 4, 4, 4], [7, 2, 7, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [4, 5, 7, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w165_never_halts : ¬ Halts m_w165 := never_halts m_w165 m_w165_cert (by decide +kernel)

def m_w166 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 0)] }
def m_w166_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 4, 4], [0, 1, 0, 2, 3, 5, 6, 2, 4], [6, 2, 4, 4, 4, 4, 4, 4, 4], [6, 2, 6, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w166_never_halts : ¬ Halts m_w166 := never_halts m_w166 m_w166_cert (by decide +kernel)

def m_w167 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, false, 0)] }
def m_w167_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 2, 4], [0, 0, 0, 5, 5, 5, 6, 2, 4], [6, 2, 4, 4, 4, 4, 4, 4, 4], [6, 2, 6, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w167_never_halts : ¬ Halts m_w167 := never_halts m_w167 m_w167_cert (by decide +kernel)

def wSmall21 : List Machine := [m_w160, m_w161, m_w162, m_w163, m_w164, m_w165, m_w166, m_w167]
theorem wSmall21_never_halt : ∀ x ∈ wSmall21, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w160_never_halts, List.forall_mem_cons.2 ⟨m_w161_never_halts, List.forall_mem_cons.2 ⟨m_w162_never_halts, List.forall_mem_cons.2 ⟨m_w163_never_halts, List.forall_mem_cons.2 ⟨m_w164_never_halts, List.forall_mem_cons.2 ⟨m_w165_never_halts, List.forall_mem_cons.2 ⟨m_w166_never_halts, List.forall_mem_cons.2 ⟨m_w167_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
