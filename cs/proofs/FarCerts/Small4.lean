import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_24 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 2), (1, 1, 0, true, 2), (2, 0, 1, true, 1), (2, 1, 0, false, 1)] }
def m_s3_24_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_24_never_halts : ¬ Halts m_s3_24 := never_halts m_s3_24 m_s3_24_cert (by decide +kernel)

def m_s3_25 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 2), (1, 1, 0, true, 0), (2, 0, 1, true, 1), (2, 1, 0, false, 1)] }
def m_s3_25_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 1, 1], [3, 3, 4, 2, 4, 4, 4, 4], [2, 2, 2, 2, 2, 2, 2, 2], [1, 5, 4, 2, 4, 4, 4, 4], [4, 4, 4, 2, 4, 4, 4, 4], [5, 5, 4, 2, 4, 4, 4, 4]],
  acc := [false, false, true, false, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 1), (1, 2), (1, 5), (2, 2), (2, 5), (3, 2), (3, 3), (3, 5), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (5, 2), (5, 5)],
  z := [0], z2 := [1, 3] }
theorem m_s3_25_never_halts : ¬ Halts m_s3_25 := never_halts m_s3_25 m_s3_25_cert (by decide +kernel)

def m_s3_26 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 2), (1, 1, 0, true, 0), (2, 0, 0, true, 1), (2, 1, 0, false, 1)] }
def m_s3_26_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 1, 1], [3, 3, 4, 2, 4, 4, 4, 4], [2, 2, 2, 2, 2, 2, 2, 2], [1, 5, 4, 2, 4, 4, 4, 4], [4, 4, 4, 2, 4, 4, 4, 4], [5, 5, 4, 2, 4, 4, 4, 4]],
  acc := [false, false, true, false, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 1), (1, 2), (1, 5), (2, 2), (2, 5), (3, 2), (3, 3), (3, 5), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (5, 2), (5, 5)],
  z := [0], z2 := [1, 3] }
theorem m_s3_26_never_halts : ¬ Halts m_s3_26 := never_halts m_s3_26 m_s3_26_cert (by decide +kernel)

def m_s3_27 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, true, 2), (1, 0, 1, false, 2), (2, 0, 0, true, 0), (2, 1, 0, false, 1)] }
def m_s3_27_cert : Cert := {
  delta := [[0, 1, 2, 3, 3, 4, 5, 5], [0, 4, 4, 4, 3, 4, 5, 4], [2, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4], [2, 3, 4, 4, 4, 4, 4, 4]],
  acc := [false, false, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 1), (1, 2), (1, 3), (1, 4), (2, 2), (2, 4), (3, 2), (3, 3), (3, 4), (4, 4), (5, 2), (5, 4), (5, 5)],
  z := [0], z2 := [2] }
theorem m_s3_27_never_halts : ¬ Halts m_s3_27 := never_halts m_s3_27 m_s3_27_cert (by decide +kernel)

def m_s3_28 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 1), (1, 1, 1, true, 2), (2, 0, 1, false, 1), (2, 1, 0, true, 2)] }
def m_s3_28_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_28_never_halts : ¬ Halts m_s3_28 := never_halts m_s3_28 m_s3_28_cert (by decide +kernel)

def m_s3_29 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 1), (1, 1, 1, true, 2), (2, 0, 0, true, 1), (2, 1, 0, true, 2)] }
def m_s3_29_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_29_never_halts : ¬ Halts m_s3_29 := never_halts m_s3_29 m_s3_29_cert (by decide +kernel)

def m_s3_30 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 2), (1, 0, 1, false, 1), (1, 1, 1, true, 0), (2, 1, 1, false, 0)] }
def m_s3_30_cert : Cert := {
  delta := [[0, 1, 2, 3, 3, 4, 3, 5], [3, 0, 3, 2, 6, 5, 3, 3], [6, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3], [3, 6, 3, 3, 3, 3, 3, 3], [2, 3, 3, 3, 3, 3, 3, 3], [6, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_s3_30_never_halts : ¬ Halts m_s3_30 := never_halts m_s3_30 m_s3_30_cert (by decide +kernel)

def m_s3_31 : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 2), (2, 1, 1, true, 1)] }
def m_s3_31_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 4, 4, 2], [4, 0, 4, 5, 6, 3, 4, 4], [6, 3, 4, 4, 4, 4, 4, 4], [4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4], [4, 3, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_s3_31_never_halts : ¬ Halts m_s3_31 := never_halts m_s3_31 m_s3_31_cert (by decide +kernel)

end FAR
