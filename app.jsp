const { useState, useEffect, useRef } = React;
const Q = [
{q:"Quelle est la devise de la République française ?",en:"What is the motto of the French Republic?",o:["Paix, Amour, Liberté","Liberté, Égalité, Fraternité","Honneur, Patrie, Valeur","Justice, Ordre, Progrès"],a:1,x:"Liberté, Égalité, Fraternité — the 3-word identity of France. Yeh motto har Mairie pe likha hota hai!",c:"Valeurs",t:"Both"},
{q:"À quoi correspond la date du 14 juillet ?",en:"What does the date July 14th correspond to?",o:["Fin de la Première Guerre mondiale","Prise de la Bastille","Signature de la Constitution","Abolition de l'esclavage"],a:1,x:"July 14, 1789 — Storming of the Bastille. France ka 'Independence Day.' Military parade on Champs-Élysées!",c:"Valeurs",t:"Both"},
{q:"Quel est l'un des symboles de la République française ?",en:"What is one of the symbols of the French Republic?",o:["La rose","Marianne","Le lion","L'aigle"],a:1,x:"Marianne — the female allegory of the Republic. Har Mairie mein uski bust hoti hai.",c:"Valeurs",t:"CR"},
{q:"Le principe d'égalité signifie que :",en:"The principle of equality means:",o:["Les hommes ont plus de droits","Tous les citoyens ont les mêmes droits","Seuls les Français ont des droits","Les riches ont plus de droits"],a:1,x:"Everyone has the same rights before the law. Kanoon ke saamne sab barabar!",c:"Valeurs",t:"CR"},
{q:"A-t-on le droit d'insulter publiquement quelqu'un parce qu'il est différent ?",en:"Can you publicly insult someone because they are different?",o:["Oui, c'est la liberté d'expression","Non, c'est interdit par la loi","Oui, si c'est une blague","Seulement sur internet"],a:1,x:"NO — discrimination and insults based on difference are punishable by law!",c:"Valeurs",t:"Both"},
{q:"Certains métiers peuvent-ils être réservés aux hommes ?",en:"Can certain jobs be reserved for men?",o:["Oui, les métiers dangereux","Oui, les métiers militaires","Non, tous les métiers sont ouverts","Oui, avec autorisation"],a:2,x:"No job can be reserved for men only. Gender equality is constitutional!",c:"Valeurs",t:"CR"},
{q:"De quand date la Constitution de la Ve République ?",en:"When does the 5th Republic Constitution date from?",o:["1789","1905","1946","1958"],a:3,x:"1958 — De Gaulle founded the 5th Republic. Remember: '58 = Fifth Republic!'",c:"Valeurs",t:"CR"},
{q:"Quel animal est un symbole de la France ?",en:"What animal is a symbol of France?",o:["L'aigle","Le lion","Le coq","Le cheval"],a:2,x:"Le Coq Gaulois (Gallic Rooster) — symbol of vigilance since ancient Gaul!",c:"Valeurs",t:"CR"},
{q:"Quel est le nom de l'hymne national ?",en:"What is the name of the national anthem?",o:["L'Internationale","La Parisienne","La Marseillaise","Le Chant du Départ"],a:2,x:"La Marseillaise — written in 1792. You hear it at every football match!",c:"Valeurs",t:"Both"},
{q:"Quel symbole de la République est tricolore ?",en:"Which Republic symbol is tricolor?",o:["Marianne","Le drapeau","Le coq","La devise"],a:1,x:"Le Drapeau — blue, white, red. Blue+Red = Paris, White = monarchy. Together = Republic!",c:"Valeurs",t:"CR"},
{q:"Quelle est la date de la fête nationale française ?",en:"What is the date of the French national holiday?",o:["1er janvier","8 mai","14 juillet","11 novembre"],a:2,x:"14 juillet — Bastille Day! Fireworks everywhere!",c:"Valeurs",t:"CR"},
{q:"Quelle est la langue officielle de la République ?",en:"What is the official language of the Republic?",o:["L'anglais","Le français","Le latin","Pas de langue officielle"],a:1,x:"French — Article 2 of the Constitution. Isliye French seekhna zaroori hai!",c:"Valeurs",t:"Both"},
{q:"Quelle liberté permet à chacun d'exprimer ses idées ?",en:"What freedom allows expressing ideas?",o:["Liberté de circulation","Liberté d'expression","Liberté de commerce","Liberté religieuse"],a:1,x:"Liberté d'expression — express freely BUT with limits (no hate speech)!",c:"Valeurs",t:"CR"},
{q:"Quelles sont les couleurs du drapeau français ?",en:"What are the colors of the French flag?",o:["Rouge, blanc, noir","Bleu, blanc, rouge","Vert, blanc, rouge","Bleu, jaune, rouge"],a:1,x:"Bleu, Blanc, Rouge — like India's tiranga, France ka bhi 3 colors!",c:"Valeurs",t:"CR"},
{q:"Qu'est-ce que la Marseillaise ?",en:"What is La Marseillaise?",o:["Un monument","L'hymne national","Un musée","Une loi"],a:1,x:"The national anthem, written in 1792 during Revolutionary wars.",c:"Valeurs",t:"Both"},
{q:"Qui est Marianne ?",en:"Who is Marianne?",o:["Une reine historique","L'allégorie de la République","La première présidente","Une sainte"],a:1,x:"Marianne = allegory of the Republic. Her face is on stamps and in every Mairie.",c:"Valeurs",t:"Both"},
{q:"Une personne peut-elle changer librement de religion ?",en:"Can a person freely change religion?",o:["Non, c'est interdit","Oui, librement","Avec autorisation","Seulement une fois"],a:1,x:"YES, freely! Freedom of conscience. Koi restriction nahi!",c:"Valeurs",t:"Both"},
{q:"Que garantit la liberté d'expression ?",en:"What does freedom of expression guarantee?",o:["Le droit de voter","Le droit d'exprimer ses idées","Le droit de circuler","Le droit au logement"],a:1,x:"The right to express your ideas — but NOT hate speech!",c:"Valeurs",t:"CSP"},
{q:"À quoi sert un titre de séjour ?",en:"What is a residence permit for?",o:["Voyager à l'étranger","Autoriser le séjour en France","Voter aux élections","Obtenir la nationalité"],a:1,x:"Authorizes legal stay in France. Your most important document!",c:"Valeurs",t:"CSP"},
{q:"La liberté de circulation permet de :",en:"Freedom of movement allows:",o:["Conduire sans permis","Se déplacer librement","Ne pas payer les transports","Voyager sans passeport"],a:1,x:"Move freely within the territory. Live wherever you want in France!",c:"Valeurs",t:"CSP"},
{q:"La répudiation de sa femme est :",en:"Repudiation of one's wife is:",o:["Autorisée","Légale avec accord","Interdite en France","Possible après 10 ans"],a:2,x:"FORBIDDEN. Divorce must go through courts with equal rights for both.",c:"Valeurs",t:"CSP"},
{q:"Peut-on brûler publiquement un drapeau français ?",en:"Can you publicly burn a French flag?",o:["Oui, liberté d'expression","Non, c'est un délit","Oui, lors de manifs","Le 14 juillet seulement"],a:1,x:"NO — criminal offense! The flag is a protected national symbol.",c:"Valeurs",t:"CSP"},
{q:"Qu'est-ce que la liberté ?",en:"What is liberty?",o:["Faire tout ce qu'on veut","Ce qui ne nuit pas à autrui","Ne pas respecter les lois","Vivre sans règles"],a:1,x:"Doing anything that doesn't harm others. 'My freedom ends where yours begins.'",c:"Valeurs",t:"CSP"},
{q:"Parmi ces propositions, laquelle est une participation citoyenne ?",en:"Which is civic participation?",o:["Regarder la TV","Voter aux élections","Aller au cinéma","Faire du sport"],a:1,x:"Voting! Also: joining associations, volunteering. Active citizenship!",c:"Valeurs",t:"CSP"},
{q:"En quelle année la loi de séparation des Églises et de l'État a-t-elle été votée ?",en:"When was the Church-State separation law voted?",o:["1789","1848","1905","1958"],a:2,x:"1905! Memory: '19-05 = 1 Nation, 9-to-5 Secular, 0 religion in state, 5 freedoms.'",c:"Valeurs",t:"Both"},
{q:"Une personne a-t-elle le droit de ne pas croire en une religion ?",en:"Does a person have the right to not believe?",o:["Non, une religion est obligatoire","Oui, liberté de conscience","Seulement les Français","Non, interdit"],a:1,x:"YES — freedom of conscience includes the right to NOT believe!",c:"Valeurs",t:"Both"},
{q:"Quel droit est garanti par la laïcité ?",en:"What right is guaranteed by laïcité?",o:["Droit au travail","Liberté de conscience et de culte","Droit au logement","Liberté de commerce"],a:1,x:"Freedom of conscience AND worship. Laïcité protects ALL beliefs.",c:"Valeurs",t:"Both"},
{q:"À l'école publique, qui peut porter des signes religieux très visibles ?",en:"In public schools, who can wear conspicuous religious symbols?",o:["Les enseignants","Les élèves","Personne","Les parents"],a:2,x:"NOBODY. Public school = neutral space. But as visitor at Préfecture, you CAN wear them.",c:"Valeurs",t:"Both"},
{q:"Qui doit respecter la neutralité religieuse dans une préfecture ?",en:"Who must respect religious neutrality at a prefecture?",o:["Les usagers","Les agents publics","Personne","Les élus"],a:1,x:"PUBLIC AGENTS must be neutral. But YOU as a visitor can wear whatever you want!",c:"Valeurs",t:"Both"},
{q:"Que garantit le principe de laïcité ?",en:"What does laïcité guarantee?",o:["Primauté d'une religion","Liberté de croire ou ne pas croire","Interdiction des religions","Financement des églises"],a:1,x:"Freedom to believe OR not believe. Protection for ALL beliefs!",c:"Valeurs",t:"CSP"},
{q:"Que dit l'article 1er de la Constitution ?",en:"What does Article 1 say?",o:["La France est une monarchie","République indivisible, laïque, démocratique et sociale","Empire","Fédération"],a:1,x:"Four key words: indivisible, laïque, démocratique, sociale. Learn them!",c:"Valeurs",t:"CSP"},
{q:"Pourquoi la laïcité doit-elle être respectée à l'école ?",en:"Why must laïcité be respected at school?",o:["Interdire les religions","Protéger la neutralité et l'égalité","Favoriser l'athéisme","Punir les élèves"],a:1,x:"To protect neutrality and equality. Safe space for ALL children!",c:"Valeurs",t:"Both"},
{q:"Le régime de la France est :",en:"France's regime is:",o:["Une monarchie","Une dictature","Une République","Un empire"],a:2,x:"A Republic! 5th Republic since 1958. Democracy hai bhai!",c:"Valeurs",t:"Both"},
{q:"Qui nomme le Premier ministre ?",en:"Who appoints the Prime Minister?",o:["Le peuple","Le Président de la République","Le Sénat","L'Assemblée nationale"],a:1,x:"The PRESIDENT appoints the PM. PM is NOT elected! Classic exam trap.",c:"Institutions",t:"Both"},
{q:"Le Parlement est composé :",en:"Parliament is composed of:",o:["Du Président et du Sénat","De l'Assemblée nationale et du Sénat","Du Gouvernement et Sénat","De l'Assemblée et du Président"],a:1,x:"Assemblée Nationale + Sénat = Parliament. Like Lok Sabha + Rajya Sabha!",c:"Institutions",t:"Both"},
{q:"Qu'est-ce que le pouvoir exécutif ?",en:"What is executive power?",o:["Faire les lois","Appliquer les lois","Juger","Voter"],a:1,x:"Power to APPLY laws. Held by President + Government.",c:"Institutions",t:"CR"},
{q:"Qu'est-ce que le pouvoir législatif ?",en:"What is legislative power?",o:["Juger","Arrêter","Faire les lois","Appliquer les lois"],a:2,x:"Power to MAKE laws. Held by Parliament. L for Laws, L for Législatif!",c:"Institutions",t:"CSP"},
{q:"A-t-on le droit de ne pas respecter une loi ?",en:"Can you disobey a law?",o:["Oui, si on n'est pas d'accord","Non, la loi s'impose à tous","Oui, pour les étrangers","Seulement les vieilles lois"],a:1,x:"NO — the law applies to EVERYONE. Disagreement ≠ disobedience!",c:"Institutions",t:"CR"},
{q:"Que se passe-t-il si un ministre ne respecte pas la loi ?",en:"What if a minister breaks the law?",o:["Rien, il est protégé","Il est jugé comme tout citoyen","Il est pardonné","Il démissionne"],a:1,x:"Judged like ANY citizen! Nobody is above the law. État de droit!",c:"Institutions",t:"Both"},
{q:"Combien de députés composent l'Assemblée nationale ?",en:"How many deputies in the National Assembly?",o:["300","450","577","650"],a:2,x:"577 deputies! Elected for 5 years by direct universal suffrage.",c:"Institutions",t:"Both"},
{q:"Qui peut voter aux élections ?",en:"Who can vote?",o:["Tous les résidents","Les citoyens français majeurs","Les étrangers avec titre","Tout le monde"],a:1,x:"French citizens aged 18+ on electoral lists. For EU elections: EU citizens too.",c:"Institutions",t:"Both"},
{q:"Pour combien de temps sont élus les sénateurs ?",en:"How long are senators elected for?",o:["4 ans","5 ans","6 ans","7 ans"],a:2,x:"6 years! Elected indirectly. Remember: Senate = Six!",c:"Institutions",t:"Both"},
{q:"Quels sont les trois pouvoirs ?",en:"What are the three powers?",o:["Militaire, religieux, civil","Législatif, exécutif, judiciaire","Présidentiel, royal, populaire","National, régional, local"],a:1,x:"Législatif, Exécutif, Judiciaire. The trinity of democracy!",c:"Institutions",t:"Both"},
{q:"Est-ce que le président a tous les pouvoirs ?",en:"Does the President have all powers?",o:["Oui, chef suprême","Non, pouvoirs séparés","Oui, sauf judiciaire","Non, seulement militaire"],a:1,x:"NO — powers are separated. Checks and balances!",c:"Institutions",t:"Both"},
{q:"Qui est le préfet ?",en:"Who is the prefect?",o:["Le maire du département","Le représentant de l'État","Un juge","Un député"],a:1,x:"State's representative in each department. Like a District Collector!",c:"Institutions",t:"Both"},
{q:"Quelle condition pour voter ?",en:"What condition to vote?",o:["Avoir un emploi","Être inscrit sur les listes","Avoir un diplôme","Être propriétaire"],a:1,x:"Being REGISTERED on electoral lists! Do it at your Mairie.",c:"Institutions",t:"Both"},
{q:"Qui dirige la commune ?",en:"Who leads the municipality?",o:["Le préfet","Le député","Le maire","Le sénateur"],a:2,x:"Le Maire! Elected for 6 years. Your local admin hub!",c:"Institutions",t:"Both"},
{q:"Quel est le régime politique ?",en:"What is France's political regime?",o:["Monarchie constitutionnelle","République démocratique","Empire","Dictature"],a:1,x:"Democratic Republic — 5th Republic since 1958.",c:"Institutions",t:"Both"},
{q:"Qu'est-ce que l'Hôtel de Matignon ?",en:"What is Hôtel de Matignon?",o:["Un hôtel de luxe","Résidence du Premier ministre","Un musée","Le Parlement"],a:1,x:"PM's office! Élysée = President, Matignon = PM. Don't mix them!",c:"Institutions",t:"CSP"},
{q:"Quel est le rôle du Premier ministre ?",en:"What is the PM's role?",o:["Chef de l'État","Diriger l'action du gouvernement","Président du Sénat","Chef de l'armée"],a:1,x:"Directs government action. PM = COO of France!",c:"Institutions",t:"Both"},
{q:"Combien y a-t-il de régions ?",en:"How many regions?",o:["13","18","22","27"],a:1,x:"18 total (13 metro + 5 overseas). Like 18 'states'!",c:"Institutions",t:"Both"},
{q:"Depuis quand l'euro est-il la monnaie ?",en:"Since when is the euro the currency?",o:["1999","2000","2002","2005"],a:2,x:"2002 — euro coins/notes replaced the Franc!",c:"Institutions",t:"Both"},
{q:"Combien y a-t-il de départements ?",en:"How many departments?",o:["96","101","110","89"],a:1,x:"101 departments. Each has a Préfet and a Conseil Départemental.",c:"Institutions",t:"CR"},
{q:"Qui réside au palais de l'Élysée ?",en:"Who lives at the Élysée Palace?",o:["Le Premier ministre","Le Président de la République","Le Président du Sénat","Le maire de Paris"],a:1,x:"The PRESIDENT. Élysée = President, Matignon = PM.",c:"Institutions",t:"CR"},
{q:"Pour combien de temps est élu le président ?",en:"How long is the President elected for?",o:["4 ans","5 ans","6 ans","7 ans"],a:1,x:"5 years (quinquennat). Can be re-elected once. Max = 10 years.",c:"Institutions",t:"CR"},
{q:"Que signifie suffrage universel ?",en:"What does universal suffrage mean?",o:["Seuls les hommes votent","Tous les citoyens majeurs votent","Seuls les riches votent","Le président choisit"],a:1,x:"ALL adult citizens can vote. Everyone's voice counts!",c:"Institutions",t:"CR"},
{q:"Qui sanctionne l'auteur d'un vol ?",en:"Who sanctions a thief?",o:["Le président","Le maire","L'autorité judiciaire","La police"],a:2,x:"JUDICIAL authority. Police arrests, only judges sentence!",c:"Institutions",t:"Both"},
{q:"Qui vote les lois ?",en:"Who votes on laws?",o:["Le président","Le Parlement","Les citoyens","Le gouvernement"],a:1,x:"PARLIAMENT. Government proposes, Parliament votes!",c:"Institutions",t:"CR"},
{q:"Est-ce que le vote est obligatoire ?",en:"Is voting mandatory?",o:["Oui, avec amende","Non, c'est un droit et un devoir","Oui, toujours","Seulement pour les hommes"],a:1,x:"NO — right and duty, but not mandatory. Please DO vote though!",c:"Institutions",t:"CSP"},
{q:"Qui dirige l'action du Gouvernement ?",en:"Who directs government action?",o:["Le Président","Le Premier ministre","Le Sénat","L'Assemblée"],a:1,x:"The PRIME MINISTER. Article 21 of the Constitution.",c:"Institutions",t:"CSP"},
{q:"Si le Président décède, qui assure l'intérim ?",en:"If the President dies, who takes over?",o:["Le Premier Ministre","Le Président du Sénat","Le Président de l'Assemblée","Le Ministre de l'Intérieur"],a:1,x:"President of the SENATE — NOT the PM! Classic trick question!",c:"Institutions",t:"CSP"},
{q:"Quel État a quitté l'UE en 2020 ?",en:"Which state left the EU in 2020?",o:["La Suisse","Le Royaume-Uni","La Norvège","L'Islande"],a:1,x:"United Kingdom — Brexit! Switzerland was never in the EU.",c:"Institutions",t:"CSP"},
{q:"Quel État n'est pas membre de l'UE ?",en:"Which state is NOT an EU member?",o:["L'Allemagne","La Suisse","L'Italie","L'Espagne"],a:1,x:"Switzerland! Despite being surrounded by EU countries.",c:"Institutions",t:"Both"},
{q:"Quand célèbre-t-on la journée de l'Europe ?",en:"When is Europe Day?",o:["1er janvier","8 mars","9 mai","14 juillet"],a:2,x:"May 9 — Schuman Declaration anniversary. 9 Mai = Europe Day!",c:"Institutions",t:"Both"},
{q:"Quel pays est fondateur de l'UE ?",en:"Which country is an EU founder?",o:["Royaume-Uni","La France","La Pologne","L'Espagne"],a:1,x:"France! 6 founders: France, Germany, Italy, Belgium, Netherlands, Luxembourg.",c:"Institutions",t:"Both"},
{q:"La peine de mort est :",en:"The death penalty is:",o:["Autorisée pour crimes graves","Abolie depuis 1981","En débat","Utilisée rarement"],a:1,x:"ABOLISHED since 1981! Under Mitterrand. It's in the Constitution now.",c:"Droits",t:"Both"},
{q:"Qu'est-ce que la Constitution ?",en:"What is the Constitution?",o:["Un journal","Le texte fondamental de l'État","Un roman","Un contrat de travail"],a:1,x:"The supreme law of France. Everything must conform to it!",c:"Droits",t:"Both"},
{q:"Que signifie la dignité humaine ?",en:"What does human dignity mean?",o:["Droit d'être riche","Respect dû à toute personne","Droit de commander","Droit de voyager"],a:1,x:"Respect owed to EVERY person. Cannot be taken away!",c:"Droits",t:"CSP"},
{q:"Qu'est-ce que le droit de grève ?",en:"What is the right to strike?",o:["Quitter son emploi","Arrêter le travail pour ses intérêts","Droit de crier","Droit de casser"],a:1,x:"Right to stop working to defend interests. Constitutional right!",c:"Droits",t:"CSP"},
{q:"Est-il toujours possible de divorcer ?",en:"Is divorce always possible?",o:["Non, c'est interdit","Oui, c'est un droit","Seulement pour les hommes","Avec autorisation religieuse"],a:1,x:"YES — divorce is a right for both spouses. No religious authority needed!",c:"Droits",t:"Both"},
{q:"Le recours à l'avortement est-il autorisé ?",en:"Is abortion allowed?",o:["Non","Oui, c'est un droit","Avec accord du mari","Raisons médicales seulement"],a:1,x:"YES — constitutional right since 2024! Any woman can decide freely.",c:"Droits",t:"CSP"},
{q:"L'État peut-il limiter les droits ?",en:"Can the State limit rights?",o:["Non, jamais","Oui, pour l'intérêt général","Oui, sans raison","En guerre seulement"],a:1,x:"YES — to protect general interest. Your freedom ends where others' begins!",c:"Droits",t:"Both"},
{q:"Jeter un mégot par terre est :",en:"Throwing a cigarette butt is:",o:["Normal","Une infraction","Autorisé dans la rue","Sans conséquence"],a:1,x:"An offense — €135 fine! Littering is illegal in France.",c:"Droits",t:"CSP"},
{q:"Que doit faire une victime de violences ?",en:"What must a violence victim do?",o:["Rien","Porter plainte","Se venger","Quitter le pays"],a:1,x:"File a complaint with police/gendarmerie! Call 3919 for domestic violence.",c:"Droits",t:"Both"},
{q:"Quel est le rôle de la police ?",en:"What is the police's role?",o:["Faire les lois","Maintenir l'ordre et protéger","Juger","Collecter les impôts"],a:1,x:"Maintain order and protect people. They enforce but don't judge!",c:"Droits",t:"Both"},
{q:"Quelle est l'infraction la plus grave ?",en:"What is the most serious offense?",o:["Contravention","Délit","Crime","Amende"],a:2,x:"Crime > Délit > Contravention. Three levels of severity!",c:"Droits",t:"Both"},
{q:"De quelle année date la DDHC ?",en:"What year is the Declaration of Rights from?",o:["1789","1848","1905","1958"],a:0,x:"1789! Still the foundation of French rights today.",c:"Droits",t:"CR"},
{q:"Est-ce légal d'être marié à plusieurs personnes ?",en:"Is polygamy legal?",o:["Oui","Non, polygamie interdite","Avec autorisation","Seulement 2"],a:1,x:"NO — polygamy strictly forbidden. French law = monogamy only!",c:"Droits",t:"CR"},
{q:"En quelle année a débuté la Révolution française ?",en:"When did the French Revolution begin?",o:["1776","1789","1805","1848"],a:1,x:"1789! '17 years of abuse, 8 days of protest, 9 days of revolution.'",c:"Histoire",t:"Both"},
{q:"Quel roi a été exécuté pendant la Révolution ?",en:"Which king was executed?",o:["Louis XIV","Louis XV","Louis XVI","Napoléon"],a:2,x:"Louis XVI — guillotined January 1793. End of absolute monarchy!",c:"Histoire",t:"CSP"},
{q:"Qui était Napoléon Ier ?",en:"Who was Napoleon I?",o:["Un roi","Un empereur","Un président","Un pape"],a:1,x:"An EMPEROR — crowned 1804. Created the Civil Code still used today!",c:"Histoire",t:"Both"},
{q:"De quand date l'appel de De Gaulle ?",en:"When was De Gaulle's call to resistance?",o:["1939","18 juin 1940","1944","1958"],a:1,x:"June 18, 1940! From London via BBC. 'France has not lost the war!'",c:"Histoire",t:"CSP"},
{q:"Qu'est-ce que la Shoah ?",en:"What is the Shoah?",o:["Une guerre","Le génocide des Juifs","Une révolution","Un traité"],a:1,x:"Genocide of Jews during WWII. Essential memory for all French residents.",c:"Histoire",t:"Both"},
{q:"Quel pays a été colonisé par la France ?",en:"Which country was colonized by France?",o:["Le Japon","L'Algérie","Le Brésil","La Chine"],a:1,x:"Algeria (1830-1962). Also parts of Africa, Asia, Caribbean.",c:"Histoire",t:"Both"},
{q:"En 1944, qu'est-ce qui a changé pour les femmes ?",en:"In 1944, what changed for women?",o:["Droit de travailler","Droit de vote","Droit de divorcer","Droit de conduire"],a:1,x:"VOTING RIGHTS! April 21, 1944. Took 155 years after the Revolution!",c:"Histoire",t:"Both"},
{q:"Quelle peine supprimée en 1981 ?",en:"What punishment abolished in 1981?",o:["La prison","L'amende","La peine de mort","Le travail forcé"],a:2,x:"DEATH PENALTY — abolished under Mitterrand.",c:"Histoire",t:"CSP"},
{q:"En quelle année l'esclavage aboli définitivement ?",en:"When was slavery definitively abolished?",o:["1789","1848","1905","1944"],a:1,x:"1848 — Victor Schœlcher. Napoleon had brought it back after 1794 abolition.",c:"Histoire",t:"CR"},
{q:"Qui a fondé la Ve République ?",en:"Who founded the 5th Republic?",o:["Napoléon","De Gaulle","Mitterrand","Chirac"],a:1,x:"Charles de Gaulle in 1958. Strong presidential system!",c:"Histoire",t:"CR"},
{q:"Que célèbre-t-on le 14 juillet ?",en:"What is celebrated on July 14?",o:["Noël","La fête nationale","Fête du travail","Armistice"],a:1,x:"La Fête Nationale! Bastille 1789. Parade, fireworks, parties!",c:"Histoire",t:"CR"},
{q:"En quelle année WWI ?",en:"When did WWI begin?",o:["1905","1914","1918","1939"],a:1,x:"1914-1918. Armistice November 11 = public holiday.",c:"Histoire",t:"CSP"},
{q:"Que fête-t-on le 8 mai ?",en:"What is May 8?",o:["Fête du travail","Fin de la WWII","Fête nationale","Fête de la musique"],a:1,x:"End of WWII in Europe (1945)! Victory Day.",c:"Histoire",t:"CSP"},
{q:"Quel fleuve traverse Paris ?",en:"Which river flows through Paris?",o:["Le Rhône","La Loire","La Seine","La Garonne"],a:2,x:"La Seine! Left Bank vs Right Bank. Romantic river!",c:"Histoire",t:"Both"},
{q:"Quelle est la capitale de la France ?",en:"Capital of France?",o:["Lyon","Marseille","Paris","Strasbourg"],a:2,x:"Paris! 2.1 million people. Heart of France.",c:"Histoire",t:"CR"},
{q:"Quelle chaîne de montagnes entre France et Espagne ?",en:"Mountains between France and Spain?",o:["Les Alpes","Les Pyrénées","Le Jura","Les Vosges"],a:1,x:"Les Pyrénées! Alpes = France/Italy border.",c:"Histoire",t:"Both"},
{q:"Quel pays a une frontière avec la France ?",en:"Which country borders France?",o:["Le Portugal","L'Espagne","Le Royaume-Uni","La Pologne"],a:1,x:"Spain! France borders 8 countries!",c:"Histoire",t:"Both"},
{q:"Qui était Molière ?",en:"Who was Molière?",o:["Un roi","Un peintre","Un écrivain/dramaturge","Un général"],a:2,x:"Writer and playwright — France's Shakespeare! Still performed today.",c:"Histoire",t:"Both"},
{q:"Qu'est-ce que le Louvre ?",en:"What is the Louvre?",o:["Restaurant","Musée","Stade","Église"],a:1,x:"World's largest art museum! Mona Lisa lives here. 10M visitors/year!",c:"Histoire",t:"CR"},
{q:"Dans quelle ville la tour Eiffel ?",en:"Where is the Eiffel Tower?",o:["Lyon","Marseille","Paris","Nice"],a:2,x:"Paris! Built 1889. 330m tall. Most visited paid monument!",c:"Histoire",t:"CR"},
{q:"Combien de républiques en France ?",en:"How many republics has France had?",o:["3","4","5","6"],a:2,x:"FIVE! Current = 5th Republic since 1958.",c:"Histoire",t:"CR"},
{q:"Quel était le surnom de Louis XIV ?",en:"Louis XIV's nickname?",o:["Le Roi Soleil","Le Roi Guerrier","Le Bon Roi","Le Roi Sage"],a:0,x:"Le Roi Soleil — Sun King! 72-year reign. Built Versailles.",c:"Histoire",t:"CSP"},
{q:"Quand WWII ?",en:"When was WWII?",o:["1914-1918","1939-1945","1950-1953","1870-1871"],a:1,x:"1939-1945! France occupied 1940, liberated 1944.",c:"Histoire",t:"CR"},
{q:"Quel océan borde l'ouest français ?",en:"Which ocean borders west France?",o:["Indien","Atlantique","Pacifique","Arctique"],a:1,x:"L'Océan Atlantique! From Brittany to Basque Country.",c:"Histoire",t:"CR"},
{q:"Quelle île dans l'océan Indien ?",en:"Which French island in the Indian Ocean?",o:["Guadeloupe","Martinique","La Réunion","Corse"],a:2,x:"La Réunion! Near Madagascar. Guadeloupe/Martinique = Caribbean.",c:"Histoire",t:"CSP"},
{q:"Population de la France en 2025 ?",en:"France's population in 2025?",o:["50 millions","60 millions","68 millions","80 millions"],a:2,x:"About 68 million! One of the most populated EU countries.",c:"Histoire",t:"CSP"},
{q:"Quel mariage est reconnu par l'État ?",en:"Which marriage is recognized by the State?",o:["Religieux","Civil","Traditionnel","Tous"],a:1,x:"Only CIVIL marriage at the Mairie is legal! Religious has no legal value.",c:"Société",t:"Both"},
{q:"Quel numéro pour le SAMU ?",en:"SAMU number?",o:["17","15","18","112"],a:1,x:"15 = SAMU. 17 = Police. 18 = Pompiers. 112 = European.",c:"Société",t:"CR"},
{q:"Quel numéro pour la police ?",en:"Police number?",o:["15","17","18","112"],a:1,x:"17 = Police/Gendarmerie. For danger and crimes!",c:"Société",t:"Both"},
{q:"Quel numéro pour les pompiers ?",en:"Fire department number?",o:["15","17","18","112"],a:2,x:"18 = Pompiers. Fires AND medical emergencies!",c:"Société",t:"CR"},
{q:"Durée légale du travail par semaine ?",en:"Legal weekly working time?",o:["30h","35h","39h","40h"],a:1,x:"35 hours! Overtime must be compensated. Know your rights!",c:"Société",t:"CR"},
{q:"Qu'est-ce que le SMIC ?",en:"What is SMIC?",o:["Un impôt","Le salaire minimum","Une aide","Un examen"],a:1,x:"Minimum wage. ~€1,801 gross/month in 2025. No employer can pay less!",c:"Société",t:"CR"},
{q:"Première démarche pour chercher un emploi ?",en:"First step for job search?",o:["Commissariat","France Travail","SAMU","Mairie"],a:1,x:"Register with France Travail! Job listings, training, benefits.",c:"Société",t:"CR"},
{q:"Une femme peut-elle créer son entreprise ?",en:"Can a woman create a business?",o:["Non","Oui, librement","Avec accord du mari","Certains secteurs"],a:1,x:"YES, freely! No husband's permission needed. Constitutional right!",c:"Société",t:"CR"},
{q:"À partir de quel âge un mineur peut-il travailler ?",en:"From what age can a minor work?",o:["14 ans","16 ans","18 ans","12 ans"],a:1,x:"16 (with conditions). Light work from 14 during holidays.",c:"Société",t:"CR"},
{q:"Concernant l'accès aux soins ?",en:"Healthcare access?",o:["Français seulement","Toute personne résidant en France","Salariés seulement","Riches seulement"],a:1,x:"EVERYONE residing in France! Universal coverage. Sab ke liye health!",c:"Société",t:"Both"},
{q:"À quoi sert la carte Vitale ?",en:"What is Carte Vitale for?",o:["Voter","Remboursement des soins","Voyager","Conduire"],a:1,x:"Healthcare reimbursements! Get it ASAP on arrival!",c:"Société",t:"CR"},
{q:"Jusqu'à quel âge l'école obligatoire ?",en:"Until what age is school mandatory?",o:["14 ans","16 ans","18 ans","21 ans"],a:1,x:"16 years old. But instruction mandatory from age 3!",c:"Société",t:"CR"},
{q:"Diplôme à la fin du lycée ?",en:"Diploma at end of high school?",o:["Brevet","Baccalauréat","Licence","Master"],a:1,x:"Le Baccalauréat (le Bac)! Key to university.",c:"Société",t:"CR"},
{q:"À quel âge commence l'instruction obligatoire ?",en:"Mandatory education starts at?",o:["3 ans","5 ans","6 ans","7 ans"],a:0,x:"3 years old! Since 2019. One of the youngest ages in Europe.",c:"Société",t:"Both"},
{q:"Quel est l'âge de la majorité ?",en:"Age of majority?",o:["16","18","20","21"],a:1,x:"18! Vote, sign contracts, marry without parents, drive.",c:"Société",t:"CSP"},
{q:"Où déclarer une naissance ?",en:"Where to declare a birth?",o:["Hôpital","Mairie","Préfecture","Police"],a:1,x:"At the MAIRIE! Within 5 days. Births, marriages, deaths = Mairie.",c:"Société",t:"Both"},
{q:"Travailler sans être déclaré est :",en:"Working undeclared is:",o:["Normal","Interdit par la loi","Autorisé pour étrangers","Accepté"],a:1,x:"ILLEGAL! No social security, no rights. Both parties risk penalties.",c:"Société",t:"Both"},
{q:"Mission de France Travail ?",en:"France Travail's mission?",o:["Impôts","Aider les demandeurs d'emploi","Passeports","Écoles"],a:1,x:"Help job seekers! Register immediately when looking for work.",c:"Société",t:"CSP"},
{q:"Inscription à l'Assurance maladie ?",en:"Health insurance registration?",o:["Facultative","Obligatoire pour tous","Réservée aux Français","Payante"],a:1,x:"MANDATORY for all residents! Essential first step on arrival.",c:"Société",t:"CSP"},
{q:"Qui peut demander un congé parental ?",en:"Who can request parental leave?",o:["La mère seulement","Le père seulement","Les deux parents","L'employeur"],a:2,x:"BOTH parents! Gender equality in childcare too!",c:"Société",t:"CSP"},
{q:"Où inscrire son enfant à l'école publique ?",en:"Where to register child for school?",o:["Préfecture","Mairie","Commissariat","Hôpital"],a:1,x:"At the MAIRIE! Then go to the school for enrollment.",c:"Société",t:"CSP"},
{q:"Un bail locatif est valide si :",en:"A lease is valid if:",o:["Oral","Écrit et signé par les deux","Signé par le propriétaire seul","Approuvé par la mairie"],a:1,x:"Written and signed by BOTH parties. Always get it in writing!",c:"Société",t:"CSP"},
{q:"Les enfants qui ne parlent pas français :",en:"Children who don't speak French:",o:["Ne vont pas à l'école","Sont accueillis à l'école","Doivent attendre","Écoles spéciales"],a:1,x:"ARE welcomed at school! Language support provided. Every child has rights!",c:"Société",t:"CR"},
{q:"Étranger en situation régulière peut créer une entreprise :",en:"Legal foreigner can create a business:",o:["Jamais","Oui, librement","Après 10 ans","Autorisation spéciale"],a:1,x:"YES, freely! With valid titre de séjour. France encourages it!",c:"Société",t:"CR"},
{q:"Que doit faire un employeur pour le salaire ?",en:"What must employer do about salary?",o:["Payer ce qu'il veut","Respecter le SMIC","Demander au préfet","Consulter le maire"],a:1,x:"Respect the SMIC minimum! No employer can pay below. Know your rights!",c:"Société",t:"CR"},
{q:"En cas de divorce, qui a l'autorité parentale ?",en:"After divorce, who has parental authority?",o:["Le père","La mère","Les deux parents","Le juge"],a:2,x:"BOTH parents! Joint authority continues. Equal rights and duties.",c:"Société",t:"CSP"},
{q:"Où déposer un lave-vaisselle cassé ?",en:"Where to dispose of broken dishwasher?",o:["Trottoir","Déchetterie","Poubelle","Rivière"],a:1,x:"DÉCHETTERIE! Large items = waste center. Sidewalk = fine!",c:"Société",t:"CSP"},
];

