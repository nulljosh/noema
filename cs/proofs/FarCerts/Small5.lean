import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_32 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_s3_32_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_32_never_halts : ¬ Halts m_s3_32 := never_halts m_s3_32 m_s3_32_cert (by decide +kernel)

def m_s3_33 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 2), (2, 1, 1, true, 0)] }
def m_s3_33_cert : Cert := {
  delta := [[0, 1, 2, 2, 2, 3, 4, 2], [0, 1, 2, 2, 2, 2, 4, 2], [2, 2, 2, 2, 2, 2, 4, 2], [3, 3, 2, 2, 2, 2, 4, 2], [4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_s3_33_never_halts : ¬ Halts m_s3_33 := never_halts m_s3_33 m_s3_33_cert (by decide +kernel)

def m_s3_34 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 2), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (2, 1, 1, false, 1)] }
def m_s3_34_cert : Cert := {
  delta := [[0, 0, 1, 2, 1, 1, 3, 1], [1, 1, 1, 1, 1, 1, 3, 1], [4, 1, 1, 1, 1, 1, 3, 1], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 1, 1, 1, 1, 3, 1]],
  acc := [false, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1] }
theorem m_s3_34_never_halts : ¬ Halts m_s3_34 := never_halts m_s3_34 m_s3_34_cert (by decide +kernel)

def m_s3_35 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 2), (1, 0, 1, false, 0), (1, 1, 0, true, 0), (2, 0, 1, false, 0)] }
def m_s3_35_cert : Cert := {
  delta := [[0, 1, 2, 2, 2, 2, 2, 3], [4, 5, 6, 7, 2, 2, 2, 3], [2, 2, 2, 2, 2, 2, 2, 3], [3, 3, 3, 3, 3, 3, 3, 3], [1, 1, 2, 2, 3, 7, 3, 3], [8, 5, 6, 7, 7, 9, 7, 3], [7, 3, 2, 2, 2, 2, 2, 3], [7, 7, 2, 2, 2, 2, 2, 3], [8, 5, 6, 7, 3, 7, 3, 3], [6, 7, 2, 2, 2, 2, 2, 3]],
  acc := [false, false, false, true, false, false, true, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], good := [3], reachTape := [0, 1, 4, 5, 8],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (3, 3), (3, 6), (3, 7), (3, 9), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (6, 3), (6, 6), (6, 7), (6, 9), (7, 3), (7, 6), (7, 7), (7, 9), (8, 0), (8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), (8, 7), (8, 8), (8, 9), (9, 3), (9, 6), (9, 7), (9, 9)],
  z := [0], z2 := [2] }
theorem m_s3_35_never_halts : ¬ Halts m_s3_35 := never_halts m_s3_35 m_s3_35_cert (by decide +kernel)

def m_s3_36 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 2), (2, 0, 1, true, 1)] }
def m_s3_36_cert : Cert := {
  delta := [[0, 0, 1, 1, 2, 2, 1, 3], [2, 2, 4, 4, 4, 4, 4, 3], [1, 5, 4, 4, 4, 4, 4, 3], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 3], [5, 5, 4, 4, 4, 4, 4, 3]],
  acc := [false, false, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 1), (1, 3), (1, 5), (2, 2), (2, 3), (2, 5), (3, 3), (3, 5), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (5, 3), (5, 5)],
  z := [0], z2 := [1, 2] }
theorem m_s3_36_never_halts : ¬ Halts m_s3_36 := never_halts m_s3_36 m_s3_36_cert (by decide +kernel)

def m_s3_37 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_s3_37_cert : Cert := {
  delta := [[0, 0, 0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_37_never_halts : ¬ Halts m_s3_37 := never_halts m_s3_37 m_s3_37_cert (by decide +kernel)

def m_s3_38 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, true, 2), (1, 1, 0, true, 1), (2, 0, 1, false, 2), (2, 1, 1, true, 1)] }
def m_s3_38_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_38_never_halts : ¬ Halts m_s3_38 := never_halts m_s3_38 m_s3_38_cert (by decide +kernel)

def m_s3_39 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 0, true, 2), (1, 1, 0, true, 1), (2, 0, 1, false, 2), (2, 1, 1, false, 0)] }
def m_s3_39_cert : Cert := {
  delta := [[0, 1, 2, 3, 3, 3, 3, 4], [1, 3, 3, 3, 5, 6, 6, 3], [5, 4, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3], [3, 6, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3], [5, 6, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6)],
  z := [0], z2 := [2, 5] }
theorem m_s3_39_never_halts : ¬ Halts m_s3_39 := never_halts m_s3_39 m_s3_39_cert (by decide +kernel)

end FAR
