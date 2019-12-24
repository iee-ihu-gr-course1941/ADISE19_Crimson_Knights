# ADISE19_Crimson_Knights
# Εγκατάσταση
Απαιτήσεις
    - Apache2
    - Mysql Server
    - php

# Οδηγίες Εγκατάστασης

- Κάντε clone το project σε κάποιον φάκελο
  $ git clone https://github.com/iee-ihu-gr-course1941/Lectures-Chess4.git
  
- Βεβαιωθείτε ότι ο φάκελος είναι προσβάσιμος από τον Apache Server. πιθανόν να χρειαστεί να καθορίσετε τις παρακάτω ρυθμίσεις.

- Θα πρέπει να δημιουργήσετε στην Mysql την βάση με όνομα 'adise19_chess5' και να φορτώσετε σε αυτήν την βάση τα δεδομένα από το αρχείο    
  DB/schema5.sql

- Θα πρέπει να φτιάξετε το αρχείο lib/config_local.php το οποίο να περιέχει:
    <?php
	$DB_PASS = 'κωδικός';
	$DB_USER = 'όνομα χρήστη';
    ?>

# Περιγραφή Παιχνιδιού
 
Το UNO είναι ένα παιχνίδι καρτών, παρόμοιο σε φιλοσοφία με το παιχνίδι "Αγωνία". Η τράπουλά του αποτελείται από κάρτες τεσσάρων χρωμάτων 
(κόκκινες, πράσινες, κίτρινες και μπλε) καθώς και από ειδικές κάρτες. Πιο συγκεκριμένα, κάθε χρώμα έχει κάρτες με αριθμούς από το 0 ως και το 9 
και "κάρτες δράσης" οι οποίες είναι οι εξής τρεις: "πάρε δύο" , "χάνεις τη σειρά σου" , "αλλαγή φοράς". Όλες αυτές υπάρχουν από δύο φορές μέσα 
στην τράπουλα ανά χρώμα, εκτός του αριθμού 0 που υπάρχει μόνο μία φορά ανά χρώμα. Επίσης, υπάρχουν και δύο τύποι ειδικών καρτών: "αλλαγή 
χρώματος" και "πάρε τέσσερις". Συνολικά όλες οι κάρτες είναι 108. Στο παιχνίδι μπορούν να λάβουν μέρος από 2 ως 10 παίχτες, αν και συνήθως ο 
ιδανικός αριθμός είναι 4 παίχτες.

Το UNO παίζεται ως εξής: 
- Η τράπουλα ανακατεύεται και σε κάθε παίχτη μοιράζονται από 7 κάρτες. Πρώτος παίζει αυτός που κάθεται αριστερά αυτού που μοίρασε και η σειρά με 
  την οποία παίζουν οι παίχτες είναι η φορά των δεικτών του ρολογιού.
- Η πάνω κάρτα της στοίβας των καρτών που δεν μοιράστηκαν στους παίχτες, τοποθετείται ανοιχτή στο κέντρο του τραπεζιού μπροστά σε όλους τους 
  παίχτες και είναι η πρώτη του σωρού των χρησιμοποιημένων καρτών.
- Ο πρώτος στη σειρά παίχτης πρέπει να ρίξει μια κάρτα ίδιου αριθμού ή χρώματος με την κάρτα αυτή ή να πετάξει μια ειδική κάρτα. 
  Σε περίπτωση που  δεν έχει καμία κάρτα να ταιριάξει με την πάνω κάρτα του σωρού, πρέπει να τραβήξει μια κάρτα από τη στοίβα και αν ούτε 
  τότε δεν έχει να παίξει, πηγαίνει πάσο και έρχεται η σειρά του επόμενου παίχτη να παίξει, ακολουθώντας πάντα το ίδιο μοτίβο επιτρεπτών επιλογών 
  (χρώμα ή αριθμός – ειδική κάρτα – κάρτα από τη στοίβα – πάσο).
- Σκοπός του παιχνιδιού για κάθε παίχτη είναι να ξεφορτωθεί όλες τις κάρτες που έχει στα χέρια του. Ο πρώτος που θα τα καταφέρει, ανακηρύσσεται 
  νικητής για τον συγκεκριμένο γύρο.
  
Οι κανόνες είναι οι παρακάτω:
1. Όταν κάποιος παίχτης μείνει με μία κάρτα πρέπει να πει "Uno" προτού ο επόμενος προλάβει να παίξει. Αν δεν το κάνει, τιμωρείται παίρνοντας δύο
   κάρτες από τη στοίβα των αχρησιμοποίητων καρτών.
2. Η τελευταία κάρτα που θα πετάξει κάποιος παίχτης μπορεί να είναι οποιαδήποτε. Αν χρειαστεί ο επόμενος παίχτης να πάρει στα χέρια του κάρτες, 
   τις παίρνει και προσμετρώνται στους βαθμούς ποινής του.
3. Απαγορεύεται σε οποιονδήποτε παίχτη να υπαγορεύει στρατηγικές σε άλλον παίχτη. Αν το κάνει, τιμωρείται ο ίδιος με δύο επιπλέον κάρτες.
4. Σε περίπτωση που κάποιος πετάξει λάθος κάρτα, τιμωρείται με τέσσερις κάρτες και χάνει τη σειρά του.
5. Αν κάποιος παίχτης έχει κάποια κάρτα να παίξει αλλά παρ’ ολ’ αυτά επιλέξει να τραβήξει κάρτα, τότε πρέπει να παίξει την κάρτα που τράβηξε. 
   Αν γίνει αντιληπτός, οφείλει να τραβήξει δύο κάρτες.