const CATS=["Valeurs","Institutions","Droits","Histoire","Société"];
const CN={Valeurs:"Principes & Valeurs",Institutions:"Institutions & Politique",Droits:"Droits & Devoirs",Histoire:"Histoire, Géo & Culture",Société:"Vie en Société"};
const CI={Valeurs:"🇫🇷",Institutions:"🏛️",Droits:"⚖️",Histoire:"📚",Société:"🏠"};
const HACKS=[
  {t:"France Travail",tip:"Register IMMEDIATELY when looking for work or if you lose your job. First step for unemployment benefits!",i:"💼"},
  {t:"Navigo 2026",tip:"€90.80/month. Employer MUST pay 50% = €45.40 for you. On RSA? Get 50-100% off via Solidarity Transport!",i:"🚇"},
  {t:"APL Alert",tip:"From July 2026, non-scholarship non-EU students lose APL (€100-250/month). Apply BEFORE the cutoff!",i:"🏠"},
  {t:"Naturalization",tip:"Tax stamp: €55 → €255 (364% increase!). File your dossier ASAP if eligible (5yr residency).",i:"📜"},
  {t:"Carte Vitale",tip:"Get your Numéro de Sécurité Sociale immediately. No number = no Carte Vitale = no reimbursements!",i:"🏥"},
  {t:"Emergency",tip:"15=SAMU, 17=Police, 18=Pompiers, 112=European, 3919=Violence. Helping someone in danger = civic OBLIGATION!",i:"🚨"},
  {t:"Address",tip:"Update address at Préfecture within 3 months when you move. Also update CAF and taxes!",i:"📫"},
  {t:"Exam Day",tip:"40 MCQ, 45 minutes, need 32/40 (80%). Digital test at CCI testing centers. Aasaan Hai!",i:"✅"},
];
const TL=[
  {y:1789,e:"French Revolution / Bastille",m:"🔥"},{y:1789,e:"Declaration of Rights of Man",m:"📜"},
  {y:1792,e:"First Republic",m:"🏛️"},{y:1804,e:"Napoléon Emperor",m:"👑"},
  {y:1848,e:"Slavery abolished",m:"⛓️"},{y:1882,e:"Free mandatory school",m:"🏫"},
  {y:1905,e:"Laïcité law",m:"⚖️"},{y:1914,e:"WWI begins",m:"💣"},
  {y:1940,e:"De Gaulle's call",m:"📻"},{y:1944,e:"Women vote",m:"🗳️"},
  {y:1945,e:"WWII ends / UN created",m:"🕊️"},{y:1957,e:"Treaty of Rome / EEC",m:"🇪🇺"},
  {y:1958,e:"5th Republic (De Gaulle)",m:"🏛️"},{y:1962,e:"Direct presidential vote",m:"🗳️"},
  {y:1975,e:"Abortion legalized (Veil)",m:"⚕️"},{y:1981,e:"Death penalty abolished",m:"🕊️"},
  {y:2002,e:"Euro currency",m:"💶"},{y:2024,e:"Immigration law / Abortion in Constitution",m:"📋"},
  {y:2026,e:"Mandatory Civic Exam begins",m:"✅"},
];

