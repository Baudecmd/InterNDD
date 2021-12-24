Class DB.QueryClass Extends %Persistent [DdlAllowed]
{
Query MyQ(categorieVal as %String, dateDebut as %TimeStamp,dateFin as %TimeStamp) As %SQLQuery (CONTAINID=1,ROWSPEC="plaque") [SqlProc]
   {
      select plaque 
      from data.Voiture 
      where categorie = :categorieVal

      and plaque not in (
         SELECT voiture->plaque FROM data.Reservation where voiture->categorie = :categorie
         and ((dateDebut >= :dateDebut and dateDebut <= :dateFin ) 
         or (dateFin >= :dateDebut and dateFin <= :dateFin ) 
         or (dateDebut <= :dateDebut and dateFin >= :dateFin ) 
         or (dateDebut >= :dateDebut and dateFin <= :dateFin )) 
     ) 
   }
}