# Backlog

## NOW

- Godot-Umzug, Schritt 3 gebaut (2026-09-11): Arm als Turm mit Zwei-Glieder-IK (Joint_arm_1/Joint_arm_2), Hover-Zielen per Raycast mit Ring (hell = in Reichweite, rot = außerhalb), Schlag im Takt mit Hitstop und Kamerawackeln, Brechen im Wucht-Radius (chip = (Kraft − bind) · Nähe, Teile schrumpfen und verschwinden, Kern zu hart), Brocken als RigidBody3D, Staub und Funken. Dazu aus der Rückmeldung zu Schritt 2: Kamera 55°, Stretch canvas_items/expand, Feld dichter und gestapelt, dunkle Erde unter dem Feld. Wartet auf Rückmeldung, bevor Schritt 4 (Einsammeln, Basis, Akku, Stauraum) beginnt.
- Prototyp 7 testen: Meißel-Roboter (bricht, mehrfach kaufbar) neben Kehrbesen (sammelt, mehrfach). Testfragen: Macht ein Helfer, der bricht, genauso Freude wie einer, der sammelt? Und: Was macht der Spieler selbst, wenn drei Meißler arbeiten?

## NEXT

- Rolle des Hauptroboters im Spätspiel festlegen (Route, Auswahl, Basis, Bau) – Pikmin-Frage.
- Feld größer, Klumpen versperren wirklich, Nebel/Sensor.
- Proc-Sichtbarkeit (Blitz über dem Klumpen, Aufleuchten, eigener Hitstop).
- Tuning: Schläge pro Klumpen, Brockenmenge, Stauraum, Kosten, Helfer-Reichweite.

## LATER

- Schwarm-Vision: Spinnen-Roboter auf Brocken, fliegende Drohnen, Helfer-Upgrades (Reichweite, Tempo, Werkzeug). Noch nicht fix.
- Kerne abbaubar (Eis/Säure), Nachwachsen, Feld leer räumen.
- Elemente als Bindungs-Veränderer.
- Klumpen-Optik (mit Godot). Helfer mit Charakter-Animation (Meißler hüpft auf den Stein).
- Story-Ton.
- Erst nach stabilem Loop: Prestige, Save-System, Content.
