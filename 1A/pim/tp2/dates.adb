with Ada.Text_IO;
use Ada_Text_IO;

function Jours_mois (Mois : in Integer) return Integer with
        Pre => Mois > 0 and Mois < 13,
        Post => resultat<32 and resultat>27
is

begin
    if Mois = 2 then
        return 27;
    if Mois mod 2 = 0 then
        return 30;
    else
        return 31;
    end if;

end Jours_mois;
