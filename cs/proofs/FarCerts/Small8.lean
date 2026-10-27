import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_56 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, false, 2), (1, 1, 0, true, 1), (2, 0, 1, false, 2), (2, 1, 1, false, 0)] }
def m_s3_56_cert : Cert := {
  delta := [[0, 1, 2, 3, 2, 2, 2, 2], [1, 4, 5, 3, 2, 2, 2, 6], [2, 2, 2, 3, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 5, 3, 6, 7, 6, 6], [5, 5, 5, 3, 6, 1, 6, 6], [6, 6, 2, 3, 2, 2, 2, 2], [6, 1, 2, 3, 2, 2, 2, 2]],
  acc := [true, true, false, true, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [3], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (1, 0), (1, 1), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (7, 0), (7, 1), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7)],
  z := [0], z2 := [2] }
theorem m_s3_56_never_halts : ¬ Halts m_s3_56 := never_halts m_s3_56 m_s3_56_cert (by decide +kernel)

def m_s3_57 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, false, 1), (1, 1, 1, true, 2), (2, 0, 1, false, 1), (2, 1, 0, true, 2)] }
def m_s3_57_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_57_never_halts : ¬ Halts m_s3_57 := never_halts m_s3_57 m_s3_57_cert (by decide +kernel)

def m_s3_58 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 2), (1, 0, 0, false, 0), (1, 1, 0, true, 1), (2, 0, 1, false, 0)] }
def m_s3_58_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 4, 5, 4], [6, 4, 4, 4, 7, 5, 5, 4], [7, 5, 4, 4, 4, 4, 4, 4], [7, 5, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4], [4, 3, 4, 4, 4, 4, 4, 4], [1, 1, 3, 3, 4, 3, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1, 4, 6],
  rel := [(0, 0), (0, 1), (0, 4), (0, 6), (1, 0), (1, 1), (1, 4), (1, 6), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 4), (3, 6), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 6), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_s3_58_never_halts : ¬ Halts m_s3_58 := never_halts m_s3_58 m_s3_58_cert (by decide +kernel)

def m_s3_59 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 1)] }
def m_s3_59_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_59_never_halts : ¬ Halts m_s3_59 := never_halts m_s3_59 m_s3_59_cert (by decide +kernel)

def m_s3_60 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, true, 1)] }
def m_s3_60_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_60_never_halts : ¬ Halts m_s3_60 := never_halts m_s3_60 m_s3_60_cert (by decide +kernel)

def m_s3_61 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, false, 2), (2, 1, 1, true, 0)] }
def m_s3_61_cert : Cert := {
  delta := [[0, 1, 2, 2, 2, 3, 4, 2], [0, 1, 2, 2, 2, 2, 4, 2], [2, 2, 2, 2, 2, 2, 4, 2], [3, 3, 2, 2, 2, 2, 4, 2], [4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_s3_61_never_halts : ¬ Halts m_s3_61 := never_halts m_s3_61 m_s3_61_cert (by decide +kernel)

def m_s3_62 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 2), (1, 0, 0, false, 0), (1, 1, 0, true, 0), (2, 0, 1, false, 0)] }
def m_s3_62_cert : Cert := {
  delta := [[0, 1, 2, 2, 3, 2, 2, 3], [4, 3, 3, 3, 2, 2, 2, 3], [2, 2, 2, 2, 2, 2, 2, 3], [3, 3, 3, 3, 3, 3, 3, 3], [3, 1, 2, 2, 3, 3, 3, 3]],
  acc := [false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1, 3, 4],
  rel := [(0, 0), (0, 1), (0, 3), (0, 4), (1, 1), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 1), (3, 3), (3, 4), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_s3_62_never_halts : ¬ Halts m_s3_62 := never_halts m_s3_62 m_s3_62_cert (by decide +kernel)

def m_s3_63 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_63_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_63_never_halts : ¬ Halts m_s3_63 := never_halts m_s3_63 m_s3_63_cert (by decide +kernel)

end FAR
