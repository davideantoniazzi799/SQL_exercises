/*
DELETE

- sintassi
- cancelliamo un record
- attenzione all'errore
- cosa succede all'ID
*/

/*
SINTASSI

DELETE FROM tabella WHERE condizione;

*/

DELETE FROM dipendenti WHERE mansione = "commerciale";

/*
Non dimenticarsi di WHERE!
Senza where andiamo ad eliminare tutto, quindi va messo!
*/

/*
Quando andiamo ad aggiungere un nuovo cliente/dipendente,
per via dell'auto increment di id
il nuovo recordo parte da quello che è l'ultimo record che avevamo creato.
Quindi, se abbiamo una tabella con 5 righe e l'ultima ha ID=5,
nel momento in cui eliminiamo la riga con ID=5
e andiamo ad aggiungere una nuova riga,
questa partirà da ID=6 anche se abbiamo eliminato ID=5
*/