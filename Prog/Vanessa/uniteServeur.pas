unit uniteServeur;

interface

uses
  SysUtils,
  uniteConsigneur,
  uniteConnexionHTTPServeur,
  uniteProtocole,
  uniteRequete,
  uniteReponse;

type

   //Un serveur HTTP minimaliste, supportant la m�thode GET du protocole HTTP 1.1 uniquement.
  Serveur = class
    private
    // Le chemin par lequel les requ�tes sont envoy�es au serveur
    // et les r�ponses sont retourn�es au client
      laConnexion : ConnexionHTTPServeur;

    // Le protocole HTTP par lequel les requ�tes sont trait�es
      leProtocole : Protocole;

    //Le consigneur qui r�achemine les messages d'erreur et de succ�s dans un format pr�cis.
    //FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en cr�ant la connexion et le protocole
    // @param unPort le num�ro du port sur lequel le serveur �coute les requ�tes
    // @param unConsigneur qui est de type Consigneur qui consigne les messages d'erreur et de connexion dans un format standardis�.
    // @param unRepertoireDeBase qui est de type string qui repr�sente un r�pertore existant sur le serveur.
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    // Destructeur qui d�truit les objet connexion, protocole et consigneur.
    // @param unConsigneur de type Consigneur qui repr�sente le consigneur � d�truire.
      destructor destroy(unConsigneur:Consigneur);
    // D�marre le traitement des requ�tes
      procedure demarrer;



  end;

implementation


    constructor Serveur.create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    begin
      // Instanciation de l'objet ConnexionHTTPServeur
      laConnexion := ConnexionHTTPServeur.create(unPort);

      // Instanciation de l'objet Protocole
      leProtocole := Protocole.create(unRepertoireDeBase,unConsigneur);


      leConsigneur:=unConsigneur;

      // Affichage d'un message standardis� pour confirmer l'initialisation (Instanciation) du serveur.
      leConsigneur.consigner('Serveur',' Le serveur est connecte sur le port '+ intToStr(unPort));
    end;

    procedure Serveur.demarrer;
    var
      uneRequete: Requete;
      uneReponse: Reponse;

    begin
    // Boucler infiniment
      while true do
      begin
      // Ouvre la connexion et attend une requ�te
        try
          uneRequete := laConnexion.lireRequete;
          // Message de confirmation de la r�ception de la requ�te
          leConsigneur.consigner('Serveur',' Requ�te re�ue de '+laConnexion.getAdresseDistante+'.');
        except on e : Exception do
          leConsigneur.consignerErreur('Serveur',' Erreur d''entr�e/sortie: '+ e.Message);
        end;


      // Le protocole traite la requ�te
        try
          uneReponse := leProtocole.traiterRequete(uneRequete);
        except on e : Exception do
          leConsigneur.consignerErreur('Serveur',' Erreur d''entr�e/sortie: '+ e.Message);
          //Les consignes sur moodle parlais d'un lancement d'exception mais je ne savais pas ou le mettre
          // ou m�me si je devais le mettre?
          //raise Exception.create('Num�ro de port invalide ou d�j� utilis�');
        end;
        // Renvoie de la reponse au client
        laConnexion.ecrireReponse(uneReponse);
        // Fermeture de la connexion
        laConnexion.fermerConnexion;
      end;
    end;
    //Le destructeur qui d�truit les objets de la classe serveur.
    destructor Serveur.destroy(unConsigneur:Consigneur);
    begin
      laConnexion.destroy;
      leProtocole.destroy;
      unConsigneur.destroy;
    end;
    
end.


