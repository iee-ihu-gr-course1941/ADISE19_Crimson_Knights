# ADISE19_Crimson_Knights
Table of Contents
=================
   * [Εγκατάσταση](#εγκατάσταση)
      * [Απαιτήσεις](#απαιτήσεις)
      * [Οδηγίες Εγκατάστασης](#οδηγίες-εγκατάστασης)
   * [Περιγραφή παιχνιδιού](#περιγραφή-παιχνιδιού)
      * [Συντελεστές](#συντελεστές)
   * [Περιγραφή API](#περιγραφή-api)
      * [Methods](#methods)
         * [Βoard](#board)
            * [Αρχικοποίηση Board](#αρχικοποίηση-board)
         * [Card](#card)
            * [Ανάγνωση πάνω κάρτας](#ανάγνωση-πάνω-κάρτας)
            * [Παίξιμο κάρτας](#παίξιμο-κάρτας)
            * [Τράβηγμα κάρτας](#τράβηγμα-κάρτας)
         * [Hand](#hand)
            * [Ανάγνωση του παίκτη που παίζει](#ανάγνωση-τουπαίκτη-πουπαίζει)
         * [Players](#players)
            * [Ανάγνωση ενεργών παικτών](#ανάγνωση-ενεργών-παικτών)
         * [Users](#Users)
            * [Ανάγνωση ενός χρήστη](#ανάγνωση-ενός-χρήστη)
            * [Εισαγωγή χρήστη στο παιχνίδι](#εισαγωγή-χρήστη-στοπαιχνίδι)
      * [Entities](#entities)
      
      
# Game Page

Μπορείτε να κατεβάσετε τοπικά ή να επισκευτείτε την σελίδα: ...

# Εγκατάσταση

## Απαιτήσεις

* Apache2
* Mysql Server
* php

## Οδηγίες Εγκατάστασης

 * Κάντε clone το project σε κάποιον φάκελο <br/>
  `$ git clone https://github.com/iee-ihu-gr-course1941/ADISE19_Crimson_Knights.git`

 * Βεβαιωθείτε ότι ο φάκελος είναι προσβάσιμος από τον Apache Server. Πιθανόν να χρειαστεί να καθορίσετε τις παρακάτω     ρυθμίσεις.

 * Θα πρέπει να δημιουργήσετε στην Mysql την βάση με όνομα 'UNO' και να φορτώσετε σε αυτήν την βάση τα δεδομένα από το     αρχείο db/Dump20191214.sql

 * Θα πρέπει να φτιάξετε το αρχείο php/config_local.php το οποίο να περιέχει:
```
    <?php
	define('DB_PWD', 'κωδικός');
	define('USERNAME', 'όνομα χρήστη');
    ?>
```

# Περιγραφή Παιχνιδιού
 
Το UNO είναι ένα παιχνίδι καρτών, παρόμοιο σε φιλοσοφία με το παιχνίδι "Αγωνία". Η τράπουλά του αποτελείται από κάρτες 
τεσσάρων χρωμάτων (κόκκινες, πράσινες, κίτρινες και μπλε) καθώς και από ειδικές κάρτες. Πιο συγκεκριμένα, κάθε χρώμα 
έχει κάρτες με αριθμούς από το 0 ως και το 9 και "κάρτες δράσης" οι οποίες είναι οι εξής τρεις: "πάρε δύο" , "χάνεις τη 
σειρά σου" , "αλλαγή φοράς". Όλες αυτές υπάρχουν από δύο φορές μέσα στην τράπουλα ανά χρώμα, εκτός του αριθμού 0 που 
υπάρχει μόνο μία φορά ανά χρώμα. Επίσης, υπάρχουν και δύο τύποι ειδικών καρτών: "αλλαγή χρώματος" και "πάρε τέσσερις". 
Συνολικά όλες οι κάρτες είναι 108. Στο παιχνίδι μπορούν να λάβουν μέρος από 2 ως 10 παίχτες, αν και συνήθως ο ιδανικός 
αριθμός είναι 4 παίχτες.

Το UNO παίζεται ως εξής: 
* Η τράπουλα ανακατεύεται και σε κάθε παίχτη μοιράζονται από 7 κάρτες. Πρώτος παίζει αυτός που κάθεται αριστερά αυτού 
που μοίρασε και η σειρά με την οποία παίζουν οι παίχτες είναι η φορά των δεικτών του ρολογιού.
* Η πάνω κάρτα της στοίβας των καρτών που δεν μοιράστηκαν στους παίχτες, τοποθετείται ανοιχτή στο κέντρο του τραπεζιού 
μπροστά σε όλους τους παίχτες και είναι η πρώτη του σωρού των χρησιμοποιημένων καρτών.
* Ο πρώτος στη σειρά παίχτης πρέπει να ρίξει μια κάρτα ίδιου αριθμού ή χρώματος με την κάρτα αυτή ή να πετάξει μια 
ειδική κάρτα. Σε περίπτωση που  δεν έχει καμία κάρτα να ταιριάξει με την πάνω κάρτα του σωρού, πρέπει να τραβήξει μια κάρτα από τη στοίβα και αν ούτε τότε δεν έχει να παίξει, πηγαίνει πάσο και έρχεται η σειρά του επόμενου παίχτη να παίξει, ακολουθώντας πάντα το ίδιο μοτίβο επιτρεπτών επιλογών (χρώμα ή αριθμός – ειδική κάρτα – κάρτα από τη στοίβα – πάσο).
* Σκοπός του παιχνιδιού για κάθε παίχτη είναι να ξεφορτωθεί όλες τις κάρτες που έχει στα χέρια του. Ο πρώτος που θα τα 
καταφέρει, ανακηρύσσεται νικητής για τον συγκεκριμένο γύρο.
  
Οι κανόνες είναι οι παρακάτω:
* Όταν κάποιος παίχτης μείνει με μία κάρτα πρέπει να πει "Uno" προτού ο επόμενος προλάβει να παίξει. Αν δεν το κάνει, τιμωρείται παίρνοντας δύο κάρτες από τη στοίβα των αχρησιμοποίητων καρτών.
* Η τελευταία κάρτα που θα πετάξει κάποιος παίχτης μπορεί να είναι οποιαδήποτε. Αν χρειαστεί ο επόμενος παίχτης να πάρει στα χέρια του κάρτες, τις παίρνει και προσμετρώνται στους βαθμούς ποινής του.
* Απαγορεύεται σε οποιονδήποτε παίχτη να υπαγορεύει στρατηγικές σε άλλον παίχτη. Αν το κάνει, τιμωρείται ο ίδιος με δύο επιπλέον κάρτες.
* Σε περίπτωση που κάποιος πετάξει λάθος κάρτα, τιμωρείται με τέσσερις κάρτες και χάνει τη σειρά του.
* Αν κάποιος παίχτης έχει κάποια κάρτα να παίξει αλλά παρ’ ολ’ αυτά επιλέξει να τραβήξει κάρτα, τότε πρέπει να παίξει την κάρτα που τράβηξε. Αν γίνει αντιληπτός, οφείλει να τραβήξει δύο κάρτες.
* Αν η στοίβα των αχρησιμοποίητων καρτών εξαντληθεί, η πάνω κάρτα του σωρού γίνεται η τελευταία του νέου σωρού και όλες οι υπόλοιπες κάρτες του σωρού ανακατεύονται καλά και γίνονται η νέα στοίβα αχρησιμοποίητων καρτών.
* Αν κάποιος παίχτης έπαιξε την κάρτα δράσης "πάρε τέσσερις" ενώ είχε να παίξει κάτι άλλο, τότε ο επόμενος παίχτης μπορεί να τον προκαλέσει να του δείξει τα χαρτιά του. Αν αποδειχθεί ότι δικαίως τον προκάλεσε τότε τον αναγκάζει να πάρει αυτός τέσσερις κάρτες και να χάσει τη σειρά του, αν όμως έκανε λάθος τότε θα πάρει συνολικά έξι κάρτες και θα χάσει εκείνος τη σειρά του.

Η βάση μας κρατάει τους εξής πίνακες και στοιχεία:

* BOARDS (`BOARD_ID`, `LAST_CHANGE`, `ACTIVE_COLOR`, `MAX_PLAYERS`, `ACTIVE_PLAYER_TOKEN`, `BOARD_STATE`)
* DECK (`COLOR`, `NUMBER`, `DECK_NUM`)
* HANDS (`BOARD_ID`, `USER_TOKEN`, `COLOR`, `NUMBER`, `DECK_NUM`, `VALID`)
* TURNS (`BOARD_ID`, `USER_TOKEN`, `TURN_NUMBER`, `ALLOWED`)
* USERS (`USER_TOKEN`, `USER_NAME`, `USER_TIME_STAMP`)

Η εφαρμογή απαπτύχθηκε μέχρι ...

## Συντελεστές

Περιγραφή των αρμοδιοτήτων της ομάδας για την υλοποίηση του project 
- Προγραμματιστής 1: ...
- Προγραμματιστής 2: ...
- Προγραμματιστής 3: ...

# Περιγραφή API

## Methods

### Board
#### Αρχικοποίηση Board

```
GET /set_board/
```

Αρχικοποιεί το Board, δηλαδή το παιχνίδι. Γίνονται update όλες οι κάρτες των παικτών καθώς και
η πρώτη εμφανίσιμη κάρτα του παιχνιδιού.

### Card
#### Ανάγνωση πάνω κάρτας

```
GET /set_board/top_card/
```

Αρχικά, διαβάζει την εμφανίσιμη κάρτα που τοποθετείται στο ταμπλό, ώστε να μπορεί να γίνεται εκκίνηση του παιχνιδιού.
Από 'κει και ύστερα, διαβάζει την πάνω κάρτα της στοίβας των "άχρηστων" καρτών.  

#### Παίξιμο κάρτας

```
POST /set_board/top_card/play_card/
```

Ρίχνει την κάρτα του παίκτη που είναι η σειρά να παίξει με βάση το token, πάνω στη στοίβα των "άχρηστων" καρτών.

#### Τράβηγμα κάρτας

```
GET /set_board/get_card/
```

Ο χρήστης που παίζει τραβάει μια κάρτα από τη στοίβα του "πάσο".

### Hand

#### Ανάγνωση του παίκτη που παίζει

```
GET /hand/
```

Διαβάζει τα στοιχεία του παίκτη που είναι να παίξει.

### Players

#### Ανάγνωση ενεργών παικτών

```
GET /get_players/:p
```

Επιστρέφει τα στοιχεία των ενεργών παικτών του παιχνιδιού. 
Το p μπορεί να είναι 'Player 1', 'Player 2', 'Player 3' ή 'Player 4'.

### Users

#### Ανάγνωση ενός χρήστη

```
POST /sign_in/
```

Διαβάζει τα στοιχεία ενός παίκτη, ο οποίος κάνει sign in στο παιχνίδι.

#### Εισαγωγή χρήστη στο παιχνίδι
```
POST /add_user/
```

Εισάγει έναν παίκτη μέσα στο παιχνίδι.





