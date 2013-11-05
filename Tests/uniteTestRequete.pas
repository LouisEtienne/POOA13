// Cette unit� sert � tester la classe Requete. Cette classe comprend des tests
// pour v�rifier le bon fonctionnement du constructeur ainsi que les accesseurs
// pour l'adresse demandeur, la date de r�ception d'une requ�te, la version du
// protocole, la m�thode utilis�e pour le transfert de l'adresse et l'url.
unit uniteTestRequete;

interface

uses SysUtils, TestFrameWork, uniteRequete, DateUtils;

type
  // Nom de la classe pour faire les tests.
  TestRequete = class(TTestCase)

  published

  // Test sur le constructeur de la classe Requete avec des informations valides.
  procedure testConstructeurRequeteValide;

  // Test sur le constructeur de la classe Requete avec une adresse incorrecte.
  procedure testConstructeurRequeteAdresseIncorrecte;

  // Test sur le constructeur de la classe Requete avec une version protocole incorrecte.
  procedure testConstructeurRequeteVersionProtocoleIncorrecte;

  // Test sur le constructeur de la classe Requete avec une m�thode incorrecte.
  procedure testConstructeurRequeteMethodeIncorrecte;

  // Test sur le constructeur de la classe Requete avec une URL incorrecte.
  procedure testConstructeurRequeteURLIncorrecte;

  // Test sur l'accesseur de l'adresse demandeur de la classe Requete.
  procedure testGetAdresseDemandeur;

  // Test sur l'accesseur de la version du protocole de la classe Requete.
  procedure testGetVersionProtocole;

  // Test sur l'accesseur de l'url de la classe Requete.
  procedure testGetURL;

  // Test sur l'accesseur de ls m�thode utilis�e pour le transfert d'une adresse
  // de la classe Requete.
  procedure testGetMethode;

  // Test sur la date de r�ception concernant la requ�te en cours.
  procedure testGetDateReception;

end;

