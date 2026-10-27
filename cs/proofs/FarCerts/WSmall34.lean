import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w264 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w264_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 1, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w264_never_halts : ¬ Halts m_w264 := never_halts m_w264 m_w264_cert (by decide +kernel)

def m_w265 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w265_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w265_never_halts : ¬ Halts m_w265 := never_halts m_w265 m_w265_cert (by decide +kernel)

def m_w266 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w266_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w266_never_halts : ¬ Halts m_w266 := never_halts m_w266 m_w266_cert (by decide +kernel)

def m_w267 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 0, true, 1), (1, 0, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w267_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w267_never_halts : ¬ Halts m_w267 := never_halts m_w267 m_w267_cert (by decide +kernel)

def m_w268 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w268_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 4, 6] }
theorem m_w268_never_halts : ¬ Halts m_w268 := never_halts m_w268 m_w268_cert (by decide +kernel)

def m_w269 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w269_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 1, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w269_never_halts : ¬ Halts m_w269 := never_halts m_w269 m_w269_cert (by decide +kernel)

def m_w270 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 0), (1, 2, 0, false, 1)] }
def m_w270_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w270_never_halts : ¬ Halts m_w270 := never_halts m_w270 m_w270_cert (by decide +kernel)

def m_w271 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w271_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w271_never_halts : ¬ Halts m_w271 := never_halts m_w271 m_w271_cert (by decide +kernel)

def wSmall34 : List Machine := [m_w264, m_w265, m_w266, m_w267, m_w268, m_w269, m_w270, m_w271]
theorem wSmall34_never_halt : ∀ x ∈ wSmall34, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w264_never_halts, List.forall_mem_cons.2 ⟨m_w265_never_halts, List.forall_mem_cons.2 ⟨m_w266_never_halts, List.forall_mem_cons.2 ⟨m_w267_never_halts, List.forall_mem_cons.2 ⟨m_w268_never_halts, List.forall_mem_cons.2 ⟨m_w269_never_halts, List.forall_mem_cons.2 ⟨m_w270_never_halts, List.forall_mem_cons.2 ⟨m_w271_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
