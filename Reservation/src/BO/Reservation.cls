Class BO.Reservation Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerReservation(pRequest As msg.creerResDmde, Output pResponse As msg.creerResRpse) As %Status
{
    set pResponse = ##class(msg.creerResRpse).%New()

    set statement=##class(%SQL.Statement).%New() 
    set status=statement.%PrepareClassQuery("DB.QueryClass","MyQ")
        IF status'=1 {WRITE "%Prepare failed:" DO $System.Status.DisplayError(status) QUIT}
    set SQLrequest = statement.%Execute(pRequest.categorie,pRequest.dateDebut,pRequest.dateFin)	
    do SQLrequest.%Next()
    set plaqueNumber = SQLrequest.%Get("plaque")

    
    set idVoiture = ##class(data.Voiture).consulterParPlaqueExists(plaqueNumber)
    if (idVoiture){
        set reservation = ##class(data.Reservation).%New()
        set reservation.voiture = ##class(data.Voiture).%OpenId(idVoiture)
        set reservation.dateDebut = pRequest.dateDebut
        set reservation.dateFin = pRequest.dateFin
        if (reservation.%Save()){
            set pResponse.codeRetour = "OK"
        }
        else {
            set pResponse.codeRetour = "KO(SAVE)"
        }
    } else {
        set pResponse.codeRetour = "KO(NEXISTE PAS)"
    }
    
    Quit $$$OK
}


XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerResDmde">
        <Method>creerReservation</Method>
    </MapItem>
</MapItems>
}

}
