# ⏰ Simon-Orologio 1.0.0

> Prima versione stabile di **Simon-Orologio** 🎉

---

## ✨ Cosa c'è di nuovo

- 🕐 **Nuova scheda "Orologio"** — ora locale in grande formato con secondi, sotto la data completa (es. *sabato 26 settembre 2026*) e il giorno della settimana
- 🎨 **Icona originale** disegnata per l'app, con versione `scalable` e `symbolic`
- 🏷️ **Rebranding completo** — nome, finestra *Informazioni*, metainfo e desktop entry
- 🌐 **Fusi orari** con alba e tramonto e indicazione giorno/notte
- ⏰ **Sveglie** con suoni personalizzabili, snooze e ripetizione settimanale
- ⏱️ **Cronometro** con giri (lap) e millisecondi
- ⏲️ **Timer** con pulsanti di avvio rapido
- 🇮🇹 **Traduzione italiana completa**
- ⌨️ **Scorciatoie da tastiera** per spostarsi tra le sezioni

---

## 🐧 Compatibilità

Ottimizzata e testata per **Ubuntu 24.04 LTS** e GNOME 46:

| Componente | Versione richiesta |
|------------|--------------------|
| GTK | ≥ 4.14 |
| libadwaita | ≥ 1.5 |
| GLib | ≥ 2.72 |
| Vala | ≥ 0.56 |

---

## 📦 Installazione

Scarica il pacchetto `.deb` e installalo con:

```bash
sudo apt install -y ./simon-orologio_1.0.0_amd64.deb
```

Al termine trovi **Simon-Orologio** nel menu delle applicazioni, con la sua icona nella barra.

---

## ⌨️ Scorciatoie

| Tasto | Sezione |
|-------|---------|
| `Alt` + `0` | Orologio |
| `Alt` + `1` | Fuso orario |
| `Alt` + `2` | Sveglia |
| `Alt` + `3` | Cronometro |
| `Alt` + `4` | Timer |
| `F1` | Aiuto |
| `Esc` | Ferma cronometro / reset timer |

---

## 🔨 Compilare da sorgente

```bash
meson setup builddir --prefix=/usr
ninja -C builddir
sudo ninja -C builddir install
```

---

## 📝 Note

- L'applicazione segue la **lingua del sistema**
- La località automatica per il fuso orario richiede il servizio **GeoClue** attivo
- Tutti i dati (sveglie, timer, località) sono salvati localmente

---

## 📄 Crediti e licenza

**Autore:** Simone

Licenza **GPL-3.0-or-later**.
