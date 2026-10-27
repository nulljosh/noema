import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w272 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w272_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w272_never_halts : ¬ Halts m_w272 := never_halts m_w272 m_w272_cert (by decide +kernel)

def m_w273 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w273_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w273_never_halts : ¬ Halts m_w273 := never_halts m_w273 m_w273_cert (by decide +kernel)

def m_w274 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 0, true, 1), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w274_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w274_never_halts : ¬ Halts m_w274 := never_halts m_w274 m_w274_cert (by decide +kernel)

def m_w275 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 0, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 0)] }
def m_w275_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 2, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w275_never_halts : ¬ Halts m_w275 := never_halts m_w275 m_w275_cert (by decide +kernel)

def m_w276 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w276_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w276_never_halts : ¬ Halts m_w276 := never_halts m_w276 m_w276_cert (by decide +kernel)

def m_w277 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, true, 1)] }
def m_w277_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 3, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w277_never_halts : ¬ Halts m_w277 := never_halts m_w277 m_w277_cert (by decide +kernel)

def m_w278 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w278_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 3, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w278_never_halts : ¬ Halts m_w278 := never_halts m_w278 m_w278_cert (by decide +kernel)

def m_w279 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 2, true, 1)] }
def m_w279_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [5, 3, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w279_never_halts : ¬ Halts m_w279 := never_halts m_w279 m_w279_cert (by decide +kernel)

def wSmall35 : List Machine := [m_w272, m_w273, m_w274, m_w275, m_w276, m_w277, m_w278, m_w279]
theorem wSmall35_never_halt : ∀ x ∈ wSmall35, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w272_never_halts, List.forall_mem_cons.2 ⟨m_w273_never_halts, List.forall_mem_cons.2 ⟨m_w274_never_halts, List.forall_mem_cons.2 ⟨m_w275_never_halts, List.forall_mem_cons.2 ⟨m_w276_never_halts, List.forall_mem_cons.2 ⟨m_w277_never_halts, List.forall_mem_cons.2 ⟨m_w278_never_halts, List.forall_mem_cons.2 ⟨m_w279_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