function shuffle(a){const b=[...a];for(let i=b.length-1;i>0;i--){const j=0|Math.random()*(i+1);[b[i],b[j]]=[b[j],b[i]];}return b;}
const bg="#050505";

function Header({user,onBack}){
  return(<div style={{maxWidth:800,margin:"0 auto",display:"flex",justifyContent:"space-between",alignItems:"center",padding:"12px 0",borderBottom:"1px solid rgba(255,255,255,0.08)",marginBottom:8}}>
    <div style={{display:"flex",alignItems:"center",gap:10,cursor:onBack?"pointer":"default"}} onClick={onBack}>
      {onBack&&<span style={{fontSize:18}}>←</span>}
      <span style={{fontFamily:"Georgia,serif",fontWeight:700,fontSize:16}}><span style={{color:"#dc2626"}}>Mooni</span> <span style={{color:"#f59e0b"}}>Explains France</span></span>
    </div>
    {user&&<div style={{fontSize:12,fontFamily:"monospace"}}><span style={{color:"#737373"}}>Track:</span> <span style={{color:"#f59e0b"}}>{user.track}</span></div>}
  </div>);
}

function SubscribePage({onUnlock}){
  const [step,setStep]=useState(0);const [vis,setVis]=useState(false);
  useEffect(()=>{setTimeout(()=>setVis(true),100);},[]);
  return(<div style={{minHeight:"100vh",display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:16,position:"relative",overflow:"hidden",background:`linear-gradient(160deg,${bg} 0%,#1a0000 50%,${bg} 100%)`,color:"#fff"}}>
    <div style={{position:"absolute",inset:0,background:"radial-gradient(ellipse at 50% 0%,rgba(220,38,38,0.12) 0%,transparent 60%)",pointerEvents:"none"}}/>
    <div style={{position:"absolute",top:0,left:0,right:0,height:2,background:"linear-gradient(90deg,transparent,#dc2626,#f59e0b,#dc2626,transparent)"}}/>
    <div style={{transition:"all 0.8s cubic-bezier(0.16,1,0.3,1)",opacity:vis?1:0,transform:vis?"translateY(0)":"translateY(30px)",textAlign:"center",zIndex:1,maxWidth:520,width:"100%",padding:16}}>
      <div style={{fontSize:72,marginBottom:12}}>🇫🇷</div>
      <h1 style={{fontFamily:"Georgia,serif",fontSize:"clamp(1.8rem,5vw,3rem)",fontWeight:900,lineHeight:1.1,marginBottom:8}}>
        <span>Mooni Explains </span><span style={{background:"linear-gradient(135deg,#dc2626,#f59e0b)",WebkitBackgroundClip:"text",WebkitTextFillColor:"transparent"}}>France</span>
      </h1>
      <p style={{color:"#f59e0b",fontFamily:"monospace",fontSize:12,letterSpacing:4,marginBottom:20}}>FRANCE KI KAHANI • EXAMEN CIVIQUE 2026</p>
      <p style={{color:"#a3a3a3",maxWidth:420,margin:"0 auto 28px",fontSize:15,lineHeight:1.7}}>
        Practice <strong style={{color:"#fff"}}>{Q.length}+ official questions</strong>. Pass with <strong style={{color:"#dc2626"}}>80%</strong>. Get your CSP / CR / Naturalization.
      </p>
      <div style={{display:"flex",gap:8,justifyContent:"center",flexWrap:"wrap",marginBottom:28}}>
        {["🌐 Bilingual FR↔EN","⏱️ 45-min Timer","🔍 Weak Analysis","🇮🇳 Hindi+EN"].map((b,i)=>
          <span key={i} style={{background:"rgba(255,255,255,0.05)",border:"1px solid rgba(255,255,255,0.1)",borderRadius:8,padding:"5px 12px",fontSize:11,color:"#d4d4d4"}}>{b}</span>
        )}
      </div>
      {step===0?<button onClick={()=>{window.open("https://www.youtube.com/@mooniexplainsfrance","_blank");setStep(1);}} style={{background:"linear-gradient(135deg,#dc2626,#b91c1c)",color:"#fff",border:"none",padding:"18px 44px",borderRadius:50,fontSize:17,fontWeight:700,cursor:"pointer",boxShadow:"0 0 40px rgba(220,38,38,0.3)"}}>
        ▶ Subscribe on YouTube to Unlock
      </button>
      :step===1?<div style={{display:"flex",flexDirection:"column",alignItems:"center",gap:12}}>
        <p style={{color:"#10b981",fontWeight:600}}>✅ Did you subscribe?</p>
        <div style={{display:"flex",gap:10,flexWrap:"wrap",justifyContent:"center"}}>
          <button onClick={()=>setStep(2)} style={{background:"#fff",color:"#000",border:"none",padding:"14px 32px",borderRadius:50,fontSize:15,fontWeight:700,cursor:"pointer"}}>Yes, I Subscribed! 🎉</button>
          <button onClick={()=>window.open("https://www.youtube.com/@mooniexplainsfrance","_blank")} style={{background:"rgba(255,255,255,0.08)",color:"#fff",border:"1px solid rgba(255,255,255,0.15)",padding:"14px 24px",borderRadius:50,fontSize:14,fontWeight:600,cursor:"pointer"}}>Open Channel Again</button>
        </div>
      </div>
      :<RegForm onDone={onUnlock}/>}
    </div>
  </div>);
}

