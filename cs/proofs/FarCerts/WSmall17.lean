import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w128 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 0)] }
def m_w128_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w128_never_halts : ¬ Halts m_w128 := never_halts m_w128 m_w128_cert (by decide +kernel)

def m_w129 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 0)] }
def m_w129_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w129_never_halts : ¬ Halts m_w129 := never_halts m_w129 m_w129_cert (by decide +kernel)

def m_w130 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w130_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [4, 3, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 4, 6] }
theorem m_w130_never_halts : ¬ Halts m_w130 := never_halts m_w130 m_w130_cert (by decide +kernel)

def m_w131 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w131_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w131_never_halts : ¬ Halts m_w131 := never_halts m_w131 m_w131_cert (by decide +kernel)

def m_w132 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w132_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w132_never_halts : ¬ Halts m_w132 := never_halts m_w132 m_w132_cert (by decide +kernel)

def m_w133 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w133_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w133_never_halts : ¬ Halts m_w133 := never_halts m_w133 m_w133_cert (by decide +kernel)

def m_w134 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w134_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w134_never_halts : ¬ Halts m_w134 := never_halts m_w134 m_w134_cert (by decide +kernel)

def m_w135 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 0)] }
def m_w135_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w135_never_halts : ¬ Halts m_w135 := never_halts m_w135 m_w135_cert (by decide +kernel)

def wSmall17 : List Machine := [m_w128, m_w129, m_w130, m_w131, m_w132, m_w133, m_w134, m_w135]
theorem wSmall17_never_halt : ∀ x ∈ wSmall17, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w128_never_halts, List.forall_mem_cons.2 ⟨m_w129_never_halts, List.forall_mem_cons.2 ⟨m_w130_never_halts, List.forall_mem_cons.2 ⟨m_w131_never_halts, List.forall_mem_cons.2 ⟨m_w132_never_halts, List.forall_mem_cons.2 ⟨m_w133_never_halts, List.forall_mem_cons.2 ⟨m_w134_never_halts, List.forall_mem_cons.2 ⟨m_w135_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
