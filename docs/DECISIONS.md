# Entscheidungen

Dauerhafte Entscheidungen knapp dokumentieren, damit sie nicht alle drei Sessions neu erfunden werden.

Format:

## YYYY-MM-DD - Entscheidung

**Entscheidung:**  
**Warum:**  
**Verworfen / Alternative:**  
**Revidieren wenn:**

---

## 2026-09-07 - REVIDIERT: Seitenansicht und Sand-Simulation

**Entscheidung:** Seitenansicht und Erde als Fallende-Sand-Physik sind verworfen (Prototypen 1–3 in work/ sind damit Archiv).  
**Warum:** Trägt für Tobias nicht; Sand-Engine nicht mehr plausibel als Kern.  
**Was bleibt:** Abbauen als Kernhandlung, schwacher Start und Eskalation, Runs plus Meta, Roboter der sich umbaut, großer Baum mit spielverändernden Knoten, keine Logistik, kein Klicker.

## 2026-09-07 - Kernrichtung: Klumpenfeld von oben, 2,5D

**Entscheidung:** Draufsicht schräg von oben in 3D-Optik. Roboter auf Raupen (WASD), Maus zielt eine Stelle am Klumpen, Taste halten arbeitet. Klumpen ohne HP, als Traube aus Teilen, die an der Trefferstelle abbrechen. Kern innen, anfangs nicht abbaubar; Nachwachsen nur aus dem Kern.  
**Warum:** Widerstand durch Form statt Zahl (sonst +%-Baum). Stelle-zielen macht Zielen zur Fähigkeit und passt zu "Maschine führt Auftrag aus". Kern-Regel vermeidet Upgrades, die die eigene Mechanik abschalten.  
**Verworfen / Alternative:** HP-Balken; Twin-Stick; Kontakt = Angriff; "wächst nicht mehr nach" als Upgrade.  
**Revidieren wenn:** Der HTML-Test zeigt, dass die Trefferstelle keinen spürbaren Unterschied macht.

## 2026-09-07 - Akku nur für Arbeit, Entfernung kostet Weg

**Entscheidung:** Fahren kostet keinen Akku, Heimfahren wird nicht bestraft. Entfernung wird durch versperrende Klumpen begrenzt.  
**Warum:** Tobias will kein Basis-Gegeiere. Ohne irgendeinen Preis für Entfernung würden nahe Klumpen nie bearbeitet; Versperren löst das und macht "Feld räumen" und "weiter rauskommen" zu derselben Sache.  
**Verworfen / Alternative:** Fahrakku; Zurückholen bei leerem Akku.  
**Revidieren wenn:** Versperren im Test als Gängelung wirkt.

## 2026-09-07 - Erst HTML-Gefühlstest, dann Godot

**Entscheidung:** Kern in einer HTML-Datei testen, Godot erst wenn der Kern trägt.  
**Warum:** Godot rettet ein Gefühl nicht, das in 2D nicht da ist; HTML ist in Stunden iterierbar.  
**Revidieren wenn:** Der Test etwas braucht, das nur 3D liefert (Tiefe, echte Bruchgeometrie).
