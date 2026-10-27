import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w112 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w112_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 1, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w112_never_halts : ¬ Halts m_w112 := never_halts m_w112 m_w112_cert (by decide +kernel)

def m_w113 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w113_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w113_never_halts : ¬ Halts m_w113 := never_halts m_w113 m_w113_cert (by decide +kernel)

def m_w114 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w114_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w114_never_halts : ¬ Halts m_w114 := never_halts m_w114 m_w114_cert (by decide +kernel)

def m_w115 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w115_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w115_never_halts : ¬ Halts m_w115 := never_halts m_w115 m_w115_cert (by decide +kernel)

def m_w116 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w116_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w116_never_halts : ¬ Halts m_w116 := never_halts m_w116 m_w116_cert (by decide +kernel)

def m_w117 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w117_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 2], [1, 3, 2, 3, 3, 3, 3, 3, 3], [1, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w117_never_halts : ¬ Halts m_w117 := never_halts m_w117 m_w117_cert (by decide +kernel)

def m_w118 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w118_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 1, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w118_never_halts : ¬ Halts m_w118 := never_halts m_w118 m_w118_cert (by decide +kernel)

def m_w119 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w119_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w119_never_halts : ¬ Halts m_w119 := never_halts m_w119 m_w119_cert (by decide +kernel)

def wSmall15 : List Machine := [m_w112, m_w113, m_w114, m_w115, m_w116, m_w117, m_w118, m_w119]
theorem wSmall15_never_halt : ∀ x ∈ wSmall15, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w112_never_halts, List.forall_mem_cons.2 ⟨m_w113_never_halts, List.forall_mem_cons.2 ⟨m_w114_never_halts, List.forall_mem_cons.2 ⟨m_w115_never_halts, List.forall_mem_cons.2 ⟨m_w116_never_halts, List.forall_mem_cons.2 ⟨m_w117_never_halts, List.forall_mem_cons.2 ⟨m_w118_never_halts, List.forall_mem_cons.2 ⟨m_w119_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
