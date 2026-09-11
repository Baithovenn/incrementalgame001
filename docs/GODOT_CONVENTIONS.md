# Godot-Konventionen (ab Umzug nach Godot 4)

> Damit Platzhalter und spätere Onshape-Modelle austauschbar sind, ohne Code anzufassen.

## Ansicht

- 3D, Kamera schräg von oben, fester Winkel, folgt dem Hauptroboter weich. Orthografisch oder leichte Perspektive – in Godot beides umschaltbar, im Test entscheiden.
- Boden ist Y=0. Bewegung auf XZ.

## Roboter-Hierarchie (gilt für Hauptroboter und alle Helfer)

```
Robot (CharacterBody3D)         # Bewegung, Logik
  Body (Node3D)                 # Wurzel des sichtbaren Modells
    Mesh_Body                   # Platzhalter: CSG oder MeshInstance; später glTF
    Joint_<name> (Node3D)       # Pivot genau auf der Gelenkachse, Ursprung = Kugelmittelpunkt
      Mesh_<name>
      Joint_<child>...
    Socket_<name> (Node3D)      # Kupplung für tauschbare Werkzeuge/Anbauten
```

- Jedes bewegliche Teil hängt an einem `Joint_*`-Node. Der Code dreht nur Joints, nie Meshes.
- Werkzeuge sind Kindszenen, die an `Socket_*` gehängt werden. Werkzeugwechsel = Kind tauschen.
- Namen wie in Onshape: `arm_L_1`, `arm_L_2`, `klappe`, `bumper`, `tool_schaufel`. Der Import-Schritt ordnet glTF-Objekte anhand des Namens dem passenden Joint zu.

## Platzhalter

- CSG-Primitive in Godot (Zylinder, Kugel, Box), keine externen Dateien.
- Gleiche Proportionen wie das geplante CAD-Modell (Roomba: Scheibe Ø ~340 mm, Höhe ~90 mm; Godot-Einheiten = Meter, also 0.34 / 0.09).
- Farbe pro Robotertyp, damit man sie unterscheidet. Toon-Shader erst später.

## Klumpen

- Prozedural: Traube aus Kugeln (MeshInstance mit Rauschen verformt), jede Kugel ein eigenes Teil mit Bindung; Kern in der Mitte. Zerfallen = Teil entfernen, Brocken spawnen (RigidBody3D, kleine Kugeln, gehen nach Ruhe in Sleep).
- Kein CAD, keine Metaballs im ersten Schritt.

## Bewegung

- Alles prozedural: IK für Arme (SkeletonIK3D oder eigene Zwei-Glieder-IK), Hüpfen/Wackeln per Tween oder Sinus, Klappe per Tween auf `Joint_klappe`.
- Keine Keyframe-Animationen für Alltagsbewegung.

## Onshape -> Blender -> Godot

- Onshape: Parts benannt, Kugel (Ø gleich) an jedem Gelenk am beweglichen Teil, Ruhelage im Assembly, STEP-Export.
- Blender (per MCP, Agent): Import, Decimate, Pivot auf Kugelmittelpunkt, Hierarchie nach Kugel/Pfanne, Achsen Z-oben -> Y-oben, glTF-Export.
- Godot: glTF importieren, Nodes per Name auf `Joint_*` mappen. Code bleibt gleich.

## Reihenfolge des ersten Godot-Prototyps

1. Boden, Kamera, Hauptroboter als Platzhalter, WASD mit Trägheit. Nur fahren.
2. Klumpenfeld prozedural, versperrend, ohne Gänge, freier Hof um die Basis.
3. Arm als Turm mit IK, Hover-Zielen, Schlag, Teile brechen, Brocken fallen.
4. Einsammeln, Basis, Akku, Stauraum.
5. Helfer: Besen (Roomba-Platzhalter), Meißler.
6. Erst dann: Sortieranlage, Nebel, Kerne/Adern.

Jeder Schritt wird gespielt, bevor der nächste beginnt.
