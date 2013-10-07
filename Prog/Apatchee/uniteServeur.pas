unit uniteServeur;

interface

uses
  uniteConnexionHTTPServeur;
  uniteProtocole;
  uniteRequete;
  uniteReponse;

type

  // Le serveur traite les requ�tes du client
  Serveur = class

    // Le chemin par lequel les requ�tes sont envoy�es au serveur
    // et les r�ponses sont retourn�es au client
    laConnexion: ConnexionHTTPServeur;

    // Le protocole par lequel les requ�tes sont trait�es
    leProtocole: Protocole;

    // Permet d'initialiser le serveur en cr�ant la connexion et le protocole
    // @param unPort le num�ro du port sur lequel le serveur �coute les requ�tes
    procedure initialiser(unPort:Word);

    // D�mare le traitement des requ�tes
    procedure demarrer;

  end;

implementation


  procedure Serveur.initialiser(unPort:Word);
  begin
    // Instanciation de l'objet ConnexionHTTPServeur
    laConnexion := ConnexionHTTPServeur.create(unPort);

    // Instanciation de l'objet Protocole
    leProtocole := Protocole.create;

    // Affichage d'un message pour confirmer l'initialisation du serveur
    // FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
    writeln(formatDateTime('c', now),' le serveur est demarr� sur le port : ',unPort);
  end;


  procedure Serveur.demarrer;
  var
    uneRequete: Requete;
    uneReponse: Reponse;
  begin
    // Boucler infiniment
    while true do
    begin
      // Envoi de la requ�te
      uneRequete := laConnexion.lireRequete;

      // Message de confirmation de la r�ception de la requ�te
      writeln(uneRequete.dateReception,' Requ�te re�ue de ',uneRequete.adresseDemandeur);

      // La reponse re�oit le traitement de la requ�te
      uneReponse := leProtocole.traiterRequete(uneRequete);

      // Envoi de la reponse de la requ�te re�u
      laconnexion.ecrireReponse(uneReponse);

      // Fermeture de la connexion
      laConnexion.fermerConnexion;
    end;
  end;

end.


