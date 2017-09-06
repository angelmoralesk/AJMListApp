//
//  Country.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 06/09/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import Foundation

struct Country {
    let name : String
    let description : String
}

class CountryFactory {
    
    static func countryByIndex(index : Int) -> Country {
        
        var title = ""
        var description = ""
        
        switch index {
        case 1:
            title = "The Brandenburg Gate"
            description = "The Brandenburg Gate (German: Brandenburger Tor) is an 18th-century neoclassical monument in Berlin, built on the orders of Prussian king Frederick William II after the (temporarily) successful restoration of order during the early Batavian Revolution.[1] One of the best-known landmarks of Germany, it was built on the site of a former city gate that marked the start of the road from Berlin to the town of Brandenburg an der Havel, which used to be capital of the Margraviate of Brandenburg."
            
            description = "\r\nIt is located in the western part of the city centre of Berlin within Mitte, at the junction of Unter den Linden and Ebertstraße, immediately west of the Pariser Platz. One block to the north stands the Reichstag building, which houses the German parliament (Bundestag). The gate is the monumental entry to Unter den Linden, the renowned boulevard of linden trees, which led directly to the royal City Palace of the Prussian monarchs."
            break
        case 2:
            
            title = "Colosseum"
            description = "The Colosseum or Coliseum (/kɒləˈsiːəm/ kol-ə-SEE-əm), also known as the Flavian Amphitheatre (Latin: Amphitheatrum Flavium; Italian: Anfiteatro Flavio [aŋfiteˈaːtro ˈflaːvjo] or Colosseo [kolosˈsɛːo]), is an oval amphitheatre in the centre of the city of Rome, Italy. Built of concrete and sand,[1] it is the largest amphitheatre ever built. The Colosseum is situated just east of the Roman Forum. Construction began under the emperor Vespasian in AD 72,[2] and was completed in AD 80 under his successor and heir Titus.[3] Further modifications were made during the reign of Domitian (81–96).[4] These three emperors are known as the Flavian dynasty, and the amphitheatre was named in Latin for its association with their family name (Flavius)."
            
            description += "\r\nThe Colosseum could hold, it is estimated, between 50,000 and 80,000 spectators,[5][6] having an average audience of some 65,000;[7][8] it was used for gladiatorial contests and public spectacles such as mock sea battles (for only a short time as the hypogeum was soon filled in with mechanisms to support the other activities), animal hunts, executions, re-enactments of famous battles, and dramas based on Classical mythology. The building ceased to be used for entertainment in the early medieval era. It was later reused for such purposes as housing, workshops, quarters for a religious order, a fortress, a quarry, and a Christian shrine."
            
            
            break
        case 3:
            
            title = "Eiffel Tower"
            description = "The Eiffel Tower (/ˈaɪfəl ˈtaʊ.ər/ EYE-fəl TOW-ər; French: tour Eiffel, pronounced [tuʁ‿ɛfɛl] About this sound listen) is a wrought iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower."
            
            description += "\r\nConstructed from 1887–89 as the entrance to the 1889 World's Fair, it was initially criticized by some of France's leading artists and intellectuals for its design, but it has become a global cultural icon of France and one of the most recognisable structures in the world.[3] The Eiffel Tower is the most-visited paid monument in the world; 6.91 million people ascended it in 2015."
            
            description += "\r\nThe tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building, and the tallest structure in Paris. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world, a title it held for 41 years until the Chrysler Building in New York City was finished in 1930. Due to the addition of a broadcasting aerial at the top of the tower in 1957, it is now taller than the Chrysler Building by 5.2 metres (17 ft). Excluding transmitters, the Eiffel Tower is the second-tallest structure in France after the Millau Viaduct."
            
            break
        case 4:
            
            title = "Notre-Dame de Paris"
            
            description = "Notre-Dame de Paris (French: [nɔtʁə dam də paʁi] (About this sound listen); meaning \"Our Lady of Paris\"), also known as Notre-Dame Cathedral or simply Notre-Dame, is a medieval Catholic cathedral on the Île de la Cité in the fourth arrondissement of Paris, France.[3] The cathedral is widely considered to be one of the finest examples of French Gothic architecture, and it is among the largest and most well-known church buildings in the world. The naturalism of its sculptures and stained glass serve to contrast it with earlier Romanesque architecture."
            
            break
        case 5:
            title = "Venice"
            description = "Venice (/ˈvɛnɪs/ VEN-iss; Italian: Venezia, [veˈnɛttsja] (About this sound listen); Venetian: Venesia, [veˈnɛsja]) is a city in northeastern Italy and the capital of the Veneto region. It is situated across a group of 118 small islands[1] that are separated by canals and linked by bridges, of which there are 400.[2][3] The islands are located in the shallow Venetian Lagoon, an enclosed bay that lies between the mouths of the Po and the Piave Rivers. Parts of Venice are renowned for the beauty of their settings, their architecture, and artwork.[2] The lagoon and a part of the city are listed as a World Heritage Site"
            break
            
        default:
            title = "Berlin Cathedral"
            description = "Berlin Cathedral (German: Berliner Dom) is the short name for the Evangelical Supreme Parish and Collegiate Church (German: Oberpfarr- und Domkirche zu Berlin) in Berlin, Germany. It is located on Museum Island in the Mitte borough. The current building was finished in 1905 and is a main work of Historicist architecture of the \"Kaiserzeit\".\r\n"
            description += "The Dom is the parish church of the congregation Gemeinde der Oberpfarr- und Domkirche zu Berlin, a member of the umbrella organisation Evangelical Church of Berlin-Brandenburg-Silesian Upper Lusatia. The Berlin Cathedral has never been a cathedral in the actual sense of that term since it has never been the seat of a bishop. The bishop of the Evangelical Church in Berlin-Brandenburg (under this name 1945–2003) is based at St. Mary's Church and Kaiser Wilhelm Memorial Church in Berlin."
        }
        return Country(name: title, description: description)
    }
}
