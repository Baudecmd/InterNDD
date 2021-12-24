/// 
Class ProcMetier.exo5 Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.entreeCommandeVoitureDmde' response='msg.sortieCommandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='codeRetour' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='voiture' type='webObjet.wsVoiture' instantiate='0' />
<property name='plaque' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='catalogue' type='webObjet.wsCatalogue' instantiate='0' />
</context>
<sequence xend='200' yend='1000' >
<call name='Catalogue' target='Catalogue' async='0' xpos='200' ypos='250' >
<request type='msg.consulterVoitureCatalogueDmde' >
<assign property="callrequest.marque" value="request.marque" action="set" />
<assign property="callrequest.modele" value="request.modele" action="set" />
</request>
<response type='msg.consulterVoitureCatalogueRpse' >
<assign property="context.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="context.catalogue" value="callresponse.voiture" action="set" />
</response>
</call>
<if condition='context.codeRetour="KO"' xpos='200' ypos='350' xend='200' yend='900' >
<false>
<call name='Plaque' target='Plaque' async='0' xpos='335' ypos='500' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="context.voiture.plaque" value="callresponse.plaque" action="set" />
</response>
</call>
<transform name='transform' class='Transform.CatalogueToVoiture' source='context.catalogue' target='context.voiture' xpos='335' ypos='600' />
<call name='Voiture' target='Voiture' async='0' xpos='335' ypos='700' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture" value="context.voiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.creerVoitureRpse' >
<assign property="context.codeRetour" value="callresponse.codeRetour" action="set" />
</response>
</call>
<call name='File' target='File' async='0' xpos='335' ypos='800' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture" value="context.voiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.pushVoitureFileRpse' >
<assign property="context.codeRetour" value="callresponse.codeRetour" action="set" />
</response>
</call>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