function RegForm({onDone}){
  const [n,sN]=useState("");const [e,sE]=useState("");const [t,sT]=useState("CSP");
  const ok=n.trim()&&e.trim();
  const I={width:"100%",background:"rgba(255,255,255,0.06)",border:"1px solid rgba(255,255,255,0.12)",borderRadius:10,padding:"12px 16px",color:"#fff",fontSize:15,marginBottom:14,outline:"none",boxSizing:"border-box"};
  return(<div style={{background:"rgba(255,255,255,0.03)",border:"1px solid rgba(255,255,255,0.1)",borderRadius:16,padding:28,maxWidth:400,margin:"16px auto 0"}}>
    <h2 style={{fontSize:20,fontWeight:700,marginBottom:4}}>🎯 You're In!</h2>
    <p style={{color:"#737373",fontSize:13,marginBottom:18}}>Set up your profile</p>
    <input value={n} onChange={v=>sN(v.target.value)} placeholder="Your Name" style={I}/>
    <input value={e} onChange={v=>sE(v.target.value)} placeholder="Email" type="email" style={I}/>
    <label style={{display:"block",fontSize:12,color:"#737373",marginBottom:6}}>Track:</label>
    <select value={t} onChange={v=>sT(v.target.value)} style={{...I,marginBottom:18}}>
      <option value="CSP">CSP — Multi-year Permit (A2)</option>
      <option value="CR">CR — Resident Card (B1)</option>
      <option value="NAT">Naturalization (B2)</option>
    </select>
    <button disabled={!ok} onClick={()=>onDone({name:n,email:e,track:t})} style={{width:"100%",background:ok?"#fff":"#333",color:ok?"#000":"#666",border:"none",padding:"14px 0",borderRadius:10,fontSize:16,fontWeight:700,cursor:ok?"pointer":"not-allowed"}}>Start Practicing →</button>
  </div>);
}

