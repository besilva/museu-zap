//
//  PublicAudiosInitializer.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 07/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

/// Responsible for creating the entities for the Public Audios, with its correct category
public class PublicAudiosInitializer {

    // MARK: - Properties

    var funnyAudios: [URL] = []
    var classicAudios: [URL] = []
    var jokesAudios: [URL] = []
    var musicalAudios: [URL] = []
    var fridayAudios: [URL] = []
    var answerAudios: [URL] = []
    var familyAudios: [URL] = []
    var pranksAudios: [URL] = []
    var quarantineAudios: [URL] = []

    // Load every array with its corresponding audios
    init () {
        // All public audios
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) else { return }

        funnyAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return funny.contains(name)
        }

        classicAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return classic.contains(name)
        }

        jokesAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return jokes.contains(name)
        }

        musicalAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return musical.contains(name)
        }

        fridayAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return friday.contains(name)
        }

        answerAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return answer.contains(name)
        }

        familyAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return family.contains(name)
        }

        pranksAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return pranks.contains(name)
        }

        quarantineAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return quarantine.contains(name)
        }
    }

    // MARK: - Public audios and its corresponding categories
    
    let funny = [
        "Infelizmente vou ter que sair do grupo",
        "Sgonoff, feijão torpedo, pudim de leite condenado, linguiça estocana",
        "Oração contra o trabalho",
        "Nem gosto de churrasco",
        "Crianças sinceras",
        "Aviso para não saírem de casa",
        "Neiva do céu!",
        "Sai do quarto, Vinícius",
        "Segunda vai trabalhar toda desgraçada",
        "Tá em casa quietinho, né?"
    ]

    let classic = [
        "Aqui tá chovendo e repangalejando, aqui choveu e relampagou",
        "Gemidão do Zapo",
        "Cristiano Ronaldo, líder nato",
        "Oloquinho, meu!",
        "Peixoto",
        "Hoje é dia de maldade!",
        // Destaques
        "Três conchada de galinha!",
        "Ivan tentando vender queijos",
        "Seu Armando"
    ]

    let jokes = [
        "O ladrão de pato e o poeta",
        "Mensagem errada acabou matando a velha",
        "Mulher do Zé no hospital",
        "Se você ver um óculos, não pegue",
        "Piadas do Costinha",
        "Piada do chifrudo"
    ]

    let musical = [
        "Jesus humilha o Satanás",
        "Tá chovendo aí?",
        "Cantando a música do Jaspion",
        "As verdadeiras letras das músicas"
    ]

    let friday = [
        "Sextou, seus aligenigena!",
        "Hoje eu tô igual manga com ovo",
        "Nunca quis tanto que o fim chegasse",
        "Bom dia, família!"
    ]

    let answer = [
        "Oxe, e quem liga?",
        "Tá bonitão na foto, hein?",
        "Sai fora, doido",
        "Tem alguém vivo aí?",
        "Tome vergonha, vai cuidar da sua vida!",
        "Coé, rapaziada?",
        "Ah, vá à m*rda!",
        "Aplausos! Arrasou, bonita!",
        "Você é burro, cara?",
        "Mais ou menos",
        "Tu tá demais, mulher!",
        "Tudo sacanagem!",
        "Você é zueiro mesmo, hein?"
    ]

    let family = [
        //"Cadê os bois?",
        "Eu gosto muito desse grupo",
        //"Esse pessoal do grupo tá muito ocupado",
        "Calados do grupo, quem são?",
        "Esse grupo tá precisando de uns apito",
        "Chamando o pessoal do grupo"
    ]

    let pranks = [
        "O Vinícius fugiu!",
        "Filha passando trote no pai",
        "Quanto tá o corte de cabelo?",
        "Moça, você ligou numa hora ruim",
        "Trote do Jesus",
        "Trote na atendente da Vivo",
        "Antedeguemon"
    ]

    let quarantine = [
        "Mãe desesperada com o coronavírus",
        "Mãe surtada na quarentena",
        "Caiu auxílio emergencial",
        "Senhora enlouquecendo na quarentena",
        "A mãe do Coronga",
        "Maridos reclamando do coronavírus",
        "Gaúchos em quarentena",
        "The Walking Velho"
    ]
}
