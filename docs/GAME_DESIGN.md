# Game Design

> Nur beschlossene oder aktuell getestete Dinge eintragen. Kein Wunschzettel.

## Arbeitstitel

Offen (intern: "Klumpen")

## Spielerfantasie

Ein Roboter auf Raupen arbeitet ein Feld aus lehmigen Erdklumpen ab. Er fängt schwach an (zwei, drei Klumpen pro Ladung), baut sich selbst um und eskaliert, bis der Bildschirm voller Brocken ist. Man macht etwas kaputt, auf das man zielt, und sieht es langsam zerfallen.

## Ansicht und Steuerung

- 2,5D: Draufsicht schräg von oben, 3D-Optik.
- WASD fährt den Roboter.
- Maus zielt eine Stelle am Klumpen. Kein Twin-Stick: der Roboter dreht sich träge dorthin, das Werkzeug fährt die Stelle an (prozedural, IK), Taste halten arbeitet im Takt.

## Kernloop (Hypothese)

1. Von der Basis ins Feld fahren, so weit der Weg frei ist.
2. Klumpen wählen, Stelle anzielen, arbeiten. Teile lösen sich, liegen als Brocken herum.
3. Drüberfahren sammelt. Stauraum ist begrenzt.
4. Zurück zur Basis: abladen, sieben, laden, umbauen.

## Klumpen

- Kein HP. Ein Klumpen ist eine Traube aus Teilen, weich verschmolzen, zufällig in Größe und Form.
- Ein Treffer löst Teile an der Werkzeugspitze, abhängig von Werkzeugkraft gegen Bindung. Man sieht, wo man getroffen hat.
- Härte ist Bindung. Zu hart heißt: gibt nichts her, nicht wenig.
- Innen ein Kern: härter, ergiebigster Inhalt. Anfangs nicht abbaubar.
- Klumpen wachsen langsam aus ihrem Kern nach. Kern raus = bleibt leer. Feld ohne Kerne bleibt leer und gibt das nächste frei.
- Später: sichtbare Risse als Schwachstellen; Treffer auf den Riss bricht mehr ab.

## Widerstand / Spannung

- Arbeitsakku: nur Arbeiten kostet, Fahren nicht. Laden nur an der Basis = Run-Ende. Heimfahren wird nicht bestraft.
- Stauraum: Auswahl, was mitkommt.
- Entfernung kostet Weg: Klumpen versperren. Weiter draußen kommt man nur hin, wenn nahe der Basis frei geräumt ist.
- Bodenhärte beeinflusst Fahren (Tempo), nicht den Akku.

## Feld

- Unregelmäßig, kein Rechteck. Nebel: sichtbar ist, was in Sensorreichweite liegt.
- Sensor-Upgrades: erst Reichweite (1 Klumpen weit, dann 2, 3, 4), dann was man über Klumpen sieht (Form, Härte, Inhalt, Risse).

## Wachstum / Progression

- Roboter (bleibend): Werkzeuge, die die Form des Bruchs ändern (Hacke punktuell/tief, Schaufel flach/breit, Ramme spaltet, Bohrer frisst durch), Akku, Stauraum, Sensoren, später Sammler/Magnet.
- Feld (pro Karte): räumt sich, gibt das nächste frei; Basis dort = Stützpunkt.

## Feedback und Spielgefühl

Bewegung und Abbauen müssen zuerst gut sein. Bruch an der richtigen Stelle, Brocken, die fliegen und liegen bleiben, Einsammeln durch Drüberfahren.

## Erster spielbarer Test

HTML, Draufsicht, Klumpen als schattierte Kugeltrauben, ein Werkzeug, ein Akku, fünf Klumpen, kein Nebel. Testfrage: Fühlt sich das Kaputtmachen nach etwas an, und macht die Stelle einen Unterschied?

## Explizit nicht gewollt

- Kein Klicker, keine Logistikoptimierung.
- Kein HP-Balken als Widerstand.
- Keine Upgrades, die eine Mechanik abschalten ("wächst nicht mehr nach").
- Kein Twin-Stick.
- Keine Bestrafung fürs Heimfahren.

## Später (Phase 2)

- Feld als Schacht-/Gangsystem, durch das man durch muss.
- Risse/Bruchstellen.
- Story-Ton (Roboter wird hoffnungsvoller).
- Umzug nach Godot, sobald der Kern in HTML trägt.