function Dash({user,go}){
  const tQ=Q.filter(q=>q.t===user.track||q.t==="Both");
  return(<div style={{minHeight:"100vh",padding:16,background:bg,color:"#fff"}}>
    <Header user={user}/>
    <div style={{maxWidth:800,margin:"0 auto"}}>
      <div style={{textAlign:"center",padding:"24px 0 16px"}}>
        <h2 style={{fontSize:22,fontWeight:800,marginBottom:6}}>Namaste, {user.name}! 🙏</h2>
        <p style={{color:"#a3a3a3",fontSize:13}}>{user.track} Track • {tQ.length} questions • Need 80% to pass</p>
      </div>
      <button onClick={()=>go("quiz","full")} style={{width:"100%",background:"linear-gradient(135deg,#dc2626,#b91c1c)",color:"#fff",border:"none",padding:18,borderRadius:14,fontSize:17,fontWeight:700,cursor:"pointer",marginBottom:20,boxShadow:"0 4px 30px rgba(220,38,38,0.25)",display:"flex",alignItems:"center",justifyContent:"center",gap:8}}>
        🎯 Full Exam (40Q • 45 min)
      </button>
      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:10,marginBottom:20}}>
        <button onClick={()=>go("tl")} style={cBtn}><span style={{fontSize:24}}>📅</span><b>Timeline</b><span style={{fontSize:11,color:"#737373"}}>Key dates</span></button>
        <button onClick={()=>go("hk")} style={cBtn}><span style={{fontSize:24}}>💡</span><b>Daily Hacks</b><span style={{fontSize:11,color:"#737373"}}>Admin tips</span></button>
      </div>
      <p style={{fontSize:12,color:"#525252",letterSpacing:2,textTransform:"uppercase",fontFamily:"monospace",fontWeight:700,marginBottom:8}}>By Category</p>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(140px,1fr))",gap:8,marginBottom:20}}>
        {CATS.map(c=>{const n=Q.filter(q=>(q.t===user.track||q.t==="Both")&&q.c===c).length;return(
          <button key={c} onClick={()=>go("quiz",c)} style={{...cBtn,padding:14}}><span style={{fontSize:22}}>{CI[c]}</span><b style={{fontSize:13}}>{CN[c]}</b><span style={{fontSize:11,color:"#737373"}}>{n}Q</span></button>
        );})}
      </div>
      <div style={{background:"rgba(245,158,11,0.08)",border:"1px solid rgba(245,158,11,0.12)",borderRadius:12,padding:14,textAlign:"center"}}>
        <p style={{fontSize:13,color:"#f59e0b",fontStyle:"italic"}}>"Logic clear hai toh residency pakki hai. Aasaan Hai!" 💪</p>
      </div>
    </div>
  </div>);
}
const cBtn={background:"rgba(255,255,255,0.03)",border:"1px solid rgba(255,255,255,0.08)",borderRadius:12,padding:18,cursor:"pointer",color:"#fff",display:"flex",flexDirection:"column",alignItems:"center",gap:4};

