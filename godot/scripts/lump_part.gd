extends StaticBody3D
## Ein Teil eines Klumpens: eine Kugel mit Bindung (Härte). Noch kein Brechen.

## Bindung: wie fest das Teil am Klumpen hängt. Werkzeugkraft muss darüber liegen.
@export var bind: float = 1.0
## Kern des Klumpens (härter, in der Mitte).
@export var is_core: bool = false
