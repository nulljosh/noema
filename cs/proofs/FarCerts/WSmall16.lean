import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w120 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 1, true, 1)] }
def m_w120_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w120_never_halts : ¬ Halts m_w120 := never_halts m_w120 m_w120_cert (by decide +kernel)

def m_w121 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 1, true, 0)] }
def m_w121_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w121_never_halts : ¬ Halts m_w121 := never_halts m_w121 m_w121_cert (by decide +kernel)

def m_w122 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w122_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 2], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w122_never_halts : ¬ Halts m_w122 := never_halts m_w122 m_w122_cert (by decide +kernel)

def m_w123 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w123_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w123_never_halts : ¬ Halts m_w123 := never_halts m_w123 m_w123_cert (by decide +kernel)

def m_w124 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_w124_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w124_never_halts : ¬ Halts m_w124 := never_halts m_w124 m_w124_cert (by decide +kernel)

def m_w125 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 1), (1, 0, 0, false, 0), (1, 1, 0, true, 1)] }
def m_w125_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w125_never_halts : ¬ Halts m_w125 := never_halts m_w125 m_w125_cert (by decide +kernel)

def m_w126 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 1)] }
def m_w126_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w126_never_halts : ¬ Halts m_w126 := never_halts m_w126 m_w126_cert (by decide +kernel)

def m_w127 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 2, true, 0)] }
def m_w127_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 2, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 2, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w127_never_halts : ¬ Halts m_w127 := never_halts m_w127 m_w127_cert (by decide +kernel)

def wSmall16 : List Machine := [m_w120, m_w121, m_w122, m_w123, m_w124, m_w125, m_w126, m_w127]
theorem wSmall16_never_halt : ∀ x ∈ wSmall16, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w120_never_halts, List.forall_mem_cons.2 ⟨m_w121_never_halts, List.forall_mem_cons.2 ⟨m_w122_never_halts, List.forall_mem_cons.2 ⟨m_w123_never_halts, List.forall_mem_cons.2 ⟨m_w124_never_halts, List.forall_mem_cons.2 ⟨m_w125_never_halts, List.forall_mem_cons.2 ⟨m_w126_never_halts, List.forall_mem_cons.2 ⟨m_w127_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
