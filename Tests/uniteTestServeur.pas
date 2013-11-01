// Cette unit� sert � tester la classe Serveur afin de v�rifier
// si le num�ro de port et le r�pertoire de base sont
// correctement programm�s dans la classe.
unit uniteTestServeur;

interface

uses TestFrameWork, uniteServeur, uniteConsigneur, SysUtils;

type
  TestServeur = class (TTestCase)
     published

     // Cette proc�dure v�rifie le constructeur fonctionne
     // correctement avec des informations valides.
     procedure testConstructeurValide;

     // Cette proc�dure v�rifie si un message d'erreur est envoy�
     // dans le cas o� le port est inf�rieur � 1.
     procedure testConstructeurPortLimiteInferieurInvalide;

     // Cette proc�dure v�rifie si le constructeur prend le port 1
     // qui est le num�ro de port minimum acceptable.
     procedure testConstructeurPortInferieurLimiteValide;

     // Cette proc�dure v�rifie si le constructeur prend le port 65535
     // qui est le num�ro de port maximum acceptable.
     procedure testConstructeurPortSuperieurLimiteValide;

     // Cette proc�dure v�rifie si un message d'erreur est envoy�
     // dans le cas o� le dossier est inexistant.
     procedure testConstructeurRepertoireInvalide;
  end;

implementation
     // Cette proc�dure v�rifie le constructeur fonctionne
     // correctement avec des informations valides.
    procedure TestServeur.testConstructeurValide;

    var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas test� dans cette unit�.
      unConsigneur : Consigneur;

      // Sert � conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin


         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unit� ne sert pas � v�rifier le fonctionnement de la classe
         // Consigneur donc on affecte nil � l'objet.
         unConsigneur := nil;

       // On r�cup�re l'exception si elle est lanc�.
       try

         // Cr�ation d'un serveur avec des informations valides.
         unServeur := Serveur.create( 100, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;

      except on e:Exception do
        fail( e.message );
      end;
    end;

     // Cette proc�dure v�rifie si un message d'erreur est envoy�
     // dans le cas o� le port est inf�rieur � 1.
     procedure TestServeur.testConstructeurPortLimiteInferieurInvalide;

    var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas test� dans cette unit�.
      unConsigneur : Consigneur;

      // Sert � conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin
      // On r�cup�re l'exception si elle est lanc�.
          // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unit� ne sert pas � v�rifier le fonctionnement de la classe
         // Consigneur donc on affecte nil � l'objet.
         unConsigneur := nil;

      try
        // Cr�ation d'un serveur avec des informations invalides.
         unServeur := Serveur.create( 0, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;

	  fail('Pas d''exception lanc�e');
      except on e:Exception do
        check( e.message = 'Le num�ro de port doit respecter l''intervalle de [1..65535].' );
      end;
    end;

     // Cette proc�dure v�rifie si le constructeur prend le port 1
     // qui est le num�ro de port minimum acceptable.
     procedure TestServeur.testConstructeurPortInferieurLimiteValide;

     var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas test� dans cette unit�.
      unConsigneur : Consigneur;

      // Sert � conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin

         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unit� ne sert pas � v�rifier le fonctionnement de la classe
         // Consigneur donc on affecte nil � l'objet.
         unConsigneur := nil;

         // On r�cup�re l'exception si elle est lanc�.
         try

         // Cr�ation d'un serveur avec des informations valides. Le port num�ro 1
         // est un port valide.
         unServeur := Serveur.create( 1, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;

      // Message de l'exception qui a �t� lanc�e.
      except on e:Exception do
       fail(e.message);
      end;
    end;

     // Cette proc�dure v�rifie si le constructeur prend le port 65535
     // qui est le num�ro de port maximum acceptable.
     procedure TestServeur.testConstructeurPortSuperieurLimiteValide;

     var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas test� dans cette unit�.
      unConsigneur : Consigneur;

      // Sert � conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin
         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unit� ne sert pas � v�rifier le fonctionnement de la classe
         // Consigneur donc on affecte nil � l'objet.
         unConsigneur := nil;

         // On r�cup�re l'exception si elle est lanc�.
         try

         // Cr�ation d'un serveur avec des informations valides. Le port num�ro 65535
         // est un port valide.
         unServeur := Serveur.create( 65535, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;

      // Message de l'exception qui a �t� lanc�e.
      except on e:Exception do
       fail(e.message);
      end;
    end;


     // Cette proc�dure v�rifie si un message d'erreur est envoy�
     // dans le cas o� le dossier est inexistant.
     procedure TestServeur.testConstructeurRepertoireInvalide;

    var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas test� dans cette unit�.
      unConsigneur : Consigneur;

      // Sert � conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin
         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unit� ne sert pas � v�rifier le fonctionnement de la classe
         // Consigneur donc on affecte nil � l'objet.
         unConsigneur := nil;

         // On r�cup�re l'exception si elle est lanc�.
         try
         
         // Cr�ation d'un serveur avec des informations invalides.
         unServeur := Serveur.create( 80, unConsigneur, 'c:\toto' );

         // Destruction de l'objet.
         unServeur.destroy;

      // Message de l'exception qui a �t� lanc�e.
      except on e:Exception do
        check( e.message = 'Chemin d''acc�s au r�pertoire de base invalide.' );
      end;
    end;


initialization
  TestFrameWork.RegisterTest(TestServeur.Suite);
end.
