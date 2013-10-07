program Apatchee1;

{$APPTYPE CONSOLE}

uses
   SysUtils,
   uniteServeur in 'uniteServeur.pas';

uses

var
   numeroDuPort: Word;
   leServeur: Serveur;


begin
   // validation de la configuration
   // ParamCount retourne le nombre de param�tres pass�s au programme sur la ligne de commande.
   case paramCount of

      // Cas o� l'utilisateur n'utilise pas l'option ( -p ou -P )
      0: numeroDuPort := 80;

      // Cas o� l'utilisateur saisit seulement l'option ( -p ou -P )
      // ou toute autre caract�re sans le num�ro de port
      1: begin
            // ParamStr retourne le contenu d'une sous cha�ne
            if ( paramStr(1) = '-p' ) or ( paramStr(1) = '-P' ) then
            begin
               writeln( 'Vous devez saisir un num�ro de port dans l''intervalle [1, 65 535]' );
               halt;
            end

            else
            begin
               writeln( 'L''option ', paramStr(1), ' est inconnue.');
               halt;
            end;
         end;

      // Pour v�rifier que l'utilisateur a configur� le serveur
      // avec l'option -p ou -P et avec un num�ro de port compris entre [ 1 et 65 535 ]
      2: begin
            if ( paramStr(1) <> '-p' ) and ( paramStr(1) <> '-P' ) then
            begin
               writeln( 'L''option ', paramStr(1), ' est inconnue.');
               halt;
            end
            else
      // D�sactive le contr�le des erreurs d'E/S pour la conversion
      {$I-}
      numeroDuPort := strToInt( paramStr(2) );
      controle := IOResult;
      if ( controle <> 0 ) or ( numeroDuPort < 1 ) or ( numeroDuPort > 65535 ) then
      begin
         writeln( 'Le num�ro de port doit respecter l''intervalle [1, 65535]' );
         halt;
      end;
      // Active le contr�le des erreurs d'E/S
      {$I+}
               end;

   end; // Fin de case

   // Instanciation du serveur
   leServeur := Serveur.create;

   // L'initialisation du serveur sur un num�ro de port
   leServeur.initialiser(numeroDuPort);

   // D�marrage du serveur
   leServeur.demarrer;
end.
