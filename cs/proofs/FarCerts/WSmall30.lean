import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w232 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 0), (1, 2, 0, false, 1)] }
def m_w232_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w232_never_halts : ¬ Halts m_w232 := never_halts m_w232 m_w232_cert (by decide +kernel)

def m_w233 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w233_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w233_never_halts : ¬ Halts m_w233 := never_halts m_w233 m_w233_cert (by decide +kernel)

def m_w234 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 1), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w234_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [2, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w234_never_halts : ¬ Halts m_w234 := never_halts m_w234 m_w234_cert (by decide +kernel)

def m_w235 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w235_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 2, 5], [5, 5, 1, 5, 5, 3, 6, 2, 5], [6, 2, 5, 5, 5, 5, 5, 5, 5], [5, 2, 5, 5, 5, 5, 5, 5, 5], [6, 3, 5, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w235_never_halts : ¬ Halts m_w235 := never_halts m_w235 m_w235_cert (by decide +kernel)

def m_w236 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 1), (0, 2, 0, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w236_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2, 4], [5, 5, 1, 4, 4, 3, 2, 2, 4], [6, 2, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [1, 1, 4, 3, 2, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1, 4, 5],
  rel := [(0, 0), (0, 1), (0, 4), (0, 5), (1, 0), (1, 1), (1, 4), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w236_never_halts : ¬ Halts m_w236 := never_halts m_w236 m_w236_cert (by decide +kernel)

def m_w237 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w237_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w237_never_halts : ¬ Halts m_w237 := never_halts m_w237 m_w237_cert (by decide +kernel)

def m_w238 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w238_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w238_never_halts : ¬ Halts m_w238 := never_halts m_w238 m_w238_cert (by decide +kernel)

def m_w239 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 0)] }
def m_w239_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [2, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w239_never_halts : ¬ Halts m_w239 := never_halts m_w239 m_w239_cert (by decide +kernel)

def wSmall30 : List Machine := [m_w232, m_w233, m_w234, m_w235, m_w236, m_w237, m_w238, m_w239]
theorem wSmall30_never_halt : ∀ x ∈ wSmall30, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w232_never_halts, List.forall_mem_cons.2 ⟨m_w233_never_halts, List.forall_mem_cons.2 ⟨m_w234_never_halts, List.forall_mem_cons.2 ⟨m_w235_never_halts, List.forall_mem_cons.2 ⟨m_w236_never_halts, List.forall_mem_cons.2 ⟨m_w237_never_halts, List.forall_mem_cons.2 ⟨m_w238_never_halts, List.forall_mem_cons.2 ⟨m_w239_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
