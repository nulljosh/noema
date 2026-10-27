import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_80 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 2), (2, 0, 1, true, 1)] }
def m_s3_80_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 4, 5, 5], [0, 0, 6, 6, 5, 5, 2, 5], [4, 4, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5], [2, 5, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5], [3, 4, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 4] }
theorem m_s3_80_never_halts : ¬ Halts m_s3_80 := never_halts m_s3_80 m_s3_80_cert (by decide +kernel)

def m_s3_81 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_s3_81_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_81_never_halts : ¬ Halts m_s3_81 := never_halts m_s3_81 m_s3_81_cert (by decide +kernel)

def m_s3_82 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 2), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (2, 1, 1, false, 1)] }
def m_s3_82_cert : Cert := {
  delta := [[0, 0, 1, 2, 1, 1, 3, 1], [1, 1, 1, 1, 1, 1, 3, 1], [4, 1, 1, 1, 1, 1, 3, 1], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 1, 1, 1, 1, 3, 1]],
  acc := [false, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1] }
theorem m_s3_82_never_halts : ¬ Halts m_s3_82 := never_halts m_s3_82 m_s3_82_cert (by decide +kernel)

def m_s3_83 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_s3_83_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_83_never_halts : ¬ Halts m_s3_83 := never_halts m_s3_83 m_s3_83_cert (by decide +kernel)

def m_s3_84 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 2), (2, 0, 1, true, 1)] }
def m_s3_84_cert : Cert := {
  delta := [[0, 0, 1, 1, 2, 2, 1, 3], [2, 2, 4, 4, 4, 4, 4, 3], [1, 5, 4, 4, 4, 4, 4, 3], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 3], [5, 5, 4, 4, 4, 4, 4, 3]],
  acc := [false, false, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 1), (1, 3), (1, 5), (2, 2), (2, 3), (2, 5), (3, 3), (3, 5), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (5, 3), (5, 5)],
  z := [0], z2 := [1, 2] }
theorem m_s3_84_never_halts : ¬ Halts m_s3_84 := never_halts m_s3_84 m_s3_84_cert (by decide +kernel)

def m_s3_85 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_85_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_85_never_halts : ¬ Halts m_s3_85 := never_halts m_s3_85 m_s3_85_cert (by decide +kernel)

def m_s3_86 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, true, 2), (1, 1, 0, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_86_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_86_never_halts : ¬ Halts m_s3_86 := never_halts m_s3_86 m_s3_86_cert (by decide +kernel)

def m_s3_87 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 1), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }
def m_s3_87_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_87_never_halts : ¬ Halts m_s3_87 := never_halts m_s3_87 m_s3_87_cert (by decide +kernel)

end FAR
