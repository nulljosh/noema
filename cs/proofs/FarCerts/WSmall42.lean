import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w328 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w328_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 2, 3], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 2, 3, 4, 4, 4, 4, 4, 4], [4, 2, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w328_never_halts : ¬ Halts m_w328 := never_halts m_w328 m_w328_cert (by decide +kernel)

def m_w329 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, false, 0)] }
def m_w329_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 2, 3], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 2, 3, 4, 4, 4, 4, 4, 4], [3, 2, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w329_never_halts : ¬ Halts m_w329 := never_halts m_w329 m_w329_cert (by decide +kernel)

def m_w330 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w330_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 2, 4], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 2, 4, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w330_never_halts : ¬ Halts m_w330 := never_halts m_w330 m_w330_cert (by decide +kernel)

def m_w331 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w331_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 2, 4], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w331_never_halts : ¬ Halts m_w331 := never_halts m_w331 m_w331_cert (by decide +kernel)

def wSmall42 : List Machine := [m_w328, m_w329, m_w330, m_w331]
theorem wSmall42_never_halt : ∀ x ∈ wSmall42, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w328_never_halts, List.forall_mem_cons.2 ⟨m_w329_never_halts, List.forall_mem_cons.2 ⟨m_w330_never_halts, List.forall_mem_cons.2 ⟨m_w331_never_halts, fun _ h => nomatch h⟩⟩⟩⟩

end FAR
