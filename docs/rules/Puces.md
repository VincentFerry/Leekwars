Source : https://leekwars.com/encyclopedia/fr/Puces

# Puces

Dans Leek Wars, les poireaux peuvent utiliser des puces. Ce sont des objets achetables au [marché](https://leekwars.com/encyclopedia/fr/march%C3%A9) qui permettent d'attaquer, de soigner, de se protéger, de booster, d'entraver, etc.

Contrairement aux armes, les [puces](https://leekwars.com/encyclopedia/Puces) n'ont pas besoin d'être prises en main. Si une puce est équipée sur votre poireau, il peut l'utiliser directement via la fonction [useChip](https://leekwars.com/help/documentation/useChip) (ou [summon](https://leekwars.com/help/documentation/summon) pour une puce d'invocation). Il n'y a pas besoin de la "prendre en main" avec une fonction comme [setWeapon](https://leekwars.com/help/documentation/setWeapon).

Si elles offrent ainsi plus de liberté que les armes, certains puces sont par contre soumises à un temps de récupération, aussi appelé cooldown. Si une puce indique "Récupération : 3 tours", cela signifie que lorsque vous utiliser la puce, vous devez attendre 3 tours avant de pouvoir la réutiliser. Les fonctions [getCooldown](https://leekwars.com/help/documentation/getCooldown) et [getChipCooldown](https://leekwars.com/help/documentation/getChipCooldown) vous permettront d'obtenir des informations sur ce cooldown dans votre code. Les puces n'ayant pas de temps de récupération sont, comme les armes, soumises aux limites du nombre d’utilisations par tour. La fonction [getChipMaxUses](https://leekwars.com/help/documentation/getChipMaxUses) permet d'obtenir le nombre maximal d'utilisations par tour de la puce.

Les puces sont également soumises aux restrictions de lancement des armes. La fonction [getChipLaunchType](https://leekwars.com/help/documentation/getChipLaunchType) permet de les prendre en compte dans votre code.

- Puces à cible unique : Elles ne touchent qu'une cellule.
- Puces à cibles multiples : Ces puces peuvent toucher plusieurs cellules à la fois. On parle d'aire d'effet (ou [AoE](https://leekwars.com/encyclopedia/fr/AoE)).

#### Nombre de puces équipables

Depuis la version [2.40](https://leekwars.com/forum/category-6/topic-11126), le nombre de puces équipables par un poireau dépend directement de sa [RAM](https://leekwars.com/encyclopedia/fr/RAM).

### Liste des puces

#### Attaques

[Décharge](https://leekwars.com/encyclopedia/fr/D%C3%A9charge) Niveau 2

[Caillou](https://leekwars.com/encyclopedia/fr/Caillou) Niveau 4

[Glaçon](https://leekwars.com/encyclopedia/fr/Gla%C3%A7on) Niveau 9

[Rocher](https://leekwars.com/encyclopedia/fr/Rocher) Niveau 13

[Étincelle](https://leekwars.com/encyclopedia/fr/%C3%89tincelle) Niveau 19

[Éclair](https://leekwars.com/encyclopedia/fr/%C3%89clair) Niveau 24

[Flamme](https://leekwars.com/encyclopedia/fr/Flamme) Niveau 29

[Stalactite](https://leekwars.com/encyclopedia/fr/Stalactite) Niveau 50

[Altération](https://leekwars.com/encyclopedia/fr/Alt%C3%A9ration) Niveau 53

[Éboulement](https://leekwars.com/encyclopedia/fr/%C3%89boulement) Niveau 77

[Iceberg](https://leekwars.com/encyclopedia/fr/Iceberg) Niveau 100

[Châtiment](https://leekwars.com/encyclopedia/fr/Ch%C3%A2timent) Niveau 147

[Météorite](https://leekwars.com/encyclopedia/fr/M%C3%A9t%C3%A9orite) Niveau 160

[Frappe du démon](https://leekwars.com/encyclopedia/fr/Frappe_du_d%C3%A9mon) Niveau 171

[Foudre](https://leekwars.com/encyclopedia/fr/Foudre) Niveau 180

[Brûlis](https://leekwars.com/encyclopedia/fr/Br%C3%BBlis) Niveau 209

[Désintégration](https://leekwars.com/encyclopedia/fr/D%C3%A9sint%C3%A9gration) Niveau 223

[Plasma](https://leekwars.com/encyclopedia/fr/Plasma) Niveau 290

#### Soins

[Bandage](https://leekwars.com/encyclopedia/fr/Bandage) Niveau 3

[Guérison](https://leekwars.com/encyclopedia/fr/Gu%C3%A9rison) Niveau 20

[Perfusion](https://leekwars.com/encyclopedia/fr/Perfusion) Niveau 56

[Blindage](https://leekwars.com/encyclopedia/fr/Blindage) Niveau 68

[Vaccin](https://leekwars.com/encyclopedia/fr/Vaccin) Niveau 80

[Mutation](https://leekwars.com/encyclopedia/fr/Mutation) Niveau 83

[Terreau](https://leekwars.com/encyclopedia/fr/Terreau) Niveau 111

[Régénération](https://leekwars.com/encyclopedia/fr/R%C3%A9g%C3%A9n%C3%A9ration) Niveau 122

[Rémission](https://leekwars.com/encyclopedia/fr/R%C3%A9mission) Niveau 170

[Vampirisation](https://leekwars.com/encyclopedia/fr/Vampirisation) Niveau 177

[Sérum](https://leekwars.com/encyclopedia/fr/S%C3%A9rum) Niveau 199

[Fertilisant](https://leekwars.com/encyclopedia/fr/Fertilisant) Niveau 205

[Élévation](https://leekwars.com/encyclopedia/fr/%C3%89l%C3%A9vation) Niveau 228

[Transmutation](https://leekwars.com/encyclopedia/fr/Transmutation) Niveau 252

[Thérapie](https://leekwars.com/encyclopedia/fr/Th%C3%A9rapie) Niveau 260

[Résurrection](https://leekwars.com/encyclopedia/fr/R%C3%A9surrection) Niveau 301

#### Protection

[Casque](https://leekwars.com/encyclopedia/fr/Casque) Niveau 10

[Mur](https://leekwars.com/encyclopedia/fr/Mur) Niveau 18

[Bouclier](https://leekwars.com/encyclopedia/fr/Bouclier) Niveau 35

[Armure](https://leekwars.com/encyclopedia/fr/Armure) Niveau 74

[Rempart](https://leekwars.com/encyclopedia/fr/Rempart) Niveau 117

[Carapace](https://leekwars.com/encyclopedia/fr/Carapace) Niveau 141

[Forteresse](https://leekwars.com/encyclopedia/fr/Forteresse) Niveau 194

[Dôme](https://leekwars.com/encyclopedia/fr/D%C3%B4me) Niveau 243

#### Boosts

[Protéines](https://leekwars.com/encyclopedia/fr/Prot%C3%A9ines) Niveau 6

[Motivation](https://leekwars.com/encyclopedia/fr/Motivation) Niveau 14

[Étirement](https://leekwars.com/encyclopedia/fr/%C3%89tirement) Niveau 17

[Bottes de cuir](https://leekwars.com/encyclopedia/fr/Bottes_de_cuir) Niveau 22

[Connaissance](https://leekwars.com/encyclopedia/fr/Connaissance) Niveau 32

[Solidification](https://leekwars.com/encyclopedia/fr/Solidification) Niveau 42

[Prisme](https://leekwars.com/encyclopedia/fr/Prisme) Niveau 92

[Férocité](https://leekwars.com/encyclopedia/fr/F%C3%A9rocit%C3%A9) Niveau 107

[Fouet](https://leekwars.com/encyclopedia/fr/Fouet) Niveau 119

[Échauffement](https://leekwars.com/encyclopedia/fr/%C3%89chauffement) Niveau 127

[Stéroïdes](https://leekwars.com/encyclopedia/fr/St%C3%A9ro%C3%AFdes) Niveau 134

[Convoitise](https://leekwars.com/encyclopedia/fr/Convoitise) Niveau 139

[Accélération](https://leekwars.com/encyclopedia/fr/Acc%C3%A9l%C3%A9ration) Niveau 143

[Adrénaline](https://leekwars.com/encyclopedia/fr/Adr%C3%A9naline) Niveau 156

[Sorcellerie](https://leekwars.com/encyclopedia/fr/Sorcellerie) Niveau 166

[Bottes ailées](https://leekwars.com/encyclopedia/fr/Bottes_ail%C3%A9es) Niveau 175

[Collier](https://leekwars.com/encyclopedia/fr/Collier) Niveau 182

[Précipitation](https://leekwars.com/encyclopedia/fr/Pr%C3%A9cipitation) Niveau 192

[Réflexes](https://leekwars.com/encyclopedia/fr/R%C3%A9flexes) Niveau 197

[Bottes de 7 lieues](https://leekwars.com/encyclopedia/fr/Bottes_de_7_lieues) Niveau 203

[Dopage](https://leekwars.com/encyclopedia/fr/Dopage) Niveau 207

[Rage](https://leekwars.com/encyclopedia/fr/Rage) Niveau 226

[Écorce](https://leekwars.com/encyclopedia/fr/%C3%89corce) Niveau 234

#### Bulbes

[Bulbe Chétif](https://leekwars.com/encyclopedia/fr/Bulbe_Ch%C3%A9tif) Niveau 48

[Bulbe Rocheux](https://leekwars.com/encyclopedia/fr/Bulbe_Rocheux) Niveau 105

[Bulbe Glacé](https://leekwars.com/encyclopedia/fr/Bulbe_Glac%C3%A9) Niveau 130

[Bulbe Guérisseur](https://leekwars.com/encyclopedia/fr/Bulbe_Gu%C3%A9risseur) Niveau 174

[Bulbe Enflammé](https://leekwars.com/encyclopedia/fr/Bulbe_Enflamm%C3%A9) Niveau 190

[Bulbe Magicien](https://leekwars.com/encyclopedia/fr/Bulbe_Magicien) Niveau 215

[Bulbe Métallique](https://leekwars.com/encyclopedia/fr/Bulbe_M%C3%A9tallique) Niveau 230

[Bulbe Savant](https://leekwars.com/encyclopedia/fr/Bulbe_Savant) Niveau 250

[Bulbe Tacticien](https://leekwars.com/encyclopedia/fr/Bulbe_Tacticien) Niveau 270

[Bulbe Foudroyant](https://leekwars.com/encyclopedia/fr/Bulbe_Foudroyant) Niveau 280

#### Entraves

[Tranquillisant](https://leekwars.com/encyclopedia/fr/Tranquillisant) Niveau 65

[Ralentissement](https://leekwars.com/encyclopedia/fr/Ralentissement) Niveau 98

[Somnifère](https://leekwars.com/encyclopedia/fr/Somnif%C3%A8re) Niveau 145

[Écrasement](https://leekwars.com/encyclopedia/fr/%C3%89crasement) Niveau 158

[Boulet](https://leekwars.com/encyclopedia/fr/Boulet) Niveau 184

[Fracture](https://leekwars.com/encyclopedia/fr/Fracture) Niveau 240

[Décervelage](https://leekwars.com/encyclopedia/fr/D%C3%A9cervelage) Niveau 266

#### Tactiques

[Libération](https://leekwars.com/encyclopedia/fr/Lib%C3%A9ration) Niveau 60

[Saut](https://leekwars.com/encyclopedia/fr/Saut) Niveau 70

[Antidote](https://leekwars.com/encyclopedia/fr/Antidote) Niveau 114

[Grappin](https://leekwars.com/encyclopedia/fr/Grappin) Niveau 120

[Gant de boxe](https://leekwars.com/encyclopedia/fr/Gant_de_boxe) Niveau 140

[Affranchissement](https://leekwars.com/encyclopedia/fr/Affranchissement) Niveau 149

[Inversion](https://leekwars.com/encyclopedia/fr/Inversion) Niveau 150

[Rempotage](https://leekwars.com/encyclopedia/fr/Rempotage) Niveau 163

[Téléportation](https://leekwars.com/encyclopedia/fr/T%C3%A9l%C3%A9portation) Niveau 200

#### Poisons

[Venin](https://leekwars.com/encyclopedia/fr/Venin) Niveau 42

[Toxine](https://leekwars.com/encyclopedia/fr/Toxine) Niveau 125

[Peste](https://leekwars.com/encyclopedia/fr/Peste) Niveau 210

[COVID-19](https://leekwars.com/encyclopedia/fr/COVID-19) Niveau 220

[Arsenic](https://leekwars.com/encyclopedia/fr/Arsenic) Niveau 285

#### Renvois

[Épine](https://leekwars.com/encyclopedia/fr/%C3%89pine) Niveau 132

[Miroir](https://leekwars.com/encyclopedia/fr/Miroir) Niveau 246

[Ronce](https://leekwars.com/encyclopedia/fr/Ronce) Niveau 278