unit uniteProtocole;

//La classe protocole prend une requete, v�rifie que la page demand�e existe(404),
//que la m�thode utilis�e est la bonne (501) et que le protocole est compatible (505)
//Retourne le code et le message appropri� � l'utilisateur.
interface


uses
uniteReponse, uniteRequete;

type
  Protocole = class

    //La methode traiterRequete analyse la requete et renvoie le code appropri� au fureteur.

    //Elle  re�oit la requete envoy�e par le fureteur en param�tre et retourne un objet de type Reponse.

    //@param uneRequete Re�oit la requ�te de l'utilisateur
    //@return Reponse  Traite la requ�te et retourne une r�ponse (Code d'erreur + message)
    function traiterRequete(uneRequete:Requete):Reponse;

  end;


implementation

//Le protocole sert a transformer une requete en reponse
//@function
function Protocole.traiterRequete;

begin

  //La fonction prend et affiche l'ensemble des �l�ments contenus dans

  //l'�l�ment pass� en param�tre, incluant la date de r�ception, et les affiche.}
  write('[', formatDateTimeune('c',Requete.dateReception), ']',' ', uneRequete.adresseDemandeur,' ', uneRequete.methode,' ', uneRequete.url,' ', uneRequete.versionProtocole);
  
  //Cr�ation de l'objet r�ponse qui sera retourn�.
  uneReponse:=Reponse.create;

  //Attribution des valeurs de l'adresse du demandeur et
  //de la version du protocole de l'objet requ�te � l'objet r�ponse.}
  uneReponse.adresseDemandeur:=uneRequete.adresseDemandeur;
  uneReponse.versionDemandeur:='HTTP/1.1';

  //Attribution d'un code de r�ponse � l'attribut codeReponse de l'objet
  //uneReponse le 404 est pour un URL inexistant, de moindre priorit�
  //que les suivants.
  uneReponse.codeReponse:= 404;

  //Les messages de r�ponse sont attribu�s ici � leurs attributs respectifs
  uneReponse.message:=('URL introuvable');
  uneReponse.reponseHTML:=('L�URL n�existe pas sur le serveur, veuillez v�rifier l�orthographe et r�essayer');

  {V�rification de la m�thode envoy�e au serveur. Si elle est autre que GET, changement du message d'erreur retourn� pour le 501.

  Si le code d'erreur est modifi�, les messages correspondants sont �galement modifi�s pour le refl�ter.

  Le code d'erreur 501 est de priotit� plus �lev�e que le 404 quant au retour par notre serveur. }
  if (uneRequete.methode<>'GET') and (uneRequete.methode<>'gET') and (uneRequete.methode<>'GeT') and (uneRequete.methode<>'GEt') and (uneRequete.methode<>'geT') and (uneRequete.methode<>'Get') and (uneRequete.methode<>'gEt') and (uneRequete.methode<>'get') then
  begin
    uneReponse.codeReponse:=501;
    uneReponse.message:=('M�thode incompatible');
    uneReponse.reponseHTML:=('La m�thode '+uneRequete.methode+' n''est pas compatible');
  end;

  {V�rification de la version du protocole. Si celle-ci n'est pas �gale

  � 1.0 ou 1.1, changement du message d'erreur pour 505.

  Si le code d'erreur est modifi� de la sorte, les messages d'erreur

  correspondants sont �galement modifi�s pour le refl�ter.

  Le code d'erreur 505 est de priorit� plus �lev�e que le 501 pour notre serveur,

  d'o� son assignation en dernier dans le protocole. }
  if (uneRequete.versionProtocole <> 'HTTP/1.0') and (uneRequete.versionProtocole <> 'HTTP/1.1') then
  begin
    uneReponse.codeReponse:= 505;
    uneReponse.message:=('Version HTTP non support�e');
    uneReponse.reponseHtml:=('Protocole '+uneRequete.Version+' incompatble avec le serveur');
  end;

  {Le protocole affiche la date de r�ception de la demande, l'adresse du demandeur,

  maintenant pass�e en attributs � uneReponse

  le codeReponse ainsi que le message d�termin�s par la fonction traiterRequete}
  write('[', FormatDateTime('c', Now),']',' ', uneReponse.adresseDemandeur,' ', uneReponse.codeReponse,' ', uneReponse.message);

  //Le r�sultat retourn� est un objet de type R�ponse.
  result:=uneReponse;
end.
