unit uniteProtocole;

interface

uses
  SysUtils, uniteReponse, uniteRequete, uniteConsigneur;

//Traite les requ�tes HTTP et fournit une r�ponse appropri�e selon l'�tat du serveur
type
  Protocole = class
    private
      //Le r�pertoire local qui contient tous les sites web de notre serveur
      repertoireDeBase:String;

      //Un consigneur permettant de consigner tous les messages
      leConsigneur:Consigneur;

    public
      //La methode traiterRequete analyse la requete et renvoie le code appropri� au fureteur.
      //Elle  re�oit la requete envoy�e par le fureteur en param�tre et retourne un objet de type Reponse.
      //
      //@param uneRequete Re�oit la requ�te de l'utilisateur
      //
      //@return Reponse  Traite la requ�te et retourne une r�ponse (Code d'erreur + message)
      //
      //@exception Exception Si la requ�te n'est pas une requ�te HTTP valide (si la 3i�me partie n'est pas de la forme HTTP/x.y o� x et y sont des entiers)

      function traiterRequete(uneRequete:Requete):Reponse;

      //Cr�e un objet Protocole qui traite les requ�tes HTTP
      //et fournit une r�ponse appropri�e selon l'�tat du serveur.
      //
      //@param unRepertoireDeBase le r�pertoire qui contient tous les sites web de notre serveur
      //@param unConsigneur sert � consigner des messages

      constructor create(unRepertoireDeBase:String;unConsigneur:Consigneur);

      //Accesseur du r�pertoire de base
      //
      //@return String retourne le r�pertoire de base

      function getRepertoireDeBase:String;

      //Mutateur du r�pertoire de base
      //
      //@param unRepertoire le r�pertoire de base

      procedure setRepertoireDeBase(unRepertoireDeBase:String);

  end;


implementation

function Protocole.traiterRequete(uneRequete:Requete):Reponse;
var
  uneReponse:Reponse;
  uneAdresseDemandeur:String;
  uneVersionProtocole:String;
  unCodeReponse:Word;
  unMessage:String;
  uneReponseHtml:String;
  stringTemporaire:String;
begin

  //write('[', formatDateTime('c',uneRequete.getDateReception), ']',' ', uneRequete.getAdresseDemandeur,' ', uneRequete.getMethode,' ', uneRequete.getUrl,' ', uneRequete.getVersionProtocole);

  leConsigneur.consigner('ProtocoleHTTP', uneRequete.getAdresseDemandeur+'-'+uneRequete.getMethode+' ( '+uneRequete.getVersionProtocole+' )');

  //Initialisation des donn�es pour l'objet Reponse qui retourne une erreur pour le moment.

  uneAdresseDemandeur:=uneRequete.getAdresseDemandeur;
  uneVersionProtocole:='HTTP/1.1';
  unCodeReponse:=404;
  unMessage:='L''URL introuvable';
  uneReponseHTML:='L''URL ('+uneRequete.getUrl+') n''existe pas sur le serveur, veuillez verifier l''orthographe et reessayer';

  //V�rification de la m�thode

  if (uneRequete.getMethode<>uppercase('GET')) then
  begin
    unCodeReponse:=501;
    unMessage:='Methode incompatible';
    uneReponseHTML:=('La methode '+uneRequete.getMethode+' n''est pas compatible');
  end;

  //Utilisation d'un subString pour v�rifier HTTP/ seulement
  
  stringTemporaire:=copy(uneRequete.getVersionProtocole,1,5);

  //V�rification de x.y c'est � dire la 6e et 8e lettre du String pour qu'il soit bien entre 0 et 9
  //Sinon, l�ve une exception

  if  (stringTemporaire = 'HTTP/') and
      ((strToInt(uneRequete.getVersionProtocole[6]) >= 0) and
      (strToInt(uneRequete.getVersionProtocole[6]) <= 9)) and
      ((strToInt(uneRequete.getVersionProtocole[8]) >= 0) and
      (strToInt(uneRequete.getVersionProtocole[8]) <=9)) and
      (uneRequete.getVersionProtocole[7] = '.') and (length(uneRequete.getVersionProtocole) < 9) then
  else
    raise Exception.create('Requete HTTP invalide');

  //V�rifie le protocole HTTP

  if (uneRequete.getVersionProtocole <> 'HTTP/1.0') and (uneRequete.getVersionProtocole <> 'HTTP/1.1') then
  begin
    unCodeReponse:=505;
    unMessage:='Version HTTP non supportee';
    uneReponseHtml:=('Protocole '+uneRequete.getVersionProtocole+' incompatble avec le serveur');
  end;

  //Cr�er l'objet r�ponse avec tous les param�tres plus haut

  uneReponse:=Reponse.create(uneAdresseDemandeur,uneVersionProtocole,unCodeReponse,unMessage,uneReponseHtml);

  //Retourne l'objet r�ponse

  result:=uneReponse;

  //Utilise la m�thode consignerErreur du consigneur

  leConsigneur.consignerErreur('ProtocoleHTTP', uneReponseHtml);
end;

constructor Protocole.create(unRepertoireDeBase:String;unConsigneur:Consigneur);
begin
  setRepertoireDeBase(unRepertoireDeBase);
  leConsigneur:=unConsigneur;
end;

function Protocole.getRepertoireDeBase:String;
begin
  result:=repertoireDeBase;
end;

procedure Protocole.setRepertoireDeBase(unRepertoireDeBase:String);
begin
  repertoireDeBase:=unRepertoireDeBase;
end;

end.
