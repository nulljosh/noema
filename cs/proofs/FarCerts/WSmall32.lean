import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w248 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 1), (1, 1, 1, false, 0)] }
def m_w248_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 5, 6], [1, 0, 1, 2, 5, 3, 6, 7, 6], [4, 5, 6, 6, 6, 6, 6, 6, 6], [6, 5, 6, 6, 6, 6, 6, 6, 6], [4, 6, 6, 6, 6, 6, 6, 6, 6], [4, 5, 6, 6, 6, 6, 6, 6, 6], [6, 6, 6, 6, 6, 6, 6, 6, 6], [4, 6, 6, 6, 6, 6, 6, 6, 6]],
  acc := [true, true, false, true, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [6], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 6), (1, 0), (1, 1), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 6), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 6), (7, 7)],
  z := [0], z2 := [2, 4] }
theorem m_w248_never_halts : ¬ Halts m_w248 := never_halts m_w248 m_w248_cert (by decide +kernel)

def m_w249 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 1), (1, 1, 1, false, 0), (1, 2, 1, true, 1)] }
def m_w249_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w249_never_halts : ¬ Halts m_w249 := never_halts m_w249 m_w249_cert (by decide +kernel)

def m_w250 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 1), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w250_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w250_never_halts : ¬ Halts m_w250 := never_halts m_w250 m_w250_cert (by decide +kernel)

def m_w251 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w251_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w251_never_halts : ¬ Halts m_w251 := never_halts m_w251 m_w251_cert (by decide +kernel)

def m_w252 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w252_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w252_never_halts : ¬ Halts m_w252 := never_halts m_w252 m_w252_cert (by decide +kernel)

def m_w253 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w253_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w253_never_halts : ¬ Halts m_w253 := never_halts m_w253 m_w253_cert (by decide +kernel)

def m_w254 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w254_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w254_never_halts : ¬ Halts m_w254 := never_halts m_w254 m_w254_cert (by decide +kernel)

def m_w255 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 0)] }
def m_w255_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w255_never_halts : ¬ Halts m_w255 := never_halts m_w255 m_w255_cert (by decide +kernel)

def wSmall32 : List Machine := [m_w248, m_w249, m_w250, m_w251, m_w252, m_w253, m_w254, m_w255]
theorem wSmall32_never_halt : ∀ x ∈ wSmall32, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w248_never_halts, List.forall_mem_cons.2 ⟨m_w249_never_halts, List.forall_mem_cons.2 ⟨m_w250_never_halts, List.forall_mem_cons.2 ⟨m_w251_never_halts, List.forall_mem_cons.2 ⟨m_w252_never_halts, List.forall_mem_cons.2 ⟨m_w253_never_halts, List.forall_mem_cons.2 ⟨m_w254_never_halts, List.forall_mem_cons.2 ⟨m_w255_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
