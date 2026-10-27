import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w320 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w320_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 2, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 2, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 2, 2, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w320_never_halts : ¬ Halts m_w320 := never_halts m_w320 m_w320_cert (by decide +kernel)

def m_w321 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w321_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 4, 1, 1, 1, 1, 1, 1], [1, 4, 4, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [6, 4, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w321_never_halts : ¬ Halts m_w321 := never_halts m_w321 m_w321_cert (by decide +kernel)

def m_w322 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w322_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 5, 2, 4, 4, 4, 4, 4, 4], [4, 5, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w322_never_halts : ¬ Halts m_w322 := never_halts m_w322 m_w322_cert (by decide +kernel)

def m_w323 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w323_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 2, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 2, 2, 4, 4, 4, 4, 4, 4], [4, 2, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w323_never_halts : ¬ Halts m_w323 := never_halts m_w323 m_w323_cert (by decide +kernel)

def m_w324 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w324_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 2, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 2, 2, 4, 4, 4, 4, 4, 4], [3, 2, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w324_never_halts : ¬ Halts m_w324 := never_halts m_w324 m_w324_cert (by decide +kernel)

def m_w325 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, true, 1)] }
def m_w325_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 3, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w325_never_halts : ¬ Halts m_w325 := never_halts m_w325 m_w325_cert (by decide +kernel)

def m_w326 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 1)] }
def m_w326_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 3], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 5, 3, 4, 4, 4, 4, 4, 4], [4, 5, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w326_never_halts : ¬ Halts m_w326 := never_halts m_w326 m_w326_cert (by decide +kernel)

def m_w327 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w327_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w327_never_halts : ¬ Halts m_w327 := never_halts m_w327 m_w327_cert (by decide +kernel)

def wSmall41 : List Machine := [m_w320, m_w321, m_w322, m_w323, m_w324, m_w325, m_w326, m_w327]
theorem wSmall41_never_halt : ∀ x ∈ wSmall41, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w320_never_halts, List.forall_mem_cons.2 ⟨m_w321_never_halts, List.forall_mem_cons.2 ⟨m_w322_never_halts, List.forall_mem_cons.2 ⟨m_w323_never_halts, List.forall_mem_cons.2 ⟨m_w324_never_halts, List.forall_mem_cons.2 ⟨m_w325_never_halts, List.forall_mem_cons.2 ⟨m_w326_never_halts, List.forall_mem_cons.2 ⟨m_w327_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