function Quiz({qs,user,mode,timer,onDone,onBack}){
  const [i,sI]=useState(0);const [sel,sS]=useState(null);const [show,sSh]=useState(false);
  const [res,sR]=useState([]);const [tl,sTl]=useState(timer?2700:null);
  const ref=useRef();const rr=useRef(res);rr.current=res;
  useEffect(()=>{if(!timer)return;ref.current=setInterval(()=>sTl(t=>{if(t<=1){clearInterval(ref.current);return 0;}return t-1;}),1000);return()=>clearInterval(ref.current);},[]);
  useEffect(()=>{if(tl===0&&timer)onDone(rr.current);},[tl]);
  const c=qs[i],tot=qs.length,ok=sel===c.a;
  const pick=j=>{if(sel!==null)return;sS(j);sSh(true);sR(p=>[...p,{...c,pick:j,ok:j===c.a}]);};
  const next=()=>{if(i+1>=tot){clearInterval(ref.current);onDone([...res]);return;}sI(i+1);sS(null);sSh(false);};
  const fmt=s=>`${String(0|s/60).padStart(2,"0")}:${String(s%60).padStart(2,"0")}`;
  return(<div style={{minHeight:"100vh",padding:16,background:bg,color:"#fff"}}>
    <Header user={user} onBack={()=>{clearInterval(ref.current);onBack();}}/>
    <div style={{maxWidth:640,margin:"0 auto",paddingTop:8}}>
      <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:8}}>
        <span style={{fontSize:12,fontFamily:"monospace",color:"#525252"}}>{mode==="full"?"EXAM":mode.toUpperCase()} • Q{i+1}/{tot}</span>
        {timer&&tl!=null&&<span style={{fontFamily:"monospace",fontSize:15,fontWeight:700,color:tl<300?"#dc2626":"#f59e0b",background:"rgba(255,255,255,0.05)",padding:"3px 10px",borderRadius:6}}>⏱{fmt(tl)}</span>}
      </div>
      <div style={{height:3,background:"rgba(255,255,255,0.06)",borderRadius:2,marginBottom:18,overflow:"hidden"}}><div style={{height:"100%",width:`${(i/tot)*100}%`,background:"linear-gradient(90deg,#dc2626,#f59e0b)",transition:"width 0.3s"}}/></div>
      <div style={{background:"rgba(255,255,255,0.03)",border:"1px solid rgba(255,255,255,0.1)",borderRadius:14,padding:22,marginBottom:12}}>
        <div style={{fontSize:11,color:"#404040",fontFamily:"monospace",marginBottom:4}}>{CN[c.c]||c.c} • {c.t}</div>
        <h3 style={{fontSize:16,fontWeight:700,lineHeight:1.5,marginBottom:4}}>{c.q}</h3>
        <p style={{fontSize:13,color:"#a3a3a3",marginBottom:18,fontStyle:"italic"}}>{c.en}</p>
        <div style={{display:"flex",flexDirection:"column",gap:8}}>
          {c.o.map((opt,j)=>{
            let b="rgba(255,255,255,0.04)",bd="1px solid rgba(255,255,255,0.1)";
            if(sel!=null){if(j===c.a){b="rgba(16,185,129,0.15)";bd="1px solid #10b981";}else if(j===sel&&!ok){b="rgba(220,38,38,0.15)";bd="1px solid #dc2626";}}
            return(<button key={j} onClick={()=>pick(j)} disabled={sel!=null} style={{background:b,border:bd,borderRadius:10,padding:"11px 14px",color:"#fff",fontSize:14,textAlign:"left",cursor:sel!=null?"default":"pointer",display:"flex",alignItems:"center",gap:10,transition:"all 0.15s"}}>
              <span style={{width:24,height:24,borderRadius:"50%",background:"rgba(255,255,255,0.08)",display:"flex",alignItems:"center",justifyContent:"center",fontSize:11,fontWeight:700,flexShrink:0}}>
                {sel!=null?(j===c.a?"✓":j===sel?"✗":String.fromCharCode(65+j)):String.fromCharCode(65+j)}
              </span>{opt}
            </button>);
          })}
        </div>
      </div>
      {show&&<div style={{background:ok?"rgba(16,185,129,0.08)":"rgba(220,38,38,0.08)",border:`1px solid ${ok?"rgba(16,185,129,0.25)":"rgba(220,38,38,0.25)"}`,borderRadius:12,padding:16,marginBottom:12}}>
        <div style={{fontSize:14,fontWeight:700,marginBottom:4,color:ok?"#10b981":"#dc2626"}}>{ok?"✅ Correct! Bahut Badhiya!":"❌ Galat — Let's Learn!"}</div>
        <p style={{fontSize:13,color:"#d4d4d4",lineHeight:1.7}}>{c.x}</p>
      </div>}
      {sel!=null&&<button onClick={next} style={{width:"100%",background:"#fff",color:"#000",border:"none",padding:13,borderRadius:10,fontSize:15,fontWeight:700,cursor:"pointer"}}>{i+1>=tot?"See Results →":"Next →"}</button>}
    </div>
  </div>);
}

