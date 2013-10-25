//Connexion V1.1
//
//Patrick Lafrance 2012/10/03

unit uniteConnexionHTTPServeur;

interface

uses StrUtils, SysUtils, DateUtils, uniteConnexion, uniteRequete, uniteReponse;

type

   ConnexionHttpServeur = class(Connexion)
   private
      requeteRecue : Requete;
   public
      //Lit une requ�te d'un ordinateur distant
      //
      //@return Un objet Requete qui contiendra la requete re�ue
      //
      //@raises Exception si la connexion ne permet pas de lire une cha�ne
      function lireRequete : Requete ;

      //Envoie une r�ponse � l'ordinateur distant
      //
      //@param uneReponse La un objet Reponse � renvoyer.
      //
      //@raises Exception si la connexion ne permet pas d'�crire une cha�ne
      procedure ecrireReponse ( uneReponse : Reponse );

      //Ferme la connexion.
      //
      //@raises Exception si la connexion ne peut �tre referm�e
      procedure fermerConnexion; override;

   end;

implementation
function ConnexionHttpServeur.lireRequete : Requete;
var
   chaine : String;
begin
   lireChaine( chaine );

   requeteRecue := Requete.Create;
   requeteRecue.adresseDemandeur:=getAdresseDistante;
   requeteRecue.dateReception:=date;
   requeteRecue.versionProtocole:=ansiRightStr( chaine, 8);
   requeteRecue.methode:=ansiLeftStr( chaine, ansiPos( ' ', chaine)-1 );
   requeteRecue.url:=ansiMidStr( chaine, ansiPos( ' ', chaine)+1, ansiPos( ' HTTP', chaine) - ansiPos( ' ', chaine)-1);


   result := requeteRecue;

end;

procedure ConnexionHttpServeur.ecrireReponse( uneReponse : Reponse );
begin

   ecrireChaine( 'HTTP/1.1 ' + intToStr(uneReponse.codeReponse) + ' ' + uneReponse.message + CRLF + CRLF + uneReponse.reponseHTML);

end;

procedure ConnexionHttpServeur.fermerConnexion;
begin
  inherited fermerConnexion;
  requeteRecue.free;
end;

end.
