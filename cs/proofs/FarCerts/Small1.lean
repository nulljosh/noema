import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_0 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 1, false, 1), (2, 1, 1, true, 2)] }
def m_s3_0_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_0_never_halts : ¬ Halts m_s3_0 := never_halts m_s3_0 m_s3_0_cert (by decide +kernel)

def m_s3_1 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, true, 2), (1, 1, 0, false, 2), (2, 0, 1, false, 1), (2, 1, 0, true, 1)] }
def m_s3_1_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_1_never_halts : ¬ Halts m_s3_1 := never_halts m_s3_1 m_s3_1_cert (by decide +kernel)

def m_s3_2 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, true, 2), (1, 1, 1, true, 1), (2, 0, 1, false, 0)] }
def m_s3_2_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 2, 3, 5], [0, 1, 2, 6, 4, 2, 6, 5], [4, 7, 6, 6, 6, 6, 6, 5], [4, 6, 6, 6, 6, 6, 6, 5], [6, 8, 6, 6, 6, 6, 6, 5], [5, 5, 5, 5, 5, 5, 5, 5], [9, 6, 6, 6, 6, 6, 6, 5], [4, 3, 6, 6, 6, 6, 6, 5], [8, 8, 6, 6, 6, 6, 6, 5], [9, 8, 6, 6, 6, 6, 6, 5]],
  acc := [false, false, false, false, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (2, 2), (2, 3), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (3, 3), (3, 5), (3, 6), (3, 8), (3, 9), (4, 4), (4, 5), (4, 8), (4, 9), (5, 5), (5, 8), (6, 5), (6, 6), (6, 8), (6, 9), (7, 3), (7, 5), (7, 6), (7, 7), (7, 8), (7, 9), (8, 5), (8, 8), (9, 5), (9, 8), (9, 9)],
  z := [0], z2 := [2, 4, 6, 9] }
theorem m_s3_2_never_halts : ¬ Halts m_s3_2 := never_halts m_s3_2 m_s3_2_cert (by decide +kernel)

def m_s3_3 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 0, false, 1), (2, 1, 1, true, 2)] }
def m_s3_3_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_3_never_halts : ¬ Halts m_s3_3 := never_halts m_s3_3 m_s3_3_cert (by decide +kernel)

def m_s3_4 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 0, false, 1), (2, 1, 0, true, 2)] }
def m_s3_4_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_4_never_halts : ¬ Halts m_s3_4 := never_halts m_s3_4 m_s3_4_cert (by decide +kernel)

def m_s3_5 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, true, 2), (1, 1, 1, true, 1), (2, 0, 0, false, 0)] }
def m_s3_5_cert : Cert := {
  delta := [[0, 1, 2, 2, 0, 2, 0, 3], [1, 1, 2, 2, 0, 2, 0, 3], [0, 2, 2, 2, 0, 2, 0, 3], [3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [false, true, false, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (3, 1), (3, 3)],
  z := [0], z2 := [0, 2] }
theorem m_s3_5_never_halts : ¬ Halts m_s3_5 := never_halts m_s3_5 m_s3_5_cert (by decide +kernel)

def m_s3_6 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 2), (2, 0, 0, false, 0), (2, 1, 1, true, 2)] }
def m_s3_6_cert : Cert := {
  delta := [[0, 0, 1, 1, 2, 3, 2, 2], [2, 4, 2, 2, 2, 3, 2, 2], [2, 2, 2, 2, 2, 3, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 2, 2, 3, 2, 2]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 1), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1, 2] }
theorem m_s3_6_never_halts : ¬ Halts m_s3_6 := never_halts m_s3_6 m_s3_6_cert (by decide +kernel)

def m_s3_7 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 2), (1, 1, 0, true, 1), (2, 0, 1, false, 2), (2, 1, 1, true, 1)] }
def m_s3_7_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_7_never_halts : ¬ Halts m_s3_7 := never_halts m_s3_7 m_s3_7_cert (by decide +kernel)

end FAR