function Results({res,user,onBack,onRetry}){
  const ok=res.filter(r=>r.ok).length,tot=res.length,pct=tot?Math.round(ok/tot*100):0,pass=pct>=80;
  const byC={};res.forEach(r=>{if(!byC[r.c])byC[r.c]={t:0,o:0};byC[r.c].t++;if(r.ok)byC[r.c].o++;});
  return(<div style={{minHeight:"100vh",padding:16,background:bg,color:"#fff"}}>
    <Header user={user} onBack={onBack}/>
    <div style={{maxWidth:640,margin:"0 auto",paddingTop:16,textAlign:"center"}}>
      <div style={{fontSize:52,marginBottom:6}}>{pass?"🎉":"💪"}</div>
      <h2 style={{fontSize:24,fontWeight:800,marginBottom:4}}>{pass?"Passed! Aasaan Hai!":"Keep Practicing!"}</h2>
      <p style={{color:"#a3a3a3",fontSize:13,marginBottom:24}}>{pass?"Ready for 2026!":"Need 80%. Focus on weak areas."}</p>
      <div style={{display:"flex",justifyContent:"center",gap:16,marginBottom:24,flexWrap:"wrap"}}>
        {[{l:"Score",v:`${pct}%`,c:pass?"#10b981":"#dc2626"},{l:"Correct",v:`${ok}/${tot}`,c:"#f59e0b"},{l:"Status",v:pass?"PASS":"FAIL",c:pass?"#10b981":"#dc2626"}].map((s,i)=>
          <div key={i} style={{display:"flex",flexDirection:"column",alignItems:"center",gap:4}}>
            <div style={{width:68,height:68,borderRadius:"50%",border:`3px solid ${s.c}`,display:"flex",alignItems:"center",justifyContent:"center",fontSize:17,fontWeight:800,color:s.c,fontFamily:"monospace"}}>{s.v}</div>
            <span style={{fontSize:11,color:"#737373"}}>{s.l}</span>
          </div>
        )}
      </div>
      <div style={{display:"flex",flexDirection:"column",gap:6,marginBottom:20,textAlign:"left"}}>
        {Object.entries(byC).map(([c,v])=>{const p=Math.round(v.o/v.t*100),w=p<70;return(
          <div key={c} style={{background:"rgba(255,255,255,0.03)",border:`1px solid ${w?"rgba(220,38,38,0.25)":"rgba(255,255,255,0.08)"}`,borderRadius:10,padding:"10px 14px",display:"flex",justifyContent:"space-between",alignItems:"center"}}>
            <span style={{fontSize:13,fontWeight:600}}>{CN[c]||c}{w?" ⚠️":""}</span>
            <div style={{display:"flex",alignItems:"center",gap:8}}>
              <div style={{width:60,height:4,background:"rgba(255,255,255,0.1)",borderRadius:2,overflow:"hidden"}}><div style={{height:"100%",width:`${p}%`,background:w?"#dc2626":"#10b981"}}/></div>
              <span style={{fontSize:12,fontWeight:700,color:w?"#dc2626":"#10b981",fontFamily:"monospace",width:32,textAlign:"right"}}>{p}%</span>
            </div>
          </div>
        );})}
      </div>
      <div style={{display:"flex",gap:10,marginBottom:24}}>
        <button onClick={onRetry} style={{flex:1,background:"#dc2626",color:"#fff",border:"none",padding:13,borderRadius:10,fontWeight:700,cursor:"pointer"}}>Retry</button>
        <button onClick={onBack} style={{flex:1,background:"rgba(255,255,255,0.08)",color:"#fff",border:"1px solid rgba(255,255,255,0.12)",padding:13,borderRadius:10,fontWeight:700,cursor:"pointer"}}>Dashboard</button>
      </div>
      <div style={{display:"flex",flexDirection:"column",gap:5,textAlign:"left",paddingBottom:28}}>
        {res.map((r,i)=><div key={i} style={{background:"rgba(255,255,255,0.02)",border:`1px solid ${r.ok?"rgba(16,185,129,0.12)":"rgba(220,38,38,0.12)"}`,borderRadius:8,padding:"8px 12px"}}>
          <div style={{display:"flex",justifyContent:"space-between",marginBottom:2}}><span style={{fontSize:10,color:"#404040"}}>Q{i+1}</span><span style={{fontSize:10,fontWeight:700,color:r.ok?"#10b981":"#dc2626"}}>{r.ok?"✓":"✗"}</span></div>
          <div style={{fontSize:12,fontWeight:600}}>{r.en}</div>
          {!r.ok&&<div style={{fontSize:11,color:"#737373",marginTop:2}}>You: <span style={{color:"#dc2626"}}>{r.o[r.pick]}</span> → <span style={{color:"#10b981"}}>{r.o[r.a]}</span></div>}
        </div>)}
      </div>
    </div>
  </div>);
}

