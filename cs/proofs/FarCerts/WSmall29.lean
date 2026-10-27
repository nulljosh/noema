import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w224 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 0), (1, 2, 1, true, 1)] }
def m_w224_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w224_never_halts : ¬ Halts m_w224 := never_halts m_w224 m_w224_cert (by decide +kernel)

def m_w225 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, false, 0), (1, 2, 1, true, 1)] }
def m_w225_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w225_never_halts : ¬ Halts m_w225 := never_halts m_w225 m_w225_cert (by decide +kernel)

def m_w226 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w226_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w226_never_halts : ¬ Halts m_w226 := never_halts m_w226 m_w226_cert (by decide +kernel)

def m_w227 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 1, false, 0), (1, 2, 1, true, 0)] }
def m_w227_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 5, 5], [5, 0, 5, 5, 4, 5, 6, 5, 3], [6, 5, 3, 5, 5, 5, 5, 5, 5], [6, 6, 4, 5, 5, 5, 5, 5, 5], [5, 5, 3, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w227_never_halts : ¬ Halts m_w227 := never_halts m_w227 m_w227_cert (by decide +kernel)

def m_w228 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 1, true, 0)] }
def m_w228_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 5, 5], [0, 1, 0, 2, 6, 6, 7, 5, 3], [7, 5, 3, 5, 5, 5, 5, 5, 5], [5, 7, 6, 5, 5, 5, 5, 5, 5], [5, 5, 3, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [7, 7, 6, 5, 5, 5, 5, 5, 5], [7, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 7), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 5), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w228_never_halts : ¬ Halts m_w228 := never_halts m_w228 m_w228_cert (by decide +kernel)

def m_w229 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w229_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w229_never_halts : ¬ Halts m_w229 := never_halts m_w229 m_w229_cert (by decide +kernel)

def m_w230 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w230_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w230_never_halts : ¬ Halts m_w230 := never_halts m_w230 m_w230_cert (by decide +kernel)

def m_w231 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w231_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w231_never_halts : ¬ Halts m_w231 := never_halts m_w231 m_w231_cert (by decide +kernel)

def wSmall29 : List Machine := [m_w224, m_w225, m_w226, m_w227, m_w228, m_w229, m_w230, m_w231]
theorem wSmall29_never_halt : ∀ x ∈ wSmall29, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w224_never_halts, List.forall_mem_cons.2 ⟨m_w225_never_halts, List.forall_mem_cons.2 ⟨m_w226_never_halts, List.forall_mem_cons.2 ⟨m_w227_never_halts, List.forall_mem_cons.2 ⟨m_w228_never_halts, List.forall_mem_cons.2 ⟨m_w229_never_halts, List.forall_mem_cons.2 ⟨m_w230_never_halts, List.forall_mem_cons.2 ⟨m_w231_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
