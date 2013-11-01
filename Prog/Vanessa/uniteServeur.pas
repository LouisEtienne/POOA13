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


      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en cr�ant la connexion et le protocole
    // @param unPort le num�ro du port sur lequel le serveur �coute les requ�tes
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);

      destructor destroy(unConsigneur:Consigneur);
    // D�mare le traitement des requ�tes
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


      // Affichage d'un message pour confirmer l'initialisation du serveur
      // FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
      leConsigneur.consigner(now, 'Serveur','Vanessa est demarr� sur le port '+intToStr(unPort));
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
        leConsigneur.consigner(now, 'Serveur',' Requ�te re�ue de '+laConnexion.getAdresseDistante+'.');
      except on e : Exception do
        leConsigneur.consignerErreur(now, 'Serveur','Erreur d''entr�e/sortie: '+e.Message);
      end;


      // Le protocole traite la requ�te
      try
        uneReponse := leProtocole.traiterRequete(uneRequete);

      except on e : Exception do
        leConsigneur.consignerErreur(now, 'Serveur','Erreur d''entr�e/sortie: '+e.Message);
//        raise Exception.Create('Num�ro de port invalide ou d�j� utilis�');
      end;
      // Renvoie de la reponse au client
      laConnexion.ecrireReponse(uneReponse);
      // Fermeture de la connexion
      laConnexion.fermerConnexion;
    end;
  end;

  destructor Serveur.destroy(unConsigneur:Consigneur);
  begin
    laConnexion.destroy;
    leProtocole.destroy;
    unConsigneur.destroy;
  end;


end.


