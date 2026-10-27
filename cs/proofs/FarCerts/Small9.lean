import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_s3_64 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 1, true, 2), (1, 1, 0, false, 2), (2, 0, 1, false, 1), (2, 1, 0, true, 1)] }
def m_s3_64_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_64_never_halts : ¬ Halts m_s3_64 := never_halts m_s3_64 m_s3_64_cert (by decide +kernel)

def m_s3_65 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 1, true, 2), (1, 1, 1, true, 1), (2, 0, 1, false, 0)] }
def m_s3_65_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 2, 3, 5], [0, 1, 2, 6, 4, 2, 6, 5], [4, 7, 6, 6, 6, 6, 6, 5], [4, 6, 6, 6, 6, 6, 6, 5], [6, 8, 6, 6, 6, 6, 6, 5], [5, 5, 5, 5, 5, 5, 5, 5], [9, 6, 6, 6, 6, 6, 6, 5], [4, 3, 6, 6, 6, 6, 6, 5], [8, 8, 6, 6, 6, 6, 6, 5], [9, 8, 6, 6, 6, 6, 6, 5]],
  acc := [false, false, false, false, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (2, 2), (2, 3), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (3, 3), (3, 5), (3, 6), (3, 8), (3, 9), (4, 4), (4, 5), (4, 8), (4, 9), (5, 5), (5, 8), (6, 5), (6, 6), (6, 8), (6, 9), (7, 3), (7, 5), (7, 6), (7, 7), (7, 8), (7, 9), (8, 5), (8, 8), (9, 5), (9, 8), (9, 9)],
  z := [0], z2 := [2, 4, 6, 9] }
theorem m_s3_65_never_halts : ¬ Halts m_s3_65 := never_halts m_s3_65 m_s3_65_cert (by decide +kernel)

def m_s3_66 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 2), (1, 0, 1, true, 2), (1, 1, 1, true, 0), (2, 0, 1, false, 0)] }
def m_s3_66_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 5, 6, 7], [0, 7, 8, 7, 7, 7, 5, 7], [4, 6, 7, 7, 7, 7, 7, 7], [7, 5, 7, 7, 7, 7, 7, 7], [4, 7, 7, 7, 7, 7, 7, 7], [8, 7, 7, 7, 7, 7, 7, 7], [3, 7, 7, 7, 7, 7, 7, 7], [7, 7, 7, 7, 7, 7, 7, 7], [4, 5, 7, 7, 7, 7, 7, 7]],
  acc := [true, true, false, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [7], reachTape := [0, 1, 7],
  rel := [(0, 0), (0, 1), (0, 7), (1, 0), (1, 1), (1, 7), (2, 0), (2, 1), (2, 2), (2, 4), (2, 7), (3, 0), (3, 1), (3, 3), (3, 7), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (6, 7), (7, 0), (7, 1), (7, 7), (8, 0), (8, 1), (8, 2), (8, 3), (8, 4), (8, 7), (8, 8)],
  z := [0], z2 := [2, 4] }
theorem m_s3_66_never_halts : ¬ Halts m_s3_66 := never_halts m_s3_66 m_s3_66_cert (by decide +kernel)

def m_s3_67 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, true, 2), (2, 0, 1, false, 0), (2, 1, 1, true, 2)] }
def m_s3_67_cert : Cert := {
  delta := [[0, 1, 2, 3, 3, 4, 5, 3], [0, 1, 2, 3, 3, 4, 3, 3], [3, 5, 3, 3, 3, 4, 3, 3], [3, 3, 3, 3, 3, 4, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4], [5, 5, 3, 3, 3, 4, 3, 3]],
  acc := [false, false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 4), (4, 5), (5, 4), (5, 5)],
  z := [0], z2 := [2, 3] }
theorem m_s3_67_never_halts : ¬ Halts m_s3_67 := never_halts m_s3_67 m_s3_67_cert (by decide +kernel)

def m_s3_68 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 1, true, 2), (2, 0, 1, false, 0), (2, 1, 1, true, 1)] }
def m_s3_68_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 5, 5, 5], [0, 0, 6, 6, 5, 5, 2, 2], [4, 5, 5, 5, 5, 5, 5, 5], [6, 2, 5, 5, 5, 5, 5, 5], [2, 2, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5], [3, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 4] }
theorem m_s3_68_never_halts : ¬ Halts m_s3_68 := never_halts m_s3_68 m_s3_68_cert (by decide +kernel)

def m_s3_69 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 0, false, 1), (2, 1, 1, true, 2)] }
def m_s3_69_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_69_never_halts : ¬ Halts m_s3_69 := never_halts m_s3_69 m_s3_69_cert (by decide +kernel)

def m_s3_70 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (1, 0, 1, true, 2), (1, 1, 1, false, 1), (2, 0, 0, false, 1), (2, 1, 0, true, 2)] }
def m_s3_70_cert : Cert := {
  delta := [[0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [false, true],
  reachAll := [0, 1], good := [1], reachTape := [0],
  rel := [(0, 0), (0, 1), (1, 1)],
  z := [0], z2 := [0] }
theorem m_s3_70_never_halts : ¬ Halts m_s3_70 := never_halts m_s3_70 m_s3_70_cert (by decide +kernel)

def m_s3_71 : Machine := { S := 2, n := 3, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 2), (1, 0, 1, true, 2), (2, 0, 0, false, 0), (2, 1, 0, true, 2)] }
def m_s3_71_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2], [2, 4, 2, 2, 2, 3, 2, 2], [2, 2, 2, 2, 2, 3, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 2, 2, 2, 3, 2, 2]],
  acc := [false, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 1), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 3), (4, 4)],
  z := [0], z2 := [1, 2] }
theorem m_s3_71_never_halts : ¬ Halts m_s3_71 := never_halts m_s3_71 m_s3_71_cert (by decide +kernel)

end FAR
