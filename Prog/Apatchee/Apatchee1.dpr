program Apatchee1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uniteServeur in 'uniteServeur.pas';

uses

// Conversion d'un string en entier et v�rifier si un intervalle est respect�
// @param min, max: les bornes de l'intervalle
// @param nbrChaine: la chaine de caract�re � convertire

function valideEntier( min, max: Integer; nbrChaine: String; ): Integer;
var nombre, controle : integer;
begin
  // D�sactive le contr�le des erreurs d'E/S
  {$I-}

  nombre := strToInt( nbrChaine );
  controle := IOResult;
  if ( controle <> 0 ) or ( nombre < min ) or ( nombre > max ) then
    writeln( 'Le num�ro de port doit respecter l''intervalle [',min,'..',max,']' );

  // Active le contr�le des erreurs d'E/S
  {$I+}
  result := nombre;
end;


var
  numeroDuPort: Word;
  leServeur: Serveur;


begin
  // validation de la configuration
  // ParamCount retourne le nombre de sous chaines dans une chaine de caract�re
  case paramCount of

    // Cas o� l'utilisateur n'utilise pas l'option ( -p ou -P )
    0: numeroDuPort := 80;

    // Cas o� l'utilisateur saisie seulement l'option ( -p ou -P )
    // ou toute autre caract�re sans le num�ro de port
    1: begin
         // ParamStr retourne le contenu d'une sous cha�ne
         if ( paramStr(1) = '-p' ) or ( paramStr(1) = '-P' ) then
         begin
           writeln( 'Vous devez saisir un num�ro de port compris entre [ 1 et 65 535 ]' );
           halt;
         end

         else
         begin
           writeln( 'Vous devez saisir -p ou -P suivi du num�ro de port compris entre [ 1 et 65 535 ]' );
           halt;
         end;
       end;

    // Pour v�rifier que l'utilisateur a configur� le serveur
    // avec l'option -p ou -P et avec un num�ro de port compris entre [ 1 et 65 535 ]
    2: begin
         if ( paramStr(1) <> '-p' ) and ( paramStr(1) <> '-P' ) then
         begin
           writeln( 'Vous devez saisir -p ou -P suivi du num�ro de port compris entre [ 1 et 65 535 ]' );
           halt;
         end

         else
         begin
           valideEntier(1,65535,paramStr(2));
           halt;
         end;
       end;

  end; // Fin de case

  // Instanciation du serveur
  leServeur := Serveur.create;

  // L'intialisation du serveur via un num�ro de port
  leServeur.initialiser(numeroDuPort);

  // D�marrage du serveur
  leServeur.demarrer;
end.