6. Αν η στοίβα των αχρησιμοποίητων καρτών εξαντληθεί, η πάνω κάρτα του σωρού γίνεται η τελευταία του νέου σωρού και όλες οι υπόλοιπες κάρτες 
   του σωρού ανακατεύονται καλά και γίνονται η νέα στοίβα αχρησιμοποίητων καρτών.
7. Αν κάποιος παίχτης έπαιξε την κάρτα δράσης "πάρε τέσσερις" ενώ είχε να παίξει κάτι άλλο, τότε ο επόμενος παίχτης μπορεί να τον προκαλέσει να 
   του δείξει τα χαρτιά του. Αν αποδειχθεί ότι δικαίως τον προκάλεσε τότε τον αναγκάζει να πάρει αυτός τέσσερις κάρτες και να χάσει τη σειρά του, 
   αν όμως έκανε λάθος τότε θα πάρει συνολικά έξι κάρτες και θα χάσει εκείνος τη σειρά του.

Η βάση μας κρατάει τους εξής πίνακες και στοιχεία: ...

Η εφαρμογή απαπτύχθηκε μέχρι το σημείο ... (αναφέρετε τι υλοποιήσατε και τι όχι)

# Συντελεστές

Περιγραφή των αρμοδιοτήτων της ομάδας για την υλοποίηση του project 
- Προγραμματιστής 1: ...
- Προγραμματιστής 2: ...
- Προγραμματιστής 3: Σχεδιασμός αρχείου README.md (μέχρι τώρα)

# Περιγραφή API - Methods

- Card

Σημασία:  Ανάγνωση πρώτης κάρτας του "πάσο"
Μέθοδος:  GET /first_unused_card/
Ενέργεια: Επιστρέφει την πάνω κάρτα από τη στοίβα του "πάσο". 
          Περιλαμβάνει το χρώμα και τον τύπο (number or special) της κάρτας.

Σημασία:  Ανάγνωση πρώτης κάρτας των "άχρηστων" καρτών
Μέθοδος:  GET /first_waste_card/
Ενέργεια: Επιστρέφει την πάνω κάρτα από τη στοίβα των "άχρηστων" καρτών. 
          Περιλαμβάνει το χρώμα και τον τύπο (number or special) της κάρτας.

Σημασία:  Ανάγνωση κάρτας  
Μέθοδος:  GET /card/
Ενέργεια: Διαβάζει την κάρτα του παίκτη. Προφανώς ελέγχεται η κίνηση αν είναι νόμιμη καθώς και αν είναι η σειρά του παίκτη 
          να παίξει με βάση το token. Περιλαμβάνει το χρώμα και τον τύπο (number or special) της κάρτας.
          
Σημασία:  Παίξιμο της κάρτας
Μέθοδος:  PUT /first_waste_card/card/
Ενέργεια: Τοποθετεί στην "άχρηστη" στοίβα την κάρτα που μόλις διάβασε. Περιλαμβάνει το χρώμα και τον τύπο (number or special) της κάρτας.

- Player

Σημασία:  Ανάγνωση στοιχείων παίκτη
Μέθοδος:  GET /players/:p
Ενέργεια: Επιστρέφει τα στοιχεία όλων των παικτών που συνδέονται στο παιχνίδι.
          Το p μπορεί να είναι 'player1' , 'player2' , 'player3' , 'player4'.

Σημασία:  Καθορισμός στοιχείων παίκτη
Μέθοδος:  PUT /players/:p
Ενέργεια: Επιστρέφει τα στοιχεία όλων των παικτών και το αντίστοιχο token τους. 
          Το token πρέπει να το χρησιμοποιεί ο κάθε παίκτης καθ' όλη τη διάρκεια του παιχνιδιού.

Json Data:  Field         Description                 Required
            id            Το id του παίκτη p            yes
            username      Το username του παίκτη p      yes
            
- Status

Σημασία:  Ανάγνωση κατάστασης παιχνιδιού
Μέθοδος:  GET /status/
Ενέργεια: Επιστρέφει το στοιχείο Game_status.

# Περιγραφή API - Entities

- Players -> O κάθε παίκτης έχει τα παρακάτω στοιχεία

  Attribute       Description                            Values
  
  id              ID παίκτη                              Integer
  username        Όνομα παίκτη                           String
  token           To κρυφό token του παίκτη.             HEX
                  Επιστρέφεται μόνο όταν ο
                  παίκτης κάνει είσοδο στο παιχνίδι.
   
- Game_status -> H κατάσταση παιχνιδιού έχει τα παρακάτω στοιχεία

  Attribute        Description                          Values
  
  status           Κατάσταση παιχνιδιού                 'not active' , 'initialized' , 'started' , 'ended' , 'aborted'
  pl_turn          Η σειρά του παίκτη που παίζει        'player1' , 'player2' , 'player3' , 'player4' , null
  result           Νικητής παιχνιδιού                   'player1' , 'player2' , 'player3' , 'player4' , null
  last_change      Τελευταία αλλαγή/ενέργεια στην        timestamp
                   κατάσταση του παιχνιδιού.