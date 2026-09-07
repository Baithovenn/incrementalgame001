# Optionaler Zwei-Agenten-Tick-Modus

**Standardmäßig nicht aktiv.** Nur verwenden, wenn Tobias ausdrücklich wieder mit Claude + Codex parallel arbeiten will.

## Idee

Ein Tick soll nicht automatisch doppelte Arbeit produzieren. Wenn beide Agenten parallel arbeiten, bekommen sie möglichst komplementäre Aufgaben.

Beispiel:

- Claude: Designhypothese / Variante A / spielerische Analyse
- Codex: technische Machbarkeit / Variante B / Gegenprobe
- danach: Ergebnisse vergleichen und eine Richtung auswählen

Bei Implementierung:

- möglichst unterschiedliche Dateien oder klar getrennte Aufgabenbereiche
- gemeinsame Kernentscheidungen vor dem Tick festhalten
- nach dem Tick laufenden Build testen, nicht nur Diffs vergleichen

Blindes paralleles Implementieren derselben Änderung ist nur sinnvoll, wenn ausdrücklich zwei unabhängige Lösungsansätze gewünscht sind.
