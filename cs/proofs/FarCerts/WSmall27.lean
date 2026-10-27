import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w208 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 2, true, 1), (1, 0, 1, false, 1), (1, 1, 2, true, 1), (1, 2, 0, false, 0)] }
def m_w208_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 5, 6], [1, 3, 3, 3, 3, 3, 5, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [6, 3, 3, 3, 3, 3, 3, 3, 3], [7, 5, 3, 3, 3, 3, 3, 3, 3], [3, 5, 3, 3, 3, 3, 3, 3, 3], [7, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 3), (7, 7)],
  z := [0], z2 := [2, 5, 7] }
theorem m_w208_never_halts : ¬ Halts m_w208 := never_halts m_w208 m_w208_cert (by decide +kernel)

def m_w209 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 2, true, 0)] }
def m_w209_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 6], [1, 0, 1, 5, 5, 4, 6, 7, 6], [2, 4, 6, 6, 6, 6, 6, 6, 6], [3, 4, 6, 6, 6, 6, 6, 6, 6], [5, 4, 6, 6, 6, 6, 6, 6, 6], [5, 5, 6, 6, 6, 6, 6, 6, 6], [6, 6, 6, 6, 6, 6, 6, 6, 6], [6, 5, 6, 6, 6, 6, 6, 6, 6]],
  acc := [true, true, false, true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [6], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 6), (1, 0), (1, 1), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (3, 6), (4, 0), (4, 1), (4, 3), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 6), (7, 7)],
  z := [0], z2 := [2] }
theorem m_w209_never_halts : ¬ Halts m_w209 := never_halts m_w209 m_w209_cert (by decide +kernel)

def m_w210 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w210_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [1, 1, 5, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [6, 4, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w210_never_halts : ¬ Halts m_w210 := never_halts m_w210 m_w210_cert (by decide +kernel)

def m_w211 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 0), (1, 0, 1, false, 1), (1, 1, 2, false, 0), (1, 2, 0, true, 1)] }
def m_w211_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 1, 4, 1, 1, 1, 1, 1, 1], [3, 1, 4, 1, 1, 1, 1, 1, 1], [2, 4, 4, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w211_never_halts : ¬ Halts m_w211 := never_halts m_w211 m_w211_cert (by decide +kernel)

def m_w212 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, true, 0), (1, 2, 1, true, 1)] }
def m_w212_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 3, 1, 1, 1, 1, 1, 1], [5, 4, 3, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w212_never_halts : ¬ Halts m_w212 := never_halts m_w212 m_w212_cert (by decide +kernel)

def m_w213 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, true, 0), (1, 2, 0, false, 1)] }
def m_w213_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 2, 2, 5, 2], [0, 1, 2, 6, 6, 2, 7, 5, 6], [2, 2, 2, 2, 2, 2, 2, 2, 2], [7, 2, 4, 2, 2, 2, 2, 2, 2], [2, 2, 6, 2, 2, 2, 2, 2, 2], [6, 7, 2, 2, 2, 2, 2, 2, 2], [7, 2, 6, 2, 2, 2, 2, 2, 2], [7, 2, 2, 2, 2, 2, 2, 2, 2]],
  acc := [true, true, true, false, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [2], reachTape := [0, 1, 2],
  rel := [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 7), (4, 0), (4, 1), (4, 2), (4, 4), (5, 0), (5, 1), (5, 2), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 6), (6, 7), (7, 0), (7, 1), (7, 2), (7, 7)],
  z := [0], z2 := [3, 7] }
theorem m_w213_never_halts : ¬ Halts m_w213 := never_halts m_w213 m_w213_cert (by decide +kernel)

def m_w214 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 1, false, 0)] }
def m_w214_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 5, 6], [1, 0, 1, 2, 4, 3, 6, 5, 6], [7, 5, 6, 6, 6, 6, 6, 6, 6], [6, 5, 6, 6, 6, 6, 6, 6, 6], [7, 4, 6, 6, 6, 6, 6, 6, 6], [6, 4, 6, 6, 6, 6, 6, 6, 6], [6, 6, 6, 6, 6, 6, 6, 6, 6], [7, 6, 6, 6, 6, 6, 6, 6, 6]],
  acc := [true, true, false, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [6], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 6), (1, 0), (1, 1), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 6), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 6), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w214_never_halts : ¬ Halts m_w214 := never_halts m_w214 m_w214_cert (by decide +kernel)

def m_w215 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, false, 0), (1, 2, 1, true, 1)] }
def m_w215_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w215_never_halts : ¬ Halts m_w215 := never_halts m_w215 m_w215_cert (by decide +kernel)

def wSmall27 : List Machine := [m_w208, m_w209, m_w210, m_w211, m_w212, m_w213, m_w214, m_w215]
theorem wSmall27_never_halt : ∀ x ∈ wSmall27, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w208_never_halts, List.forall_mem_cons.2 ⟨m_w209_never_halts, List.forall_mem_cons.2 ⟨m_w210_never_halts, List.forall_mem_cons.2 ⟨m_w211_never_halts, List.forall_mem_cons.2 ⟨m_w212_never_halts, List.forall_mem_cons.2 ⟨m_w213_never_halts, List.forall_mem_cons.2 ⟨m_w214_never_halts, List.forall_mem_cons.2 ⟨m_w215_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
