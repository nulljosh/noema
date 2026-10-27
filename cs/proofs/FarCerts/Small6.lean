import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_40 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 2), (1, 0, 0, true, 2), (2, 0, 1, false, 2), (2, 1, 0, false, 0)] }
def m_s3_40_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2], [2, 4, 2, 2, 2, 3, 2, 2], [2, 2, 2, 2, 2, 3, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 2, 2, 3, 2, 2]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 1), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1, 2] }
theorem m_s3_40_never_halts : ¬ Halts m_s3_40 := never_halts m_s3_40 m_s3_40_cert (by decide +kernel)

def m_s3_41 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 2), (1, 0, 0, true, 2), (2, 0, 1, false, 2), (2, 1, 0, false, 0)] }
def m_s3_41_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2], [2, 4, 2, 2, 2, 3, 2, 2], [2, 2, 2, 2, 2, 3, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 2, 2, 3, 2, 2]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 1), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1, 2] }
theorem m_s3_41_never_halts : ¬ Halts m_s3_41 := never_halts m_s3_41 m_s3_41_cert (by decide +kernel)

def m_s3_42 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_42_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_42_never_halts : ¬ Halts m_s3_42 := never_halts m_s3_42 m_s3_42_cert (by decide +kernel)

def m_s3_43 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, true, 2), (1, 1, 0, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_43_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_43_never_halts : ¬ Halts m_s3_43 := never_halts m_s3_43 m_s3_43_cert (by decide +kernel)

def m_s3_44 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 0), (2, 1, 0, false, 0)] }
def m_s3_44_cert : Cert := {
  delta := [[0, 1, 2, 3, 2, 2, 2, 2], [0, 1, 2, 3, 2, 2, 4, 4], [2, 2, 2, 3, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 3, 2, 2, 2, 2]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_s3_44_never_halts : ¬ Halts m_s3_44 := never_halts m_s3_44 m_s3_44_cert (by decide +kernel)

def m_s3_45 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, false, 2), (1, 1, 1, true, 1), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }
def m_s3_45_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_45_never_halts : ¬ Halts m_s3_45 := never_halts m_s3_45 m_s3_45_cert (by decide +kernel)

def m_s3_46 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, false, 2), (1, 1, 0, true, 1), (2, 0, 1, true, 1), (2, 1, 1, false, 2)] }
def m_s3_46_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_46_never_halts : ¬ Halts m_s3_46 := never_halts m_s3_46 m_s3_46_cert (by decide +kernel)

def m_s3_47 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 0), (1, 0, 0, false, 2), (2, 0, 1, true, 0), (2, 1, 1, false, 2)] }
def m_s3_47_cert : Cert := {
  delta := [[0, 1, 0, 2, 0, 3, 2, 2], [1, 1, 0, 2, 0, 3, 2, 2], [0, 2, 0, 2, 0, 3, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [false, true, false, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (3, 1), (3, 3)],
  z := [0], z2 := [0] }
theorem m_s3_47_never_halts : ¬ Halts m_s3_47 := never_halts m_s3_47 m_s3_47_cert (by decide +kernel)

end FAR