function TLPage({onBack,user}){
  return(<div style={{minHeight:"100vh",padding:16,background:bg,color:"#fff"}}><Header user={user} onBack={onBack}/>
    <div style={{maxWidth:560,margin:"0 auto",paddingTop:16}}>
      <h2 style={{fontSize:20,fontWeight:800}}>📅 Key Dates</h2>
      <p style={{color:"#737373",fontSize:13,marginBottom:16}}>These WILL appear on the exam.</p>
      <div style={{position:"relative",paddingLeft:34}}>
        <div style={{position:"absolute",left:12,top:0,bottom:0,width:2,background:"linear-gradient(180deg,#dc2626,#f59e0b,#10b981)"}}/>
        {TL.map((t,i)=><div key={i} style={{position:"relative",marginBottom:14}}>
          <div style={{position:"absolute",left:-28,top:3,width:16,height:16,borderRadius:"50%",background:bg,border:"2px solid #f59e0b",display:"flex",alignItems:"center",justifyContent:"center",fontSize:8}}>{t.m}</div>
          <div style={{background:"rgba(255,255,255,0.03)",border:"1px solid rgba(255,255,255,0.08)",borderRadius:10,padding:"8px 12px",display:"flex",alignItems:"center",gap:10}}>
            <span style={{fontFamily:"monospace",fontSize:15,fontWeight:800,color:"#f59e0b",minWidth:40}}>{t.y}</span>
            <span style={{fontSize:12,color:"#d4d4d4"}}>{t.e}</span>
          </div>
        </div>)}
      </div>
    </div>
  </div>);
}

function HKPage({onBack,user}){
  return(<div style={{minHeight:"100vh",padding:16,background:bg,color:"#fff"}}><Header user={user} onBack={onBack}/>
    <div style={{maxWidth:560,margin:"0 auto",paddingTop:16}}>
      <h2 style={{fontSize:20,fontWeight:800}}>💡 2026 Survival Hacks</h2>
      <p style={{color:"#737373",fontSize:13,marginBottom:16}}>Save money, stay legal!</p>
      {HACKS.map((h,i)=><div key={i} style={{background:"rgba(255,255,255,0.03)",border:"1px solid rgba(255,255,255,0.08)",borderRadius:12,padding:16,marginBottom:10}}>
        <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:6}}><span style={{fontSize:22}}>{h.i}</span><b style={{fontSize:14}}>{h.t}</b></div>
        <p style={{fontSize:13,color:"#a3a3a3",lineHeight:1.6}}>{h.tip}</p>
      </div>)}
    </div>
  </div>);
}

function App(){
  const [scr,sScr]=useState("sub");const [user,sU]=useState(null);
  const [qzQ,sQQ]=useState([]);const [qzM,sQM]=useState("full");const [qzT,sQT]=useState(false);const [qzR,sQR]=useState([]);
  const go=(s,m)=>{
    if(s==="quiz"){
      const tr=user?.track||"CSP";let qs;
      if(m==="full"){qs=shuffle(Q.filter(q=>q.t===tr||q.t==="Both")).slice(0,40);sQT(true);}
      else{qs=shuffle(Q.filter(q=>(q.t===tr||q.t==="Both")&&q.c===m));sQT(false);}
      if(!qs.length)return;sQQ(qs);sQM(m);sScr("quiz");
    }else sScr(s);
  };
  switch(scr){
    case "sub":return<SubscribePage onUnlock={u=>{sU(u);sScr("dash");}}/>;
    case "dash":return<Dash user={user} go={go}/>;
    case "quiz":return<Quiz qs={qzQ} user={user} mode={qzM} timer={qzT} onDone={r=>{sQR(r);sScr("res");}} onBack={()=>sScr("dash")}/>;
    case "res":return<Results res={qzR} user={user} onBack={()=>sScr("dash")} onRetry={()=>go("quiz",qzM)}/>;
    case "tl":return<TLPage user={user} onBack={()=>sScr("dash")}/>;
    case "hk":return<HKPage user={user} onBack={()=>sScr("dash")}/>;
    default:return<SubscribePage onUnlock={u=>{sU(u);sScr("dash");}}/>;
  }
}