implementation

  // Test sur le constructeur de la classe Requete avec des informations valides.
  procedure testRequete.testConstructeurRequeteValide;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // du constructeur.
    uneRequete : Requete;

  begin

    // Cr�ation d'une requ�te pour tester le constructeur de la classe Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // Destruction de l'objet apr�s la cr�ation d'une requ�te r�ussie.
    uneRequete.destroy;

  end;

  // Test sur le constructeur de la classe Requete avec une adresse incorrecte.
  procedure testRequete.testConstructeurRequeteAdresseIncorrecte;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // du constructeur.
    uneRequete : Requete;

  begin
    // On pr�voit la r�cup�ration d'une exception si on a des probl�mes lors
    // de la cr�ation d'une requ�te.
    try
       // Cr�ation d'une requ�te pour tester le constructeur de la classe Requete.
       // L'adresse IP est incorrecte. Cette instruction ne devrait pas fonctionner.
       uneRequete := Requete.create('500.0.0.1',now,'HTTP/1.1','index.html','GET');

       // Destruction de l'objet apr�s la cr�ation d'une requ�te r�ussie.
       uneRequete.destroy;

    // La cr�ation de la requ�te a provoqu� une exception.
    except on e:Exception do
        fail( e.message );
    end;
  end;

  // Test sur le constructeur de la classe Requete avec une version protocole incorrecte.
  procedure testRequete.testConstructeurRequeteVersionProtocoleIncorrecte;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // du constructeur.
    uneRequete : Requete;

  begin
    // On pr�voit la r�cup�ration d'une exception si on a des probl�mes lors
    // de la cr�ation d'une requ�te.
    try
       // Cr�ation d'une requ�te pour tester le constructeur de la classe Requete.
       // La version du protocole est incorrecte.
       // Cette instruction ne devrait pas fonctionner.
       uneRequete := Requete.create('100.0.0.1',now,'HTTP/5.1','index.html','GET');

       // Destruction de l'objet apr�s la cr�ation d'une requ�te r�ussie.
       uneRequete.destroy;

    // La cr�ation de la requ�te a provoqu� une exception.
    except on e:Exception do
        fail( e.message );
    end;
  end;

  // Test sur le constructeur de la classe Requete avec une m�thode incorrecte.
  procedure testRequete.testConstructeurRequeteMethodeIncorrecte;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // du constructeur.
    uneRequete : Requete;

  begin
    // On pr�voit la r�cup�ration d'une exception si on a des probl�mes lors
    // de la cr�ation d'une requ�te.
    try
       // Cr�ation d'une requ�te pour tester le constructeur de la classe Requete.
       // La m�thode de transfert est incorrecte.
       // Cette instruction ne devrait pas fonctionner.
       uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','JET');

       // Destruction de l'objet apr�s la cr�ation d'une requ�te r�ussie.
       uneRequete.destroy;

    // La cr�ation de la requ�te a provoqu� une exception.
    except on e:Exception do
        fail( e.message );
    end;
  end;

  // Test sur le constructeur de la classe Requete avec une URL incorrecte.
  procedure testRequete.testConstructeurRequeteURLIncorrecte;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // du constructeur.
    uneRequete : Requete;

  begin
    // On pr�voit la r�cup�ration d'une exception si on a des probl�mes lors
    // de la cr�ation d'une requ�te.
    try
       // Cr�ation d'une requ�te pour tester le constructeur de la classe Requete.
       // L'URL est incorrecte. Cette instruction ne devrait pas fonctionner.
       uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.mtml','GET');

       // Destruction de l'objet apr�s la cr�ation d'une requ�te r�ussie.
       uneRequete.destroy;

    // La cr�ation de la requ�te a provoqu� une exception.
    except on e:Exception do
        fail( e.message );
    end;
  end;

  // Test sur l'accesseur de l'adresse demandeur de la classe Requete.
  procedure testRequete.testGetAdresseDemandeur;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // de l'accesseur de getAdresseDemandeur de la classe Requete.
    uneRequete : Requete;

  begin
    // Cr�ation d'un objet de type Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // V�rifie si la valeur retourn�e par l'accesseur getAdresseDemandeur
    // correspond � la valeur pass�e au constructeur.
    check( uneRequete.getAdresseDemandeur = '100.0.0.1' );

    // Destruction de l'objet apr�s la cr�ation.
    uneRequete.destroy;
  end;

  // Test sur le constructeur de la classe Requete avec une version protocole incorrecte.
  procedure testRequete.testGetVersionProtocole;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // de l'accesseur de getVersionProtocole de la classe Requete.
    uneRequete : Requete;

  begin
    // Cr�ation d'un objet de type Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // V�rifie si la valeur retourn�e par l'accesseur getVersionProtocole
    // correspond � la valeur pass�e au constructeur.
    check( uneRequete.getVersionProtocole = 'HTTP/1.1' );

    // Destruction de l'objet apr�s la cr�ation.
    uneRequete.destroy;
  end;

  // Test sur l'accesseur de l'url de la classe Requete.
  procedure testRequete.testGetURL;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // de l'accesseur de getURL de la classe Requete.
    uneRequete : Requete;

  begin
    // Cr�ation d'un objet de type Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // V�rifie si la valeur retourn�e par l'accesseur getURL
    // correspond � la valeur pass�e au constructeur.
    check( uneRequete.getURL = 'index.html' );

    // Destruction de l'objet apr�s la cr�ation.
    uneRequete.destroy;
  end;

  // Test sur l'accesseur de ls m�thode utilis�e pour le transfert d'une adresse
  // de la classe Requete.
  procedure testRequete.testGetMethode;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // de l'accesseur de getMethode de la classe Requete.
    uneRequete : Requete;

  begin
    // Cr�ation d'un objet de type Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // V�rifie si la valeur retourn�e par l'accesseur getMethode
    // correspond � la valeur pass�e au constructeur.
    check( uneRequete.getMethode = 'GET' );

    // Destruction de l'objet apr�s la cr�ation.
    uneRequete.destroy;
  end;

  // Test sur la date de r�ception concernant la requ�te en cours.
  procedure testRequete.testGetDateReception;

  var
    // Sert pour la cr�ation d'une requ�te afin de v�rifier le bon fonctionnement
    // de l'accesseur de getDateReception de la classe Requete.
    uneRequete : Requete;

    // Sert pour la comparaison de la date et heure courante du syst�me avec
    // la valeur retourn�e par l'accesseur getDateReception;
    uneDate : TDateTime;

  begin
    // Date courante du syst�me.
    uneDate := now;

    // Cr�ation d'un objet de type Requete.
    uneRequete := Requete.create('100.0.0.1',now,'HTTP/1.1','index.html','GET');

    // V�rifie si la valeur retourn�e par l'accesseur getDateReception
    // correspond � la valeur pass�e au constructeur.
      check(( compareDate( uneRequete.getDateReception, uneDate ) = 0 ) and
           ( hoursBetween ( uneRequete.getDateReception, uneDate ) = 0 ) and
           ( minutesBetween ( uneRequete.getDateReception, uneDate ) = 0 ));

    // Destruction de l'objet apr�s la cr�ation.
    uneRequete.destroy;
  end;
initialization
  TestFrameWork.RegisterTest(TestRequete.Suite);
end.
 