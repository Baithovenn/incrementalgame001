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

**Entscheidung:** Draufsicht schräg von oben in 3D-Optik. Klumpen ohne HP, als Traube aus Teilen, die an der Trefferstelle abbrechen und sichtbar kleiner werden. Kern innen, anfangs nicht abbaubar; Nachwachsen nur aus dem Kern.  
**Warum:** Widerstand durch Form statt Zahl. Kern-Regel vermeidet Upgrades, die die eigene Mechanik abschalten. P4 hat bestätigt: Klumpen, die kleiner werden, tragen.  
**Verworfen / Alternative:** HP-Balken; "wächst nicht mehr nach" als Upgrade.  
**Revidieren wenn:** –

## 2026-09-07 - REVIDIERT: Stelle zielen und Fahrzeugsteuerung

**Entscheidung:** "Maus wählt eine Stelle am Klumpen" und Fahrzeugsteuerung (W/S Gas, A/D lenken, Arm vorn mit Sektor) sind verworfen.  
**Warum:** P4: Die Stelle macht keinen spürbaren Unterschied, man haut, bis es weg ist. Ohne genaues Zielen fällt das Argument für Rangieren weg; Fahren war "meh".  
**Neu:** WASD direkte Richtung mit etwas Gewicht. Arm als Turm oben, 360°. Hover: Maus zeigt, wo gearbeitet wird, kein Klick.  
**Revidieren wenn:** P5 zeigt, dass Hover ohne Klick zu passiv ist.

## 2026-09-07 - Bogen: Handarbeit wird Automatik

**Entscheidung:** Früh zeigt der Spieler, wo gearbeitet wird; später weiten Upgrades den Bereich, in dem der Roboter von selbst arbeitet. Elemente (Feuer, Eis, Blitz, Säure, Explosion) verändern die Bindung der Klumpen, nicht "Schaden": Feuer = bröselt weiter, Eis = hart wird spröde, Blitz = springt, Säure = frisst Kerne, Explosion = Wucht ohne Richtung.  
**Warum:** Löst den Widerspruch zwischen frühem Zielen und spätem Durchrödeln; bleibt im Modell ohne HP.  
**Verworfen / Alternative:** Elemente als Schadenstypen.  
**Revidieren wenn:** –

## 2026-09-07 - Akku nur für Arbeit, Entfernung kostet Weg

**Entscheidung:** Fahren kostet keinen Akku, Heimfahren wird nicht bestraft. Entfernung wird durch versperrende Klumpen begrenzt.  
**Warum:** Ohne irgendeinen Preis für Entfernung würden nahe Klumpen nie bearbeitet.  
**Revidieren wenn:** Versperren im Test als Gängelung wirkt.

## 2026-09-07 - Erst HTML-Gefühlstest, dann Godot

**Entscheidung:** Kern in HTML testen, Godot erst wenn der Kern trägt.  
**Warum:** Godot rettet ein Gefühl nicht, das in 2D nicht da ist.  
**Revidieren wenn:** Der Test etwas braucht, das nur 3D liefert.
