Class BS.ServiceVoitureSoap Extends EnsLib.SOAP.Service
{

Parameter SERVICENAME = "ServiceVoitureSoap";

Parameter ADAPTER;

Method CommanderVoiture(marque As %String, modele As %String, couleur As %String) As msg.commandeVoitureRpse [ WebMethod ]
{
    set pOutput = ##class(msg.sortieCommandeVoitureRpse).%New()
    
/* TO DO */

    set tsc = ..SendRequestSync("CommandeVoiture",msg,.pOutput)

    Quit pOutput
}

}