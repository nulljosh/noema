import FarCerts.Halts1
import FarCerts.Halts2
import FarCerts.Halts3
import FarCerts.Halts4
import FarCerts.Halts5
import FarCerts.Halts6
import FarCerts.Halts7
import FarCerts.Halts8
import FarCerts.Halts9
import FarCerts.Halts10
import FarCerts.Halts11
import FarCerts.Halts12
import FarCerts.Halts13
import FarCerts.Halts14
import FarCerts.Halts15
import FarCerts.Halts16
import FarCerts.Halts17

set_option maxRecDepth 100000

namespace FAR

theorem bb3_listed_steps : (((halts1 ++ halts2 ++ halts3 ++ halts4 ++ halts5 ++ halts6 ++ halts7 ++ halts8 ++ halts9 ++ halts10 ++ halts11 ++ halts12 ++ halts13 ++ halts14 ++ halts15 ++ halts16 ++ halts17).filter (·.1.n == 3)).map (·.2)).max? = some 20 := by decide +kernel

end FAR
