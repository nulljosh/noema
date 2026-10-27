import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w256 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w256_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w256_never_halts : ¬ Halts m_w256 := never_halts m_w256 m_w256_cert (by decide +kernel)

def m_w257 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, true, 1)] }
def m_w257_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w257_never_halts : ¬ Halts m_w257 := never_halts m_w257 m_w257_cert (by decide +kernel)

def m_w258 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w258_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w258_never_halts : ¬ Halts m_w258 := never_halts m_w258 m_w258_cert (by decide +kernel)

def m_w259 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w259_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w259_never_halts : ¬ Halts m_w259 := never_halts m_w259 m_w259_cert (by decide +kernel)

def m_w260 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w260_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w260_never_halts : ¬ Halts m_w260 := never_halts m_w260 m_w260_cert (by decide +kernel)

def m_w261 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 0, true, 1), (1, 0, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w261_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w261_never_halts : ¬ Halts m_w261 := never_halts m_w261 m_w261_cert (by decide +kernel)

def m_w262 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 0)] }
def m_w262_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w262_never_halts : ¬ Halts m_w262 := never_halts m_w262 m_w262_cert (by decide +kernel)

def m_w263 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 0, false, 0), (1, 0, 0, false, 0), (1, 2, 2, true, 0)] }
def m_w263_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 2], [1, 3, 2, 3, 3, 3, 3, 3, 3], [1, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w263_never_halts : ¬ Halts m_w263 := never_halts m_w263 m_w263_cert (by decide +kernel)

def wSmall33 : List Machine := [m_w256, m_w257, m_w258, m_w259, m_w260, m_w261, m_w262, m_w263]
theorem wSmall33_never_halt : ∀ x ∈ wSmall33, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w256_never_halts, List.forall_mem_cons.2 ⟨m_w257_never_halts, List.forall_mem_cons.2 ⟨m_w258_never_halts, List.forall_mem_cons.2 ⟨m_w259_never_halts, List.forall_mem_cons.2 ⟨m_w260_never_halts, List.forall_mem_cons.2 ⟨m_w261_never_halts, List.forall_mem_cons.2 ⟨m_w262_never_halts, List.forall_mem_cons.2 ⟨m_w263_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
