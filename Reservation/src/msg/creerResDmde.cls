Class msg.creerResDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property dateDebut As %TimeStamp;

Property dateFin As %TimeStamp;

Property categorie As %String;

Storage Default
{
<Data name="creerResDmdeDefaultData">
<Subscript>"creerResDmde"</Subscript>
<Value name="1">
<Value>dateDebut</Value>
</Value>
<Value name="2">
<Value>dateFin</Value>
</Value>
<Value name="3">
<Value>categorie</Value>
</Value>
</Data>
<DefaultData>creerResDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
