<h2> Exercicio 1 - Aquecendo com os pets </h2>

a) Adicione outro Peixe e um Hamster com nome Frodo </br>
    Comando: '''javascript db.exercicio_mongo.insert({name:"Frodo",species:"Peixe"})'''
 
b) Faça uma contagem dos pets na coleção
    Comando: db.getCollection("exercicio_mongo").aggregate(
                [
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "COUNT(*)" : 7 }

c) Retorne apenas um elemento o método prático possível
    Comando: db.getCollection("exercicio_mongo").find(
                { 
                    "_id" : ObjectId("5e68068c6012c8077fc4ab40")
                }, 
                { 
                    "name" : "$_name"
                }
            );
    Output: { "_id" : ObjectId("5e68068c6012c8077fc4ab40"), "name" : "Mike" }

d) Identifique o ID para o Gato Kilha
    Comando: db.getCollection("exercicio_mongo").find(
                { 
                    "name" : "Kilha", 
                    "species" : "Gato"
                }, 
                { 
                    "_id" : "$_id"
                }
            );
    Output: { "_id" : ObjectId("5e6807136012c8077fc4ab42") }

e) Faça uma busca pelo ID e traga o Hamster Mike
    Comando: db.getCollection("exercicio_mongo").find(
                { 
                    "_id" : ObjectId("5e68068c6012c8077fc4ab40")
                }, 
                { 
                    "name" : "$_name"
                }
            );
    Output: { "_id" : ObjectId("5e68068c6012c8077fc4ab40"), "name" : "Mike" }

f) Use o find para trazer todos os Hamsters
    Comando: db.getCollection("exercicio_mongo").find(
                { 
                    "species" : "Hamster"
                }
            );
    Output: { "_id" : ObjectId("5e68068c6012c8077fc4ab40"), "name" : "Mike", "species" : "Hamster" }

g) Use o find para listar todos os pets com nome Mike
    Comando: db.getCollection("exercicio_mongo").find(
                { 
                    "name" : "Mike"
                }
            );
    Output: { "_id" : ObjectId("5e68068c6012c8077fc4ab40"), "name" : "Mike", "species" : "Hamster" }
            { "_id" : ObjectId("5e6807136012c8077fc4ab43"), "name" : "Mike", "species" : "Cachorro" }

h) Liste apenas o documento que é um Cachorro chamado Mike
    Comando:db.getCollection("exercicio_mongo").find(
                { 
                    "name" : "Mike", 
                    "species" : "Cachorro"
                }
            );
    Output: { "_id" : ObjectId("5e6807136012c8077fc4ab43"), "name" : "Mike", "species" : "Cachorro" }

Exercicio 2 - Mama mia!

a) Liste/Conte todas as pessoas que tem exatamente 99 anos. Você pode usar um count para indicar a quantidade.
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$match" : { 
                            "age" : NumberLong(99)
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: Não houve retorno, pois não há nenhum registro com idade igual a 99 anos

b) Identifique quantas pessoas são elegíveis atendimento prioritário (pessoas com mais de 65 anos)
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$match" : { 
                            "age" : { 
                                "$gt" : NumberLong(65)
                            }
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "COUNT(*)" : 1723 }

c) Identifique todos os jovens (pessoas entre 12 a 18 anos)
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$match" : { 
                            "$and" : [
                                { 
                                    "age" : { 
                                        "$gte" : NumberLong(12)
                                    }
                                }, 
                                { 
                                    "age" : { 
                                        "$lte" : NumberLong(18)
                                    }
                                }
                            ]
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "COUNT(*)" : 863 }

d) Identifique quantas pessoas tem gatos, quantas tem cachorro e quantas não tem nenhum dos dois
    d.1) Tem gatos
        Comando: db.getCollection("italians").aggregate(
                    [
                        { 
                            "$match" : { 
                                "cat" : { 
                                    "$ne" : null
                                }
                            }
                        }, 
                        { 
                            "$group" : { 
                                "_id" : { 

                                }, 
                                "COUNT(*)" : { 
                                    "$sum" : NumberInt(1)
                                }
                            }
                        }, 
                        { 
                            "$project" : { 
                                "COUNT(*)" : "$COUNT(*)", 
                                "_id" : NumberInt(0)
                            }
                        }
                    ], 
                    { 
                        "allowDiskUse" : true
                    }
                );
        Output: { "COUNT(*)" : 6047 }
    
    d.2) Tem cachorro  
        Comando: db.getCollection("italians").aggregate(
                    [
                        { 
                            "$match" : { 
                                "dog" : { 
                                    "$ne" : null
                                }
                            }
                        }, 
                        { 
                            "$group" : { 
                                "_id" : { 

                                }, 
                                "COUNT(*)" : { 
                                    "$sum" : NumberInt(1)
                                }
                            }
                        }, 
                        { 
                            "$project" : { 
                                "COUNT(*)" : "$COUNT(*)", 
                                "_id" : NumberInt(0)
                            }
                        }
                    ], 
                    { 
                        "allowDiskUse" : true
                    }
                );
        Output: { "COUNT(*)" : 4053 }
    
    d.3) Não tem nenhum dos dois
        Comando: db.getCollection("italians").aggregate(
                    [
                        { 
                            "$match" : { 
                                "dog" : null, 
                                "cat" : null
                            }
                        }, 
                        { 
                            "$group" : { 
                                "_id" : { 

                                }, 
                                "COUNT(*)" : { 
                                    "$sum" : NumberInt(1)
                                }
                            }
                        }, 
                        { 
                            "$project" : { 
                                "COUNT(*)" : "$COUNT(*)", 
                                "_id" : NumberInt(0)
                            }
                        }
                    ], 
                    { 
                        "allowDiskUse" : true
                    }
                );
        Output: { "COUNT(*)" : 2313 }

e) Liste/Conte todas as pessoas acima de 60 anos que tenham gato
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$match" : { 
                            "cat" : { 
                                "$ne" : null
                            }, 
                            "age" : { 
                                "$gt" : NumberLong(60)
                            }
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "COUNT(*)" : 1403 }

f) Liste/Conte todos os jovens com cachorro
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$match" : { 
                            "$and" : [
                                { 
                                    "age" : { 
                                        "$gt" : NumberLong(12)
                                    }
                                }, 
                                { 
                                    "age" : { 
                                        "$lt" : NumberLong(18)
                                    }
                                }, 
                                { 
                                    "dog" : { 
                                        "$ne" : null
                                    }
                                }
                            ]
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : { 

                            }, 
                            "COUNT(*)" : { 
                                "$sum" : NumberInt(1)
                            }
                        }
                    }, 
                    { 
                        "$project" : { 
                            "COUNT(*)" : "$COUNT(*)", 
                            "_id" : NumberInt(0)
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "COUNT(*)" : 249 }

g) Utilizando o $where, liste todas as pessoas que tem gato e cachorro
    Comando: db.getCollection("italians").find( { $where: "this.cat == this.dog" } );
    Output: { "_id" : ObjectId("5e680f09bdf084d4fe00aa91"), "firstname" : "Elena", "surname" : "Morelli", "username" : "user108", "age" : 52, "email" : "Elena.Morelli@uol.com.br", "bloodType" : "B-", "id_num" : "412035262818", "registerDate" : ISODate("2018-06-24T14:13:26.346Z"), "ticketNumber" : 9813, "jobs" : [ "História da Arte" ], "favFruits" : [ "Uva" ], "movies" : [ { "title" : "Um Estranho no Ninho (1975)", "rating" : 2.36 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 2.18 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 3.21 }, { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 2.34 } ], "father" : { "firstname" : "Mauro", "surname" : "Morelli", "age" : 69 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa94"), "firstname" : "Giorgio", "surname" : "Martini", "username" : "user111", "age" : 53, "email" : "Giorgio.Martini@uol.com.br", "bloodType" : "A+", "id_num" : "557403120263", "registerDate" : ISODate("2014-12-27T09:42:44.979Z"), "ticketNumber" : 1582, "jobs" : [ "Música", "Automação Industrial" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "1917 (2019)", "rating" : 1.67 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 3.06 } ], "father" : { "firstname" : "Michele", "surname" : "Martini", "age" : 82 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa9d"), "firstname" : "Paola", "surname" : "Moretti", "username" : "user120", "age" : 58, "email" : "Paola.Moretti@uol.com.br", "bloodType" : "O+", "id_num" : "321741781434", "registerDate" : ISODate("2014-07-26T17:20:56.106Z"), "ticketNumber" : 1544, "jobs" : [ "Engenharia de Telecomunicações", "Mineração" ], "favFruits" : [ "Mamão", "Laranja" ], "movies" : [ { "title" : "Intocáveis (2011)", "rating" : 4.86 }, { "title" : "Parasita (2019)", "rating" : 0.81 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa1"), "firstname" : "Massimiliano", "surname" : "Bruno", "username" : "user124", "age" : 33, "email" : "Massimiliano.Bruno@hotmail.com", "bloodType" : "A+", "id_num" : "571355141687", "registerDate" : ISODate("2016-06-03T05:55:44.953Z"), "ticketNumber" : 9229, "jobs" : [ "Processos Gerenciais", "Segurança da Informação" ], "favFruits" : [ "Tangerina" ], "movies" : [ { "title" : "Clube da Luta (1999)", "rating" : 4.05 }, { "title" : "Guerra nas Estrelas (1977)", "rating" : 3.64 } ], "father" : { "firstname" : "Pasquale", "surname" : "Bruno", "age" : 59 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa6"), "firstname" : "Fabio", "surname" : "Martino", "username" : "user129", "age" : 51, "email" : "Fabio.Martino@gmail.com", "bloodType" : "O-", "id_num" : "620503231120", "registerDate" : ISODate("2008-05-16T02:41:05.882Z"), "ticketNumber" : 3600, "jobs" : [ "Saúde Coletiva", "Aquicultura" ], "favFruits" : [ "Melancia" ], "movies" : [ { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 2.51 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 2.18 }, { "title" : "12 Homens e uma Sentença (1957)", "rating" : 2.19 }, { "title" : "Um Sonho de Liberdade (1994)", "rating" : 1.59 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaaa"), "firstname" : "Giuseppe", "surname" : "Rinaldi", "username" : "user133", "age" : 60, "email" : "Giuseppe.Rinaldi@hotmail.com", "bloodType" : "A-", "id_num" : "743700166226", "registerDate" : ISODate("2014-01-02T00:58:11.310Z"), "ticketNumber" : 3185, "jobs" : [ "Segurança Pública" ], "favFruits" : [ "Uva" ], "movies" : [ { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 4.56 }, { "title" : "Coringa (2019)", "rating" : 0.21 }, { "title" : "Gladiador (2000)", "rating" : 2.46 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 0.03 }, { "title" : "À Espera de um Milagre (1999)", "rating" : 0.76 } ], "father" : { "firstname" : "Filipo", "surname" : "Rinaldi", "age" : 80 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aab2"), "firstname" : "Massimiliano", "surname" : "Carbone", "username" : "user141", "age" : 79, "email" : "Massimiliano.Carbone@outlook.com", "bloodType" : "B+", "id_num" : "722188088526", "registerDate" : ISODate("2008-07-11T13:34:22.847Z"), "ticketNumber" : 878, "jobs" : [ "Ciências do Consumo" ], "favFruits" : [ "Laranja", "Banana", "Banana" ], "movies" : [ { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 4.07 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 4.47 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 0.95 }, { "title" : "Os Sete Samurais (1954)", "rating" : 1.14 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 1.12 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aab9"), "firstname" : "Monica", "surname" : "Bianchi", "username" : "user148", "age" : 75, "email" : "Monica.Bianchi@hotmail.com", "bloodType" : "O-", "id_num" : "074230823766", "registerDate" : ISODate("2016-12-25T23:03:18.417Z"), "ticketNumber" : 9711, "jobs" : [ "Engenharia de Petróleo" ], "favFruits" : [ "Tangerina" ], "movies" : [ { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 2.16 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 1.81 }, { "title" : "Guerra nas Estrelas (1977)", "rating" : 0.86 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aabe"), "firstname" : "Eleonora", "surname" : "Rossetti", "username" : "user153", "age" : 65, "email" : "Eleonora.Rossetti@outlook.com", "bloodType" : "O-", "id_num" : "371332656418", "registerDate" : ISODate("2017-05-07T09:50:10.758Z"), "ticketNumber" : 3467, "jobs" : [ "Artes Visuais", "Oftálmica" ], "favFruits" : [ "Tangerina", "Mamão" ], "movies" : [ { "title" : "Vingadores: Ultimato (2019)", "rating" : 1.23 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aabf"), "firstname" : "Raffaele", "surname" : "Barone", "username" : "user154", "age" : 70, "email" : "Raffaele.Barone@outlook.com", "bloodType" : "B+", "id_num" : "038325858573", "registerDate" : ISODate("2008-06-12T07:51:31.692Z"), "ticketNumber" : 5478, "jobs" : [ "Logística" ], "favFruits" : [ "Uva", "Goiaba", "Tangerina" ], "movies" : [ { "title" : "O Poderoso Chefão (1972)", "rating" : 1.06 }, { "title" : "Gladiador (2000)", "rating" : 0.93 } ] }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aac0"), "firstname" : "Barbara", "surname" : "Rossi", "username" : "user155", "age" : 53, "email" : "Barbara.Rossi@uol.com.br", "bloodType" : "AB-", "id_num" : "087132455586", "registerDate" : ISODate("2020-02-08T09:16:09.910Z"), "ticketNumber" : 9552, "jobs" : [ "Secretariado Executivo" ], "favFruits" : [ "Melancia", "Maçã" ], "movies" : [ { "title" : "A Origem (2010)", "rating" : 4.03 }, { "title" : "O Poderoso Chefão (1972)", "rating" : 2.03 }, { "title" : "O Poderoso Chefão II (1974)", "rating" : 0.45 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aad6"), "firstname" : "Simona", "surname" : "D’Amico", "username" : "user177", "age" : 18, "email" : "Simona.D’Amico@gmail.com", "bloodType" : "O-", "id_num" : "427331767776", "registerDate" : ISODate("2015-09-04T21:53:04.774Z"), "ticketNumber" : 296, "jobs" : [ "Agroecologia", "Ciências Agrárias" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "Três Homens em Conflito (1966)", "rating" : 3.64 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 4.05 }, { "title" : "Clube da Luta (1999)", "rating" : 3.41 }, { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 2.14 }, { "title" : "A Origem (2010)", "rating" : 2.82 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aad7"), "firstname" : "Enrico", "surname" : "Caruso", "username" : "user178", "age" : 49, "email" : "Enrico.Caruso@live.com", "bloodType" : "B-", "id_num" : "445184744814", "registerDate" : ISODate("2018-04-05T08:38:55.452Z"), "ticketNumber" : 1201, "jobs" : [ "Jornalismo" ], "favFruits" : [ "Kiwi", "Kiwi", "Mamão" ], "movies" : [ { "title" : "Interestelar (2014)", "rating" : 3.74 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.82 }, { "title" : "A Vida é Bela (1997)", "rating" : 2.45 }, { "title" : "Harakiri (1962)", "rating" : 0.61 }, { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 1.57 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aadb"), "firstname" : "Domenico", "surname" : "Gentile", "username" : "user182", "age" : 77, "email" : "Domenico.Gentile@yahoo.com", "bloodType" : "A-", "id_num" : "525781452480", "registerDate" : ISODate("2007-08-12T14:07:38.378Z"), "ticketNumber" : 7478, "jobs" : [ "Engenharia Agrícola" ], "favFruits" : [ "Kiwi", "Kiwi", "Laranja" ], "movies" : [ { "title" : "Três Homens em Conflito (1966)", "rating" : 0.62 }, { "title" : "A Lista de Schindler (1993)", "rating" : 2.21 }, { "title" : "Guerra nas Estrelas (1977)", "rating" : 2.64 }, { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 1.14 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aade"), "firstname" : "Michela", "surname" : "De Angelis", "username" : "user185", "age" : 58, "email" : "Michela.De Angelis@uol.com.br", "bloodType" : "B-", "id_num" : "741027142744", "registerDate" : ISODate("2018-01-21T06:51:35.035Z"), "ticketNumber" : 5404, "jobs" : [ "Gestão da Produção Industrial" ], "favFruits" : [ "Banana", "Mamão", "Uva" ], "movies" : [ { "title" : "Clube da Luta (1999)", "rating" : 4.83 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 0.06 }, { "title" : "Parasita (2019)", "rating" : 4.89 }, { "title" : "Cidade de Deus (2002)", "rating" : 4.6 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aae2"), "firstname" : "Sonia", "surname" : "Messina", "username" : "user189", "age" : 39, "email" : "Sonia.Messina@yahoo.com", "bloodType" : "B+", "id_num" : "728403621332", "registerDate" : ISODate("2011-07-15T23:01:07.080Z"), "ticketNumber" : 9114, "jobs" : [ "Ciência e Tecnologia" ], "favFruits" : [ "Melancia" ], "movies" : [ { "title" : "Gladiador (2000)", "rating" : 3.64 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aaed"), "firstname" : "Federica", "surname" : "De Luca", "username" : "user200", "age" : 64, "email" : "Federica.De Luca@live.com", "bloodType" : "O+", "id_num" : "857881084248", "registerDate" : ISODate("2010-06-17T06:06:44.792Z"), "ticketNumber" : 2318, "jobs" : [ "Eventos", "Redes de Computadores" ], "favFruits" : [ "Pêssego" ], "movies" : [ { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 4 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aaf2"), "firstname" : "Monica", "surname" : "Ferrara", "username" : "user205", "age" : 44, "email" : "Monica.Ferrara@gmail.com", "bloodType" : "AB-", "id_num" : "008080301364", "registerDate" : ISODate("2016-02-25T23:05:51.655Z"), "ticketNumber" : 3082, "jobs" : [ "Saúde e Bem-estar", "Construção Civil" ], "favFruits" : [ "Tangerina" ], "movies" : [ { "title" : "A Viagem de Chihiro (2001)", "rating" : 2.39 }, { "title" : "Um Estranho no Ninho (1975)", "rating" : 0.13 }, { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 1.07 }, { "title" : "O Poderoso Chefão II (1974)", "rating" : 3.2 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aaf3"), "firstname" : "Giuseppe", "surname" : "Sanna", "username" : "user206", "age" : 67, "email" : "Giuseppe.Sanna@outlook.com", "bloodType" : "A+", "id_num" : "367838774045", "registerDate" : ISODate("2016-07-11T00:25:23.647Z"), "ticketNumber" : 2876, "jobs" : [ "Mecatrônica Industrial", "Astronomia" ], "favFruits" : [ "Kiwi", "Laranja", "Kiwi" ], "movies" : [ { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 1.01 } ] }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aaf7"), "firstname" : "Alessandra", "surname" : "Lombardo", "username" : "user210", "age" : 53, "email" : "Alessandra.Lombardo@outlook.com", "bloodType" : "AB+", "id_num" : "186305383255", "registerDate" : ISODate("2017-11-08T20:15:07.283Z"), "ticketNumber" : 1886, "jobs" : [ "Agronegócios e Agropecuária", "Gestão de Turismo" ], "favFruits" : [ "Maçã", "Mamão", "Maçã" ], "movies" : [ { "title" : "Cidade de Deus (2002)", "rating" : 1.3 }, { "title" : "Coringa (2019)", "rating" : 4.85 }, { "title" : "12 Homens e uma Sentença (1957)", "rating" : 0.03 }, { "title" : "Três Homens em Conflito (1966)", "rating" : 1.54 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 4.34 } ] }
            Type "it" for more

h) Liste todas as pessoas mais novas que seus respectivos gatos.
    Comando: db.getCollection("italians").find( { $where: "this.cat && this.age > this.cat.age" } );
    Output: { "_id" : ObjectId("5e680f09bdf084d4fe00aa89"), "firstname" : "Ilaria", "surname" : "Martinelli", "username" : "user100", "age" : 34, "email" : "Ilaria.Martinelli@yahoo.com", "bloodType" : "O-", "id_num" : "052483747272", "registerDate" : ISODate("2013-10-22T07:27:24.790Z"), "ticketNumber" : 1013, "jobs" : [ "Sistemas Embarcados", "Teologia" ], "favFruits" : [ "Pêssego", "Kiwi" ], "movies" : [ { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 4.71 }, { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 4.61 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 1.79 } ], "cat" : { "name" : "Davide", "age" : 8 }, "dog" : { "name" : "Elisa", "age" : 14 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa8a"), "firstname" : "Massimiliano", "surname" : "Mariani", "username" : "user101", "age" : 50, "email" : "Massimiliano.Mariani@live.com", "bloodType" : "A-", "id_num" : "637560181156", "registerDate" : ISODate("2019-08-16T07:48:36.313Z"), "ticketNumber" : 2456, "jobs" : [ "Biotecnologia e Bioquímica", "Energias Renováveis" ], "favFruits" : [ "Maçã", "Maçã" ], "movies" : [ { "title" : "O Poderoso Chefão (1972)", "rating" : 2.41 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 2.07 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 3.37 } ], "cat" : { "name" : "Emanuela", "age" : 15 }, "dog" : { "name" : "Federico", "age" : 2 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa8b"), "firstname" : "Alessandra", "surname" : "Ricci", "username" : "user102", "age" : 78, "email" : "Alessandra.Ricci@yahoo.com", "bloodType" : "B-", "id_num" : "321078734765", "registerDate" : ISODate("2008-08-11T13:03:03.633Z"), "ticketNumber" : 3809, "jobs" : [ "Silvicultura", "Secretariado" ], "favFruits" : [ "Pêssego" ], "movies" : [ { "title" : "A Viagem de Chihiro (2001)", "rating" : 0.41 }, { "title" : "Parasita (2019)", "rating" : 0.97 }, { "title" : "O Poderoso Chefão II (1974)", "rating" : 2.58 }, { "title" : "A Lista de Schindler (1993)", "rating" : 0.35 } ], "cat" : { "name" : "Tiziana", "age" : 5 }, "dog" : { "name" : "Elena", "age" : 13 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa8d"), "firstname" : "Filipo", "surname" : "Sartori", "username" : "user104", "age" : 63, "email" : "Filipo.Sartori@hotmail.com", "bloodType" : "A+", "id_num" : "023234308801", "registerDate" : ISODate("2012-10-27T10:26:51.077Z"), "ticketNumber" : 3854, "jobs" : [ "Engenharia de Controle e Automação", "Ciências Sociais" ], "favFruits" : [ "Tangerina", "Kiwi", "Uva" ], "movies" : [ { "title" : "Os Sete Samurais (1954)", "rating" : 3.21 }, { "title" : "Matrix (1999)", "rating" : 3.11 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 3.58 } ], "cat" : { "name" : "Roberta", "age" : 0 }, "dog" : { "name" : "Fabrizio", "age" : 10 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa8e"), "firstname" : "Elena", "surname" : "Longo", "username" : "user105", "age" : 67, "email" : "Elena.Longo@uol.com.br", "bloodType" : "B-", "id_num" : "815451034226", "registerDate" : ISODate("2008-07-12T23:09:27.900Z"), "ticketNumber" : 3036, "jobs" : [ "Secretariado" ], "favFruits" : [ "Goiaba", "Goiaba", "Mamão" ], "movies" : [ { "title" : "Coringa (2019)", "rating" : 1.72 }, { "title" : "Gladiador (2000)", "rating" : 2.02 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 3.59 } ], "cat" : { "name" : "Sonia", "age" : 3 }, "dog" : { "name" : "Domenico", "age" : 11 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa8f"), "firstname" : "Filipo", "surname" : "Negri", "username" : "user106", "age" : 23, "email" : "Filipo.Negri@outlook.com", "bloodType" : "A+", "id_num" : "584031502635", "registerDate" : ISODate("2010-11-25T12:16:24.585Z"), "ticketNumber" : 5881, "jobs" : [ "Fotografia" ], "favFruits" : [ "Melancia", "Laranja" ], "movies" : [ { "title" : "Gladiador (2000)", "rating" : 4.82 } ], "father" : { "firstname" : "Mirko", "surname" : "Negri", "age" : 45 }, "cat" : { "name" : "Eleonora", "age" : 10 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa92"), "firstname" : "Michela", "surname" : "Morelli", "username" : "user109", "age" : 18, "email" : "Michela.Morelli@hotmail.com", "bloodType" : "O-", "id_num" : "638644314834", "registerDate" : ISODate("2010-04-24T20:37:51.148Z"), "ticketNumber" : 1984, "jobs" : [ "Sistemas de Informação", "Construção Civil" ], "favFruits" : [ "Tangerina" ], "movies" : [ { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 1.59 } ], "cat" : { "name" : "Federico", "age" : 6 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa93"), "firstname" : "Massimiliano", "surname" : "Neri", "username" : "user110", "age" : 66, "email" : "Massimiliano.Neri@live.com", "bloodType" : "AB-", "id_num" : "607161466830", "registerDate" : ISODate("2007-07-26T02:52:04.526Z"), "ticketNumber" : 7095, "jobs" : [ "Medicina Veterinária" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 3.26 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 4.82 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 4.39 }, { "title" : "A Lista de Schindler (1993)", "rating" : 0.13 } ], "cat" : { "name" : "Riccardo", "age" : 13 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa95"), "firstname" : "Marta", "surname" : "Barone", "username" : "user112", "age" : 41, "email" : "Marta.Barone@hotmail.com", "bloodType" : "O-", "id_num" : "028322681756", "registerDate" : ISODate("2018-10-21T15:04:47.328Z"), "ticketNumber" : 2994, "jobs" : [ "Ciência e Tecnologia" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 4.79 }, { "title" : "1917 (2019)", "rating" : 2.21 } ], "cat" : { "name" : "Sabrina", "age" : 10 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa97"), "firstname" : "Paola", "surname" : "Messina", "username" : "user114", "age" : 61, "email" : "Paola.Messina@uol.com.br", "bloodType" : "B+", "id_num" : "770047054658", "registerDate" : ISODate("2017-09-15T05:14:11.079Z"), "ticketNumber" : 8626, "jobs" : [ "Serviços Judiciários e Notariais", "Estudos de Gênero e Diversidade" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "1917 (2019)", "rating" : 1.11 }, { "title" : "Coringa (2019)", "rating" : 2.14 } ], "father" : { "firstname" : "Silvia", "surname" : "Messina", "age" : 100 }, "cat" : { "name" : "Sabrina", "age" : 0 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa98"), "firstname" : "Sonia", "surname" : "De Santis", "username" : "user115", "age" : 74, "email" : "Sonia.De Santis@gmail.com", "bloodType" : "AB-", "id_num" : "616173812008", "registerDate" : ISODate("2012-05-27T02:15:09.929Z"), "ticketNumber" : 1032, "jobs" : [ "Gestão em Saúde", "Gestão da Tecnologia da Informação" ], "favFruits" : [ "Melancia", "Uva" ], "movies" : [ { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 2.01 }, { "title" : "A Vida é Bela (1997)", "rating" : 4.82 }, { "title" : "A Vida é Bela (1997)", "rating" : 0.56 } ], "cat" : { "name" : "Valentina", "age" : 10 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa9a"), "firstname" : "Elisa", "surname" : "Grassi", "username" : "user117", "age" : 42, "email" : "Elisa.Grassi@hotmail.com", "bloodType" : "O+", "id_num" : "817125745722", "registerDate" : ISODate("2016-10-24T11:29:17.307Z"), "ticketNumber" : 4794, "jobs" : [ "Gestão Desportiva e de Lazer", "Engenharia de Segurança no Trabalho" ], "favFruits" : [ "Tangerina", "Mamão" ], "movies" : [ { "title" : "Gladiador (2000)", "rating" : 0.15 }, { "title" : "Um Sonho de Liberdade (1994)", "rating" : 2.32 }, { "title" : "Harakiri (1962)", "rating" : 1.17 }, { "title" : "À Espera de um Milagre (1999)", "rating" : 4.07 } ], "cat" : { "name" : "Maria", "age" : 16 }, "dog" : { "name" : "Chiara", "age" : 12 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa9c"), "firstname" : "Raffaele", "surname" : "Montanari", "username" : "user119", "age" : 68, "email" : "Raffaele.Montanari@outlook.com", "bloodType" : "AB+", "id_num" : "723680630277", "registerDate" : ISODate("2011-07-06T01:01:30.778Z"), "ticketNumber" : 7946, "jobs" : [ "Direito" ], "favFruits" : [ "Mamão", "Laranja" ], "movies" : [ { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 0.41 }, { "title" : "1917 (2019)", "rating" : 1.04 } ], "cat" : { "name" : "Lucia", "age" : 0 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa9e"), "firstname" : "Anna", "surname" : "Benedetti", "username" : "user121", "age" : 18, "email" : "Anna.Benedetti@live.com", "bloodType" : "AB-", "id_num" : "331754702344", "registerDate" : ISODate("2013-04-18T08:19:01.637Z"), "ticketNumber" : 2522, "jobs" : [ "Engenharia e Produção" ], "favFruits" : [ "Mamão", "Banana" ], "movies" : [ { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 4.4 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 0.4 } ], "cat" : { "name" : "Claudia", "age" : 15 }, "dog" : { "name" : "Giacomo", "age" : 0 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aa9f"), "firstname" : "Simona", "surname" : "Mancini", "username" : "user122", "age" : 18, "email" : "Simona.Mancini@uol.com.br", "bloodType" : "A+", "id_num" : "828808060825", "registerDate" : ISODate("2014-09-18T01:53:40.151Z"), "ticketNumber" : 9196, "jobs" : [ "Sistemas de Informação" ], "favFruits" : [ "Melancia", "Laranja", "Banana" ], "movies" : [ { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 2.82 }, { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 0.71 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 1.38 }, { "title" : "A Vida é Bela (1997)", "rating" : 0.94 } ], "cat" : { "name" : "Roberta", "age" : 3 }, "dog" : { "name" : "Antonio", "age" : 11 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa3"), "firstname" : "Claudio", "surname" : "Marchetti", "username" : "user126", "age" : 62, "email" : "Claudio.Marchetti@outlook.com", "bloodType" : "A+", "id_num" : "054815550625", "registerDate" : ISODate("2010-03-16T03:26:00.036Z"), "ticketNumber" : 7219, "jobs" : [ "Engenharia Elétrica", "História" ], "favFruits" : [ "Tangerina", "Melancia" ], "movies" : [ { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 2.97 }, { "title" : "O Poderoso Chefão (1972)", "rating" : 2.57 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 3.97 }, { "title" : "Matrix (1999)", "rating" : 3.79 } ], "cat" : { "name" : "Giusy", "age" : 5 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa5"), "firstname" : "Filipo", "surname" : "Serra", "username" : "user128", "age" : 53, "email" : "Filipo.Serra@gmail.com", "bloodType" : "A-", "id_num" : "605317521764", "registerDate" : ISODate("2014-11-15T12:13:20.458Z"), "ticketNumber" : 135, "jobs" : [ "Gestão Hospitalar", "Sistemas de Informação" ], "favFruits" : [ "Goiaba", "Banana", "Maçã" ], "movies" : [ { "title" : "Intocáveis (2011)", "rating" : 1.09 }, { "title" : "Parasita (2019)", "rating" : 0.49 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 1.83 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 2.42 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.05 } ], "cat" : { "name" : "Patrizia", "age" : 4 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa7"), "firstname" : "Emanuele", "surname" : "Bianco", "username" : "user130", "age" : 56, "email" : "Emanuele.Bianco@gmail.com", "bloodType" : "A+", "id_num" : "664641167228", "registerDate" : ISODate("2012-07-13T20:39:13.001Z"), "ticketNumber" : 5988, "jobs" : [ "Engenharia de Transporte e da Mobilidade", "Engenharia de Transporte e da Mobilidade" ], "favFruits" : [ "Tangerina", "Goiaba" ], "movies" : [ { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.27 }, { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 1.73 }, { "title" : "1917 (2019)", "rating" : 2.59 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 2.67 } ], "cat" : { "name" : "Giovanna", "age" : 9 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa8"), "firstname" : "Roberta", "surname" : "Ricci", "username" : "user131", "age" : 31, "email" : "Roberta.Ricci@gmail.com", "bloodType" : "A+", "id_num" : "183810782558", "registerDate" : ISODate("2015-05-16T06:50:24.635Z"), "ticketNumber" : 995, "jobs" : [ "Engenharia Aeronáutica", "Quiropraxia" ], "favFruits" : [ "Kiwi", "Kiwi" ], "movies" : [ { "title" : "Vingadores: Ultimato (2019)", "rating" : 2.02 }, { "title" : "O Poderoso Chefão (1972)", "rating" : 4.48 }, { "title" : "Clube da Luta (1999)", "rating" : 1.08 }, { "title" : "Matrix (1999)", "rating" : 1.6 } ], "cat" : { "name" : "Mirko", "age" : 8 }, "dog" : { "name" : "Luca", "age" : 12 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa9"), "firstname" : "Antonella", "surname" : "Benedetti", "username" : "user132", "age" : 27, "email" : "Antonella.Benedetti@hotmail.com", "bloodType" : "AB+", "id_num" : "305477126262", "registerDate" : ISODate("2014-10-23T14:46:27.446Z"), "ticketNumber" : 9655, "jobs" : [ "Letras", "Papel e Celulose" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 3.24 }, { "title" : "Guerra nas Estrelas (1977)", "rating" : 3.2 }, { "title" : "Parasita (2019)", "rating" : 0.59 } ], "mother" : { "firstname" : "Alex", "surname" : "Benedetti", "age" : 45 }, "cat" : { "name" : "Anna", "age" : 1 }, "dog" : { "name" : "Cinzia", "age" : 6 } }
            Type "it" for more

i) Liste as pessoas que tem o mesmo nome que seu bichano (gatou ou cachorro)
    Comando: db.getCollection("italians").find( { $where: "this.cat && this.firstname == this.cat.name || this.dog && this.firstname == this.dog.name" } );
    Output: { "_id" : ObjectId("5e680f0abdf084d4fe00ab3a"), "firstname" : "Stefano", "surname" : "Fiore", "username" : "user277", "age" : 52, "email" : "Stefano.Fiore@live.com", "bloodType" : "A-", "id_num" : "386275515723", "registerDate" : ISODate("2015-10-31T06:56:03.932Z"), "ticketNumber" : 8248, "jobs" : [ "Gestão Hospitalar", "Musicoterapia" ], "favFruits" : [ "Pêssego", "Laranja" ], "movies" : [ { "title" : "Cidade de Deus (2002)", "rating" : 3.87 }, { "title" : "12 Homens e uma Sentença (1957)", "rating" : 1.56 }, { "title" : "Um Estranho no Ninho (1975)", "rating" : 4.85 } ], "cat" : { "name" : "Stefano", "age" : 13 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab76"), "firstname" : "Tiziana", "surname" : "Giordano", "username" : "user337", "age" : 64, "email" : "Tiziana.Giordano@gmail.com", "bloodType" : "B+", "id_num" : "767213445213", "registerDate" : ISODate("2016-12-04T00:34:38.216Z"), "ticketNumber" : 8577, "jobs" : [ "Mineração", "Gestão Ambiental" ], "favFruits" : [ "Maçã", "Maçã", "Tangerina" ], "movies" : [ { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 4.17 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 2.18 }, { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 1.27 }, { "title" : "Um Sonho de Liberdade (1994)", "rating" : 2.42 } ], "cat" : { "name" : "Tiziana", "age" : 10 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00abb4"), "firstname" : "Elena", "surname" : "Montanari", "username" : "user399", "age" : 24, "email" : "Elena.Montanari@live.com", "bloodType" : "A+", "id_num" : "321526613345", "registerDate" : ISODate("2011-08-13T20:41:30.406Z"), "ticketNumber" : 5565, "jobs" : [ "Ciências Naturais e Exatas", "Fisioterapia" ], "favFruits" : [ "Maçã" ], "movies" : [ { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 4.24 } ], "cat" : { "name" : "Monica", "age" : 7 }, "dog" : { "name" : "Elena", "age" : 9 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ac0e"), "firstname" : "Lucia", "surname" : "Ruggiero", "username" : "user489", "age" : 72, "email" : "Lucia.Ruggiero@uol.com.br", "bloodType" : "A+", "id_num" : "212565653606", "registerDate" : ISODate("2014-07-08T08:03:33.734Z"), "ticketNumber" : 2308, "jobs" : [ "Gestão da Produção Industrial", "Ciências do Consumo" ], "favFruits" : [ "Uva", "Mamão", "Uva" ], "movies" : [ { "title" : "Coringa (2019)", "rating" : 2.04 }, { "title" : "Três Homens em Conflito (1966)", "rating" : 1.03 }, { "title" : "Intocáveis (2011)", "rating" : 1.21 } ], "cat" : { "name" : "Lucia", "age" : 9 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ac83"), "firstname" : "Maria", "surname" : "Morelli", "username" : "user606", "age" : 21, "email" : "Maria.Morelli@outlook.com", "bloodType" : "AB+", "id_num" : "413825674400", "registerDate" : ISODate("2014-10-04T13:28:47.414Z"), "ticketNumber" : 972, "jobs" : [ "Ciências Biológicas" ], "favFruits" : [ "Tangerina", "Kiwi", "Mamão" ], "movies" : [ { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 1.8 }, { "title" : "Um Estranho no Ninho (1975)", "rating" : 4.32 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 3.19 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 0.97 }, { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 4.42 } ], "cat" : { "name" : "Maria", "age" : 10 }, "dog" : { "name" : "Roberto", "age" : 7 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00ad90"), "firstname" : "Alberto", "surname" : "Valentini", "username" : "user875", "age" : 78, "email" : "Alberto.Valentini@live.com", "bloodType" : "O+", "id_num" : "587700116567", "registerDate" : ISODate("2019-04-09T11:16:16.876Z"), "ticketNumber" : 8647, "jobs" : [ "Estatística", "Nanotecnologia" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "Gladiador (2000)", "rating" : 2.43 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 2.73 } ], "cat" : { "name" : "Eleonora", "age" : 17 }, "dog" : { "name" : "Alberto", "age" : 5 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00ae22"), "firstname" : "Giacomo", "surname" : "Caruso", "username" : "user1021", "age" : 46, "email" : "Giacomo.Caruso@live.com", "bloodType" : "O-", "id_num" : "534713477456", "registerDate" : ISODate("2013-08-17T06:12:24.663Z"), "ticketNumber" : 5197, "jobs" : [ "Engenharia de Alimentos" ], "favFruits" : [ "Kiwi" ], "movies" : [ { "title" : "Os Bons Companheiros (1990)", "rating" : 3.01 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 0.35 }, { "title" : "Os Sete Samurais (1954)", "rating" : 0.25 }, { "title" : "1917 (2019)", "rating" : 3.59 }, { "title" : "Gladiador (2000)", "rating" : 4.76 } ], "cat" : { "name" : "Giacomo", "age" : 4 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00ae59"), "firstname" : "Carlo", "surname" : "Carbone", "username" : "user1076", "age" : 27, "email" : "Carlo.Carbone@uol.com.br", "bloodType" : "A+", "id_num" : "084684187161", "registerDate" : ISODate("2010-08-11T16:19:12.980Z"), "ticketNumber" : 9318, "jobs" : [ "Secretariado Executivo" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 1.4 }, { "title" : "Harakiri (1962)", "rating" : 1.38 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 4.71 } ], "dog" : { "name" : "Carlo", "age" : 7 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00ae71"), "firstname" : "Manuela", "surname" : "Ricci", "username" : "user1100", "age" : 70, "email" : "Manuela.Ricci@yahoo.com", "bloodType" : "O-", "id_num" : "566112813128", "registerDate" : ISODate("2013-04-07T23:14:14.073Z"), "ticketNumber" : 2673, "jobs" : [ "Gestão da Qualidade" ], "favFruits" : [ "Uva", "Kiwi" ], "movies" : [ { "title" : "Matrix (1999)", "rating" : 4.67 } ], "dog" : { "name" : "Manuela", "age" : 10 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00ae9b"), "firstname" : "Valentina", "surname" : "Bernardi", "username" : "user1142", "age" : 19, "email" : "Valentina.Bernardi@live.com", "bloodType" : "O+", "id_num" : "020852030824", "registerDate" : ISODate("2018-02-13T03:47:53.702Z"), "ticketNumber" : 999, "jobs" : [ "Produção Cultural" ], "favFruits" : [ "Kiwi", "Goiaba" ], "movies" : [ { "title" : "A Felicidade Não se Compra (1946)", "rating" : 1.21 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 0.25 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 2.18 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 0.09 }, { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 3.68 } ], "cat" : { "name" : "Valentina", "age" : 17 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00aea9"), "firstname" : "Stefania", "surname" : "Pagano", "username" : "user1156", "age" : 18, "email" : "Stefania.Pagano@outlook.com", "bloodType" : "AB+", "id_num" : "334524587786", "registerDate" : ISODate("2018-09-10T20:36:59.783Z"), "ticketNumber" : 6429, "jobs" : [ "Marketing", "Ciências Naturais e Exatas" ], "favFruits" : [ "Goiaba", "Pêssego", "Laranja" ], "movies" : [ { "title" : "A Lista de Schindler (1993)", "rating" : 4.09 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 1.14 }, { "title" : "Cidade de Deus (2002)", "rating" : 0.11 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 3.47 }, { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 2.6 } ], "mother" : { "firstname" : "Federica", "surname" : "Pagano", "age" : 43 }, "cat" : { "name" : "Fabrizio", "age" : 14 }, "dog" : { "name" : "Stefania", "age" : 1 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00aed5"), "firstname" : "Michele", "surname" : "Lombardo", "username" : "user1200", "age" : 7, "email" : "Michele.Lombardo@gmail.com", "bloodType" : "B-", "id_num" : "884624506446", "registerDate" : ISODate("2008-08-27T05:43:39.044Z"), "ticketNumber" : 9004, "jobs" : [ "Produção Editorial", "Engenharia Industrial Madeireira" ], "favFruits" : [ "Banana", "Melancia", "Maçã" ], "movies" : [ { "title" : "Os Sete Samurais (1954)", "rating" : 0.26 }, { "title" : "Clube da Luta (1999)", "rating" : 1.69 }, { "title" : "Harakiri (1962)", "rating" : 3.96 } ], "cat" : { "name" : "Michele", "age" : 12 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00aeec"), "firstname" : "Sergio", "surname" : "Ferrari", "username" : "user1223", "age" : 74, "email" : "Sergio.Ferrari@yahoo.com", "bloodType" : "AB-", "id_num" : "012050728152", "registerDate" : ISODate("2016-02-13T17:05:10.735Z"), "ticketNumber" : 3963, "jobs" : [ "Engenharia Naval" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 1.05 } ], "dog" : { "name" : "Sergio", "age" : 3 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00af62"), "firstname" : "Salvatore", "surname" : "Pellegrino", "username" : "user1341", "age" : 12, "email" : "Salvatore.Pellegrino@outlook.com", "bloodType" : "AB+", "id_num" : "444123810887", "registerDate" : ISODate("2015-01-29T00:21:58.010Z"), "ticketNumber" : 7731, "jobs" : [ "Engenharia de Telecomunicações", "Produção Cultural" ], "favFruits" : [ "Melancia", "Pêssego", "Melancia" ], "movies" : [ { "title" : "Os Bons Companheiros (1990)", "rating" : 1.97 }, { "title" : "À Espera de um Milagre (1999)", "rating" : 0.8 }, { "title" : "Guerra nas Estrelas (1977)", "rating" : 3.26 }, { "title" : "12 Homens e uma Sentença (1957)", "rating" : 1.95 } ], "cat" : { "name" : "Alessio", "age" : 4 }, "dog" : { "name" : "Salvatore", "age" : 16 } }
            { "_id" : ObjectId("5e680f0bbdf084d4fe00af7c"), "firstname" : "Valentina", "surname" : "Damico", "username" : "user1367", "age" : 66, "email" : "Valentina.Damico@outlook.com", "bloodType" : "AB-", "id_num" : "561648673203", "registerDate" : ISODate("2018-08-17T14:02:04.240Z"), "ticketNumber" : 3767, "jobs" : [ "Energias Renováveis", "Sistemas de Telecomunicações" ], "favFruits" : [ "Laranja" ], "movies" : [ { "title" : "A Lista de Schindler (1993)", "rating" : 3.78 } ], "father" : { "firstname" : "Angela", "surname" : "Damico", "age" : 95 }, "dog" : { "name" : "Valentina", "age" : 10 } }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b038"), "firstname" : "Alessio", "surname" : "Giuliani", "username" : "user1555", "age" : 63, "email" : "Alessio.Giuliani@uol.com.br", "bloodType" : "A+", "id_num" : "203182852520", "registerDate" : ISODate("2018-07-12T16:33:04.147Z"), "ticketNumber" : 1668, "jobs" : [ "Defesa e Gestão Estratégica Internacional", "Psicopedagogia" ], "favFruits" : [ "Melancia" ], "movies" : [ { "title" : "A Origem (2010)", "rating" : 3.12 }, { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 1.48 }, { "title" : "O Poderoso Chefão II (1974)", "rating" : 2.67 } ], "cat" : { "name" : "Maurizio", "age" : 15 }, "dog" : { "name" : "Alessio", "age" : 9 } }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b083"), "firstname" : "Giorgio", "surname" : "D’Angelo", "username" : "user1630", "age" : 53, "email" : "Giorgio.D’Angelo@yahoo.com", "bloodType" : "AB-", "id_num" : "853045302787", "registerDate" : ISODate("2009-08-25T21:23:56.659Z"), "ticketNumber" : 2714, "jobs" : [ "Pedagogia", "Farmácia" ], "favFruits" : [ "Goiaba", "Tangerina" ], "movies" : [ { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 0.28 }, { "title" : "Harakiri (1962)", "rating" : 0.76 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 3.82 }, { "title" : "1917 (2019)", "rating" : 3.93 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 3.6 } ], "cat" : { "name" : "Giorgio", "age" : 16 }, "dog" : { "name" : "Michele", "age" : 8 } }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b122"), "firstname" : "Elisabetta", "surname" : "Neri", "username" : "user1789", "age" : 73, "email" : "Elisabetta.Neri@gmail.com", "bloodType" : "B+", "id_num" : "311880768230", "registerDate" : ISODate("2016-11-22T11:24:54.688Z"), "ticketNumber" : 8161, "jobs" : [ "Filosofia", "Fabricação Mecânica" ], "favFruits" : [ "Goiaba", "Kiwi", "Goiaba" ], "movies" : [ { "title" : "Vingadores: Ultimato (2019)", "rating" : 4.2 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 0.34 }, { "title" : "Gladiador (2000)", "rating" : 0.53 }, { "title" : "Gladiador (2000)", "rating" : 1.33 } ], "cat" : { "name" : "Elisabetta", "age" : 0 }, "dog" : { "name" : "Marta", "age" : 1 } }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b162"), "firstname" : "Emanuele", "surname" : "Milani", "username" : "user1853", "age" : 29, "email" : "Emanuele.Milani@uol.com.br", "bloodType" : "A+", "id_num" : "602273355253", "registerDate" : ISODate("2012-07-07T02:22:19.679Z"), "ticketNumber" : 7968, "jobs" : [ "Jogos Digitais" ], "favFruits" : [ "Kiwi", "Uva", "Melancia" ], "movies" : [ { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 0.83 }, { "title" : "Os Sete Samurais (1954)", "rating" : 4.65 }, { "title" : "Coringa (2019)", "rating" : 1.8 }, { "title" : "Três Homens em Conflito (1966)", "rating" : 4.72 } ], "cat" : { "name" : "Emanuele", "age" : 17 } }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b173"), "firstname" : "Mario", "surname" : "Colombo", "username" : "user1870", "age" : 59, "email" : "Mario.Colombo@yahoo.com", "bloodType" : "AB-", "id_num" : "410133813678", "registerDate" : ISODate("2014-03-29T19:53:00.124Z"), "ticketNumber" : 2810, "jobs" : [ "Sistemas Embarcados" ], "favFruits" : [ "Mamão", "Mamão" ], "movies" : [ { "title" : "Clube da Luta (1999)", "rating" : 1.54 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 3.37 } ], "mother" : { "firstname" : "Fabio", "surname" : "Colombo", "age" : 74 }, "dog" : { "name" : "Mario", "age" : 5 } }
            Type "it" for more

j) Projete apenas o nome e sobrenomedas pessoas com tipo de sangue de fator RH negativo
    Comando: db.getCollection("italians").find(
                { 
                    "bloodType" : { 
                        "$regex" : /\w{1,2}-/i
                    }
                }, 
                { 
                    "firstname" : "$firstname", 
                    "surname" : "$surname", 
                    "_id" : NumberInt(0)
                }
            );
    Output: { "firstname" : "Ilaria", "surname" : "Martinelli" }
            { "firstname" : "Massimiliano", "surname" : "Mariani" }
            { "firstname" : "Alessandra", "surname" : "Ricci" }
            { "firstname" : "Sabrina", "surname" : "Leone" }
            { "firstname" : "Elena", "surname" : "Longo" }
            { "firstname" : "Lucia", "surname" : "Farina" }
            { "firstname" : "Elena", "surname" : "Morelli" }
            { "firstname" : "Michela", "surname" : "Morelli" }
            { "firstname" : "Massimiliano", "surname" : "Neri" }
            { "firstname" : "Marta", "surname" : "Barone" }
            { "firstname" : "Emanuele", "surname" : "Fabbri" }
            { "firstname" : "Sonia", "surname" : "De Santis" }
            { "firstname" : "Paolo", "surname" : "Testa" }
            { "firstname" : "Anna", "surname" : "Benedetti" }
            { "firstname" : "Sabrina", "surname" : "Moretti" }
            { "firstname" : "Filipo", "surname" : "Serra" }
            { "firstname" : "Fabio", "surname" : "Martino" }
            { "firstname" : "Giuseppe", "surname" : "Rinaldi" }
            { "firstname" : "Daniele", "surname" : "Silvestri" }
            { "firstname" : "Elisabetta", "surname" : "Mazza" }
            Type "it" for more

k) Projete apenas os animais dos italianos. Devem ser listados os animais com nome e idade. Não mostre o identificado do mongo (ObjectId)
    Comando: db.getCollection("italians").find(
                { 
                    "cat" : { 
                        "$ne" : null
                    }, 
                    "dog" : { 
                        "$ne" : null
                    }
                }, 
                { 
                    "cat.name" : "$cat.name", 
                    "cat.age" : "$cat.age", 
                    "dog.name" : "$dog.name", 
                    "dog.age" : "$dog.age", 
                    "_id" : NumberInt(0)
                }
            );
    Output: { "cat" : { "name" : "Davide", "age" : 8 }, "dog" : { "name" : "Elisa", "age" : 14 } }
            { "cat" : { "name" : "Emanuela", "age" : 15 }, "dog" : { "name" : "Federico", "age" : 2 } }
            { "cat" : { "name" : "Tiziana", "age" : 5 }, "dog" : { "name" : "Elena", "age" : 13 } }
            { "cat" : { "name" : "Roberta", "age" : 0 }, "dog" : { "name" : "Fabrizio", "age" : 10 } }
            { "cat" : { "name" : "Sonia", "age" : 3 }, "dog" : { "name" : "Domenico", "age" : 11 } }
            { "cat" : { "name" : "Giusy", "age" : 16 }, "dog" : { "name" : "Patrizia", "age" : 0 } }
            { "cat" : { "name" : "Maria", "age" : 16 }, "dog" : { "name" : "Chiara", "age" : 12 } }
            { "cat" : { "name" : "Claudia", "age" : 15 }, "dog" : { "name" : "Giacomo", "age" : 0 } }
            { "cat" : { "name" : "Roberta", "age" : 3 }, "dog" : { "name" : "Antonio", "age" : 11 } }
            { "cat" : { "name" : "Mirko", "age" : 8 }, "dog" : { "name" : "Luca", "age" : 12 } }
            { "cat" : { "name" : "Anna", "age" : 1 }, "dog" : { "name" : "Cinzia", "age" : 6 } }
            { "cat" : { "name" : "Alessandra", "age" : 14 }, "dog" : { "name" : "Giorgio", "age" : 5 } }
            { "cat" : { "name" : "Ilaria", "age" : 17 }, "dog" : { "name" : "Simona", "age" : 6 } }
            { "cat" : { "name" : "Martina", "age" : 15 }, "dog" : { "name" : "Mirko", "age" : 11 } }
            { "cat" : { "name" : "Angelo", "age" : 17 }, "dog" : { "name" : "Fabrizio", "age" : 12 } }
            { "cat" : { "name" : "Simone", "age" : 14 }, "dog" : { "name" : "Laura", "age" : 9 } }
            { "cat" : { "name" : "Sara", "age" : 11 }, "dog" : { "name" : "Ilaria", "age" : 6 } }
            { "cat" : { "name" : "Fabrizio", "age" : 15 }, "dog" : { "name" : "Lucia", "age" : 4 } }
            { "cat" : { "name" : "Raffaele", "age" : 8 }, "dog" : { "name" : "Carlo", "age" : 13 } }
            { "cat" : { "name" : "Emanuele", "age" : 8 }, "dog" : { "name" : "Tiziana", "age" : 1 } }
            Type "it" for more

l) Quais são as 5 pessoas mais velhas com sobrenome Rossi?
    Comando:db.getCollection("italians").find(
                { 
                    "surname" : "Rossi"
                }, 
                { 
                    "firstname" : "$firstname", 
                    "surname" : "$surname", 
                    "age" : "$age", 
                    "_id" : NumberInt(0)
                }
            ).sort(
                { 
                    "age" : NumberInt(-1)
                }
            ).limit(5);
    Output: { "firstname" : "Massimo", "surname" : "Rossi", "age" : 79 }
            { "firstname" : "Elisabetta", "surname" : "Rossi", "age" : 77 }
            { "firstname" : "Sonia", "surname" : "Rossi", "age" : 76 }
            { "firstname" : "Andrea", "surname" : "Rossi", "age" : 71 }
            { "firstname" : "Giorgio", "surname" : "Rossi", "age" : 70 }

m) Crie um italiano que tenha um leão como animal de estimação. Associe um nome e idade ao bichano
    Comando: db.getCollection("italians").insert({ 
                "firstname" : "Emanuele", 
                "surname" : "Bianco", 
                "username" : "user130", 
                "age" : 56.0, 
                "email" : "Emanuele.Bianco@gmail.com", 
                "bloodType" : "A+", 
                "id_num" : "664641167228", 
                "registerDate" : ISODate("2012-07-13T20:39:13.001+0000"), 
                "ticketNumber" : 5988.0, 
                "jobs" : [
                    "Engenharia de Transporte e da Mobilidade", 
                    "Engenharia de Transporte e da Mobilidade"
                ], 
                "favFruits" : [
                    "Tangerina", 
                    "Goiaba"
                ], 
                "movies" : [
                    {
                        "title" : "Pulp Fiction: Tempo de Violência (1994)", 
                        "rating" : 1.27
                    }, 
                    {
                        "title" : "Batman: O Cavaleiro das Trevas (2008)", 
                        "rating" : 1.73
                    }, 
                    {
                        "title" : "1917 (2019)", 
                        "rating" : 2.59
                    }, 
                    {
                        "title" : "A Viagem de Chihiro (2001)", 
                        "rating" : 2.67
                    }
                ], 
                "lion" : {
                    "name" : "Alex", 
                    "age" : 15.0
                }
            });
    Output: riteResult({ "nInserted" : 1 })

n) Infelizmente o Leão comeu o italiano. Remova essa pessoa usando o Id
    Comando: db.getCollection("italians").remove({"_id": ObjectId("5e68237aa148741caf077843")})
    Output: WriteResult({ "nRemoved" : 1 })

o) Passou um ano. Atualize a idade de todos os italianos e dos bichanos em 1
    Comando: db.getCollection("italians").update( { }, { "$inc": { "age": 1 } }, { multi: true } );
             db.getCollection("italians").update( { "cat": { "$exists": true } }, { "$inc": { "cat.age": 1 } },{ multi: true } );
             db.getCollection("italians").update( { "dog": { "$exists": true } }, { "$inc": { "dog.age": 1 } },{ multi: true } );
    Output: WriteResult({ "nMatched" : 10000, "nUpserted" : 0, "nModified" : 10000 })
            WriteResult({ "nMatched" : 6047, "nUpserted" : 0, "nModified" : 6047 })
            WriteResult({ "nMatched" : 4053, "nUpserted" : 0, "nModified" : 4053 })

p) O Corona Vírus chegou na Itália e misteriosamente atingiu pessoas somente com gatos e de 66 anos. Remova esses italianos
    Comando: db.getCollection("italians").remove(
                { 
                    "age" : NumberLong(66), 
                    "cat" : { 
                        "$ne" : null
                    }
                }
            );
    Output: WriteResult({ "nRemoved" : 76 })

q) Utilizando o framework agregate, liste apenas as pessoas com nomes iguais a sua respectiva mãe e que tenha gato ou cachorro
    Comando: db.getCollection("italians").aggregate(
            [
                {
                    "$match":
                    {
                        "$and": 
                        [
                            {
                                mother:
                                {
                                    $exists:1
                                }
                            }, 
                            {
                                "$or": 
                                [
                                    {
                                        dog:
                                        {
                                            $exists:1
                                        }
                                    }, 
                                    {
                                        cat:
                                        {
                                            $exists:1
                                        }
                                    }
                                ]
                            }
                    ]
                    }
                },
                {
                    "$addFields": 
                    { 
                        isEqual: 
                        {
                            "$cmp":
                                [
                                    "$firstname","$mother.firstname"
                                ]
                        }
                    }
                },
                {
                    "$match":
                        {
                            "isEqual":0
                        }
                }
            ])
    Output: { "_id" : ObjectId("5e680f09bdf084d4fe00aaba"), "firstname" : "Federica", "surname" : "Martino", "username" : "user149", "age" : 46, "email" : "Federica.Martino@live.com", "bloodType" : "A+", "id_num" : "448576806861", "registerDate" : ISODate("2008-09-04T15:29:20.386Z"), "ticketNumber" : 3823, "jobs" : [ "Turismo", "Comércio Exterior" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "O Poderoso Chefão (1972)", "rating" : 1.94 }, { "title" : "Um Sonho de Liberdade (1994)", "rating" : 2.51 }, { "title" : "Coringa (2019)", "rating" : 3.17 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 4.47 }, { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 2.32 } ], "mother" : { "firstname" : "Federica", "surname" : "Martino", "age" : 61 }, "father" : { "firstname" : "Nicola", "surname" : "Martino", "age" : 61 }, "cat" : { "name" : "Laura", "age" : 15 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab22"), "firstname" : "Barbara", "surname" : "D’Angelo", "username" : "user253", "age" : 13, "email" : "Barbara.D’Angelo@uol.com.br", "bloodType" : "B-", "id_num" : "551578812417", "registerDate" : ISODate("2007-08-29T12:11:12.979Z"), "ticketNumber" : 2886, "jobs" : [ "Comunicação Institucional" ], "favFruits" : [ "Banana", "Tangerina", "Mamão" ], "movies" : [ { "title" : "Três Homens em Conflito (1966)", "rating" : 4.21 }, { "title" : "Harakiri (1962)", "rating" : 0.05 }, { "title" : "A Lista de Schindler (1993)", "rating" : 1.76 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 4.24 } ], "mother" : { "firstname" : "Barbara", "surname" : "D’Angelo", "age" : 37 }, "dog" : { "name" : "Daniela", "age" : 14 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0abdf084d4fe00abc5"), "firstname" : "Lorenzo", "surname" : "Fontana", "username" : "user416", "age" : 33, "email" : "Lorenzo.Fontana@live.com", "bloodType" : "AB-", "id_num" : "650880644382", "registerDate" : ISODate("2016-08-30T16:58:03.965Z"), "ticketNumber" : 9679, "jobs" : [ "Engenharia Mecatrônica" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "Matrix (1999)", "rating" : 1.33 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 4.54 }, { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 3.19 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 0.64 }, { "title" : "Os Sete Samurais (1954)", "rating" : 0.79 } ], "mother" : { "firstname" : "Lorenzo", "surname" : "Fontana", "age" : 64 }, "father" : { "firstname" : "Elena", "surname" : "Fontana", "age" : 67 }, "cat" : { "name" : "Giovanni", "age" : 14 }, "dog" : { "name" : "Domenico", "age" : 18 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0cbdf084d4fe00b0c1"), "firstname" : "Patrizia", "surname" : "Sala", "username" : "user1692", "age" : 60, "email" : "Patrizia.Sala@outlook.com", "bloodType" : "A+", "id_num" : "273840205663", "registerDate" : ISODate("2008-09-05T00:03:13.577Z"), "ticketNumber" : 3376, "jobs" : [ "Irrigação e Drenagem", "Engenharia Têxtil" ], "favFruits" : [ "Goiaba" ], "movies" : [ { "title" : "Seven: Os Sete Crimes Capitais (1995)", "rating" : 3.05 }, { "title" : "Gladiador (2000)", "rating" : 2.31 }, { "title" : "Coringa (2019)", "rating" : 4.89 } ], "mother" : { "firstname" : "Patrizia", "surname" : "Sala", "age" : 87 }, "cat" : { "name" : "Martina", "age" : 13 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0dbdf084d4fe00b539"), "firstname" : "Federica", "surname" : "Barone", "username" : "user2836", "age" : 39, "email" : "Federica.Barone@gmail.com", "bloodType" : "A-", "id_num" : "570165151817", "registerDate" : ISODate("2009-11-01T21:25:53.366Z"), "ticketNumber" : 8720, "jobs" : [ "Saneamento Ambiental" ], "favFruits" : [ "Banana", "Melancia", "Mamão" ], "movies" : [ { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 0.6 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 4.17 }, { "title" : "12 Homens e uma Sentença (1957)", "rating" : 1.15 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 4.4 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 3.3 } ], "mother" : { "firstname" : "Federica", "surname" : "Barone", "age" : 67 }, "father" : { "firstname" : "Antonella", "surname" : "Barone", "age" : 66 }, "cat" : { "name" : "Roberto", "age" : 5 }, "dog" : { "name" : "Maurizio", "age" : 10 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0fbdf084d4fe00bc5e"), "firstname" : "Maurizio", "surname" : "Benedetti", "username" : "user4665", "age" : 44, "email" : "Maurizio.Benedetti@uol.com.br", "bloodType" : "O+", "id_num" : "330101665263", "registerDate" : ISODate("2008-09-01T01:44:12.195Z"), "ticketNumber" : 3310, "jobs" : [ "Luteria" ], "favFruits" : [ "Maçã", "Melancia" ], "movies" : [ { "title" : "O Poderoso Chefão II (1974)", "rating" : 4.29 }, { "title" : "A Vida é Bela (1997)", "rating" : 4.23 }, { "title" : "Cidade de Deus (2002)", "rating" : 0.76 } ], "mother" : { "firstname" : "Maurizio", "surname" : "Benedetti", "age" : 61 }, "father" : { "firstname" : "Riccardo", "surname" : "Benedetti", "age" : 72 }, "cat" : { "name" : "Claudia", "age" : 14 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f0fbdf084d4fe00bc6b"), "firstname" : "Alex", "surname" : "Grassi", "username" : "user4678", "age" : 73, "email" : "Alex.Grassi@live.com", "bloodType" : "B-", "id_num" : "041358830802", "registerDate" : ISODate("2015-03-02T08:06:52.564Z"), "ticketNumber" : 8280, "jobs" : [ "Design de Interiores" ], "favFruits" : [ "Kiwi", "Maçã" ], "movies" : [ { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 4.67 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 4.42 } ], "mother" : { "firstname" : "Alex", "surname" : "Grassi", "age" : 88 }, "cat" : { "name" : "Federico", "age" : 12 }, "dog" : { "name" : "Paola", "age" : 9 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f12bdf084d4fe00c204"), "firstname" : "Tiziana", "surname" : "Palmieri", "username" : "user6111", "age" : 11, "email" : "Tiziana.Palmieri@uol.com.br", "bloodType" : "B+", "id_num" : "766777277430", "registerDate" : ISODate("2007-05-18T11:58:30.027Z"), "ticketNumber" : 2329, "jobs" : [ "Fotografia" ], "favFruits" : [ "Melancia" ], "movies" : [ { "title" : "Um Sonho de Liberdade (1994)", "rating" : 0.32 }, { "title" : "A Origem (2010)", "rating" : 4.19 }, { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 0.56 }, { "title" : "Cidade de Deus (2002)", "rating" : 2.17 }, { "title" : "Coringa (2019)", "rating" : 4.51 } ], "mother" : { "firstname" : "Tiziana", "surname" : "Palmieri", "age" : 38 }, "cat" : { "name" : "Giovanni", "age" : 13 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f12bdf084d4fe00c325"), "firstname" : "Gianluca", "surname" : "Marchetti", "username" : "user6400", "age" : 49, "email" : "Gianluca.Marchetti@live.com", "bloodType" : "AB-", "id_num" : "880177800403", "registerDate" : ISODate("2008-11-21T20:22:28.673Z"), "ticketNumber" : 5376, "jobs" : [ "Linguística" ], "favFruits" : [ "Maçã", "Kiwi", "Uva" ], "movies" : [ { "title" : "O Senhor dos Anéis: As Duas Torres (2002)", "rating" : 0.21 }, { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 1.04 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 3.55 }, { "title" : "Parasita (2019)", "rating" : 4.56 } ], "mother" : { "firstname" : "Gianluca", "surname" : "Marchetti", "age" : 73 }, "father" : { "firstname" : "Maurizio", "surname" : "Marchetti", "age" : 74 }, "cat" : { "name" : "Giovanni", "age" : 13 }, "dog" : { "name" : "Simone", "age" : 18 }, "isEqual" : 0 }
            { "_id" : ObjectId("5e680f12bdf084d4fe00c36a"), "firstname" : "Vincenzo", "surname" : "Vitale", "username" : "user6469", "age" : 49, "email" : "Vincenzo.Vitale@gmail.com", "bloodType" : "B-", "id_num" : "380611664636", "registerDate" : ISODate("2010-01-04T22:32:01.365Z"), "ticketNumber" : 139, "jobs" : [ "Gestão de Cooperativas", "Serviços Judiciários e Notariais" ], "favFruits" : [ "Mamão" ], "movies" : [ { "title" : "Intocáveis (2011)", "rating" : 0.84 }, { "title" : "Os Sete Samurais (1954)", "rating" : 0.09 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 4.27 } ], "mother" : { "firstname" : "Vincenzo", "surname" : "Vitale", "age" : 67 }, "dog" : { "name" : "Massimiliano", "age" : 10 }, "isEqual" : 0 }



r) Utilizando aggregate framework, faça uma lista de nomes única de nomes. Faça isso usando apenas o primeiro nome
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$project" : { 
                            "firstname" : "$firstname", 
                            "_id" : NumberInt(0)
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : null, 
                            "distinct" : { 
                                "$addToSet" : "$$ROOT"
                            }
                        }
                    }, 
                    { 
                        "$unwind" : { 
                            "path" : "$distinct", 
                            "preserveNullAndEmptyArrays" : false
                        }
                    }, 
                    { 
                        "$replaceRoot" : { 
                            "newRoot" : "$distinct"
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "firstname" : "Stefania" }
            { "firstname" : "Angela" }
            { "firstname" : "Roberto" }
            { "firstname" : "Marco" }
            { "firstname" : "Vincenzo" }
            { "firstname" : "Valeira" }
            { "firstname" : "Alberto" }
            { "firstname" : "Monica" }
            { "firstname" : "Giorgio" }
            { "firstname" : "Michele" }
            { "firstname" : "Mirko" }
            { "firstname" : "Daniele" }
            { "firstname" : "Veronica" }
            { "firstname" : "Martina" }
            { "firstname" : "Sabrina" }
            { "firstname" : "Federico" }
            { "firstname" : "Andrea" }
            { "firstname" : "Pietro" }
            { "firstname" : "Maurizio" }
            Type "it" for more

s) Agora faça a mesma lista do item acima, considerando nome completo
    Comando: db.getCollection("italians").aggregate(
                [
                    { 
                        "$project" : { 
                            "fullname" : { $concat: [ "$firstname", " ", "$surname" ] } , 
                            "_id" : NumberInt(0)
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : null, 
                            "distinct" : { 
                                "$addToSet" : "$$ROOT"
                            }
                        }
                    }, 
                    { 
                        "$unwind" : { 
                            "path" : "$distinct", 
                            "preserveNullAndEmptyArrays" : false
                        }
                    }, 
                    { 
                        "$replaceRoot" : { 
                            "newRoot" : "$distinct"
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "fullname" : "Angela Lombardo" }
            { "fullname" : "Alessandra Fiore" }
            { "fullname" : "Fabrizio Costatini" }
            { "fullname" : "Stefania Conti" }
            { "fullname" : "Ilaria Rinaldi" }
            { "fullname" : "Roberto De Luca" }
            { "fullname" : "Sabrina De Angelis" }
            { "fullname" : "Antonella Costatini" }
            { "fullname" : "Emanuele Pellegrini" }
            { "fullname" : "Lucia Galli" }
            { "fullname" : "Serena Serra" }
            { "fullname" : "Anna Ferrari" }
            { "fullname" : "Carlo Rizzo" }
            { "fullname" : "Giorgio Grasso" }
            { "fullname" : "Ilaria De Rosa" }
            { "fullname" : "Daniele Orlando" }
            { "fullname" : "Enzo  Ferretti" }
            { "fullname" : "Domenico Grassi" }
            { "fullname" : "Silvia D’Angelo" }
            { "fullname" : "Anna Donati" }
            Type "it" for more

t) Procure pessoas que gosta de Banana ou Maçã, tenham cachorro ou gato, mais de 20 e menos de 60 anos
    Comando: db.getCollection("italians").find(
                { 
                    "$and" : [
                        { 
                            "favFruits" : { 
                                "$in" : [
                                    "Banana", 
                                    "Maça"
                                ]
                            }
                        }, 
                        { 
                            "$or" : [
                                { 
                                    "dog" : { 
                                        "$exists" : true
                                    }
                                }, 
                                { 
                                    "cat" : { 
                                        "$exists" : true
                                    }
                                }
                            ]
                        }, 
                        { 
                            "age" : { 
                                "$gt" : 20.0
                            }
                        }, 
                        { 
                            "age" : { 
                                "$lt" : 60.0
                            }
                        }
                    ]
                }
            );
    Output: { "_id" : ObjectId("5e680f09bdf084d4fe00aaa4"), "firstname" : "Federica", "surname" : "Morelli", "username" : "user127", "age" : 34, "email" : "Federica.Morelli@gmail.com", "bloodType" : "B+", "id_num" : "446181011108", "registerDate" : ISODate("2015-05-20T07:20:44.210Z"), "ticketNumber" : 3186, "jobs" : [ "Esporte", "Ecologia" ], "favFruits" : [ "Tangerina", "Banana" ], "movies" : [ { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.56 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 2.5 } ], "dog" : { "name" : "Cinzia", "age" : 7 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaa5"), "firstname" : "Filipo", "surname" : "Serra", "username" : "user128", "age" : 54, "email" : "Filipo.Serra@gmail.com", "bloodType" : "A-", "id_num" : "605317521764", "registerDate" : ISODate("2014-11-15T12:13:20.458Z"), "ticketNumber" : 135, "jobs" : [ "Gestão Hospitalar", "Sistemas de Informação" ], "favFruits" : [ "Goiaba", "Banana", "Maçã" ], "movies" : [ { "title" : "Intocáveis (2011)", "rating" : 1.09 }, { "title" : "Parasita (2019)", "rating" : 0.49 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 1.83 }, { "title" : "O Resgate do Soldado Ryan (1998)", "rating" : 2.42 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.05 } ], "cat" : { "name" : "Patrizia", "age" : 5 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aaac"), "firstname" : "Elisabetta", "surname" : "Mazza", "username" : "user135", "age" : 42, "email" : "Elisabetta.Mazza@yahoo.com", "bloodType" : "A-", "id_num" : "775721118158", "registerDate" : ISODate("2018-04-06T18:30:44.349Z"), "ticketNumber" : 75, "jobs" : [ "Comunicação Institucional" ], "favFruits" : [ "Laranja", "Banana", "Kiwi" ], "movies" : [ { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 2.88 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 1.1 }, { "title" : "À Espera de um Milagre (1999)", "rating" : 2.89 } ], "cat" : { "name" : "Angelo", "age" : 11 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aab8"), "firstname" : "Rita", "surname" : "Barone", "username" : "user147", "age" : 56, "email" : "Rita.Barone@uol.com.br", "bloodType" : "O-", "id_num" : "043361758546", "registerDate" : ISODate("2007-11-18T11:52:32.224Z"), "ticketNumber" : 8881, "jobs" : [ "Gestão Desportiva e de Lazer" ], "favFruits" : [ "Banana", "Goiaba" ], "movies" : [ { "title" : "O Poderoso Chefão (1972)", "rating" : 0.38 }, { "title" : "Intocáveis (2011)", "rating" : 1.77 }, { "title" : "A Viagem de Chihiro (2001)", "rating" : 4.74 }, { "title" : "A Felicidade Não se Compra (1946)", "rating" : 4.59 } ], "dog" : { "name" : "Luigi", "age" : 1 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aabc"), "firstname" : "Giorgia", "surname" : "Costa", "username" : "user151", "age" : 23, "email" : "Giorgia.Costa@live.com", "bloodType" : "A-", "id_num" : "773284068863", "registerDate" : ISODate("2014-07-02T01:54:55.320Z"), "ticketNumber" : 6351, "jobs" : [ "Ciências Atuariais", "Jornalismo" ], "favFruits" : [ "Goiaba", "Banana" ], "movies" : [ { "title" : "Guerra nas Estrelas (1977)", "rating" : 4.15 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 1.01 } ], "cat" : { "name" : "Gabiele", "age" : 10 } }
            { "_id" : ObjectId("5e680f09bdf084d4fe00aac7"), "firstname" : "Giovanna", "surname" : "Barone", "username" : "user162", "age" : 51, "email" : "Giovanna.Barone@yahoo.com", "bloodType" : "A-", "id_num" : "725046870575", "registerDate" : ISODate("2017-03-27T11:07:01.618Z"), "ticketNumber" : 6690, "jobs" : [ "Papel e Celulose" ], "favFruits" : [ "Maçã", "Banana", "Maçã" ], "movies" : [ { "title" : "Os Bons Companheiros (1990)", "rating" : 1.36 }, { "title" : "Harakiri (1962)", "rating" : 4.03 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 2.74 }, { "title" : "Star Wars, Episódio V: O Império Contra-Ataca (1980)", "rating" : 1.64 } ], "father" : { "firstname" : "Anna", "surname" : "Barone", "age" : 88 }, "cat" : { "name" : "Domenico", "age" : 18 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00aae0"), "firstname" : "Cristian", "surname" : "Orlando", "username" : "user187", "age" : 44, "email" : "Cristian.Orlando@hotmail.com", "bloodType" : "O-", "id_num" : "865024501615", "registerDate" : ISODate("2009-02-02T17:36:12.697Z"), "ticketNumber" : 7404, "jobs" : [ "Geografia", "Engenharia Química" ], "favFruits" : [ "Banana", "Tangerina" ], "movies" : [ { "title" : "O Senhor dos Anéis: A Sociedade do Anel (2001)", "rating" : 0.86 }, { "title" : "Gladiador (2000)", "rating" : 0.09 }, { "title" : "Os Bons Companheiros (1990)", "rating" : 3.42 } ], "cat" : { "name" : "Daniele", "age" : 3 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab01"), "firstname" : "Pietro", "surname" : "Silvestri", "username" : "user220", "age" : 32, "email" : "Pietro.Silvestri@outlook.com", "bloodType" : "AB-", "id_num" : "026010712202", "registerDate" : ISODate("2011-02-11T11:39:04.129Z"), "ticketNumber" : 8623, "jobs" : [ "Serviço Social", "Sistemas Biomédicos" ], "favFruits" : [ "Mamão", "Banana" ], "movies" : [ { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 2.75 }, { "title" : "O Silêncio dos Inocentes (1991)", "rating" : 3.95 }, { "title" : "Clube da Luta (1999)", "rating" : 3.95 }, { "title" : "Coringa (2019)", "rating" : 0.06 } ], "father" : { "firstname" : "Nicola", "surname" : "Silvestri", "age" : 63 }, "dog" : { "name" : "Ilaria", "age" : 17 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab2e"), "firstname" : "Teresa", "surname" : "Coppola", "username" : "user265", "age" : 23, "email" : "Teresa.Coppola@yahoo.com", "bloodType" : "A-", "id_num" : "683658605357", "registerDate" : ISODate("2016-06-27T18:07:47.789Z"), "ticketNumber" : 8078, "jobs" : [ "Produção Fonográfica" ], "favFruits" : [ "Kiwi", "Goiaba", "Banana" ], "movies" : [ { "title" : "Três Homens em Conflito (1966)", "rating" : 4.19 } ], "cat" : { "name" : "Marco", "age" : 11 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab5f"), "firstname" : "Marco", "surname" : "Mazza", "username" : "user314", "age" : 30, "email" : "Marco.Mazza@yahoo.com", "bloodType" : "B+", "id_num" : "681017885234", "registerDate" : ISODate("2015-07-08T18:45:57.655Z"), "ticketNumber" : 610, "jobs" : [ "Museologia" ], "favFruits" : [ "Tangerina", "Banana", "Pêssego" ], "movies" : [ { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 4.28 }, { "title" : "Interestelar (2014)", "rating" : 0.06 } ], "cat" : { "name" : "Pietro", "age" : 13 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab67"), "firstname" : "Pietro", "surname" : "Mazza", "username" : "user322", "age" : 24, "email" : "Pietro.Mazza@gmail.com", "bloodType" : "AB+", "id_num" : "064821074863", "registerDate" : ISODate("2007-07-17T11:05:11.467Z"), "ticketNumber" : 8957, "jobs" : [ "Sistemas Biomédicos", "Engenharia de Alimentos" ], "favFruits" : [ "Banana" ], "movies" : [ { "title" : "Coringa (2019)", "rating" : 1.35 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 2.95 } ], "cat" : { "name" : "Federico", "age" : 11 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab75"), "firstname" : "Mattia", "surname" : "Cattaneo", "username" : "user336", "age" : 33, "email" : "Mattia.Cattaneo@outlook.com", "bloodType" : "B+", "id_num" : "504621136655", "registerDate" : ISODate("2013-06-13T15:15:49.733Z"), "ticketNumber" : 3590, "jobs" : [ "Agrimensura", "Produção Audiovisual" ], "favFruits" : [ "Goiaba", "Banana", "Laranja" ], "movies" : [ { "title" : "Coringa (2019)", "rating" : 2.67 }, { "title" : "Parasita (2019)", "rating" : 4.27 } ], "cat" : { "name" : "Giorgio", "age" : 7 }, "dog" : { "name" : "Vincenzo", "age" : 5 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab7e"), "firstname" : "Elisabetta", "surname" : "Mariani", "username" : "user345", "age" : 21, "email" : "Elisabetta.Mariani@uol.com.br", "bloodType" : "A+", "id_num" : "105738341032", "registerDate" : ISODate("2019-04-03T02:47:33.137Z"), "ticketNumber" : 7751, "jobs" : [ "Energias Renováveis", "Gestão de Recursos Humanos" ], "favFruits" : [ "Laranja", "Melancia", "Banana" ], "movies" : [ { "title" : "A Lista de Schindler (1993)", "rating" : 1.07 }, { "title" : "Vingadores: Ultimato (2019)", "rating" : 3.86 } ], "cat" : { "name" : "Mario", "age" : 6 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab80"), "firstname" : "Giuseppe", "surname" : "De Rosa", "username" : "user347", "age" : 29, "email" : "Giuseppe.De Rosa@outlook.com", "bloodType" : "B-", "id_num" : "088003887181", "registerDate" : ISODate("2020-02-27T07:40:11.113Z"), "ticketNumber" : 6185, "jobs" : [ "Silvicultura", "Negócios Imobiliários" ], "favFruits" : [ "Maçã", "Mamão", "Banana" ], "movies" : [ { "title" : "O Poderoso Chefão II (1974)", "rating" : 0.72 }, { "title" : "Parasita (2019)", "rating" : 3 }, { "title" : "O Senhor dos Anéis: O Retorno do Rei (2003)", "rating" : 2.4 }, { "title" : "Pulp Fiction: Tempo de Violência (1994)", "rating" : 3.02 } ], "cat" : { "name" : "Michele", "age" : 17 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab83"), "firstname" : "Anna", "surname" : "Coppola", "username" : "user350", "age" : 40, "email" : "Anna.Coppola@live.com", "bloodType" : "AB-", "id_num" : "212547800387", "registerDate" : ISODate("2010-06-01T13:23:34.208Z"), "ticketNumber" : 8718, "jobs" : [ "Redes de Computadores" ], "favFruits" : [ "Banana" ], "movies" : [ { "title" : "12 Homens e uma Sentença (1957)", "rating" : 2.26 }, { "title" : "O Poderoso Chefão (1972)", "rating" : 3.49 }, { "title" : "Forrest Gump: O Contador de Histórias (1994)", "rating" : 0.58 }, { "title" : "O Poderoso Chefão II (1974)", "rating" : 1.29 } ], "dog" : { "name" : "Filipo", "age" : 14 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab86"), "firstname" : "Giusy", "surname" : "Mazza", "username" : "user353", "age" : 30, "email" : "Giusy.Mazza@hotmail.com", "bloodType" : "B+", "id_num" : "631642748651", "registerDate" : ISODate("2018-01-15T02:06:34.240Z"), "ticketNumber" : 4288, "jobs" : [ "Tradutor e Intérprete", "Relações Públicas" ], "favFruits" : [ "Banana", "Kiwi", "Tangerina" ], "movies" : [ { "title" : "Clube da Luta (1999)", "rating" : 3.64 } ], "cat" : { "name" : "Marta", "age" : 7 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab90"), "firstname" : "Stefano", "surname" : "Gallo", "username" : "user363", "age" : 47, "email" : "Stefano.Gallo@gmail.com", "bloodType" : "AB+", "id_num" : "233684837075", "registerDate" : ISODate("2013-06-11T19:57:01.158Z"), "ticketNumber" : 7206, "jobs" : [ "Automação Industrial", "Sistemas de Informação" ], "favFruits" : [ "Goiaba", "Banana", "Tangerina" ], "movies" : [ { "title" : "Gladiador (2000)", "rating" : 3.07 } ], "cat" : { "name" : "Alessia", "age" : 1 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab91"), "firstname" : "Emanuela", "surname" : "Conte", "username" : "user364", "age" : 30, "email" : "Emanuela.Conte@uol.com.br", "bloodType" : "B+", "id_num" : "758642824251", "registerDate" : ISODate("2014-03-26T23:59:35.994Z"), "ticketNumber" : 7031, "jobs" : [ "Zootecnia" ], "favFruits" : [ "Banana" ], "movies" : [ { "title" : "À Espera de um Milagre (1999)", "rating" : 4.93 }, { "title" : "Harakiri (1962)", "rating" : 2.17 } ], "cat" : { "name" : "Pietro", "age" : 4 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab92"), "firstname" : "Claudia", "surname" : "Damico", "username" : "user365", "age" : 45, "email" : "Claudia.Damico@hotmail.com", "bloodType" : "A-", "id_num" : "337705857245", "registerDate" : ISODate("2016-06-26T04:02:02.587Z"), "ticketNumber" : 3814, "jobs" : [ "Construção Naval", "Engenharia Industrial Madeireira" ], "favFruits" : [ "Laranja", "Mamão", "Banana" ], "movies" : [ { "title" : "Interestelar (2014)", "rating" : 1.12 } ], "dog" : { "name" : "Gianluca", "age" : 12 } }
            { "_id" : ObjectId("5e680f0abdf084d4fe00ab9a"), "firstname" : "Claudio", "surname" : "Bernardi", "username" : "user373", "age" : 31, "email" : "Claudio.Bernardi@live.com", "bloodType" : "AB+", "id_num" : "065478483728", "registerDate" : ISODate("2012-03-10T18:19:23.889Z"), "ticketNumber" : 6625, "jobs" : [ "Ecologia", "Engenharia Civil" ], "favFruits" : [ "Melancia", "Banana" ], "movies" : [ { "title" : "Batman: O Cavaleiro das Trevas (2008)", "rating" : 3.46 } ], "cat" : { "name" : "Teresa", "age" : 3 } }
            Type "it" for more

Exercicio 3 - Stockbrokers

a) Liste as ações com profit acima de 0.5 (limite a 10 o resultado)
    Comando: db.getCollection("stock").find(
                { 
                    "Profit Margin" : { 
                        "$gt" : 0.5
                    }
                }
            ).limit(10);
    Output: { "_id" : ObjectId("52853800bb1177ca391c180f"), "Ticker" : "AB", "Profit Margin" : 0.896, "Institutional Ownership" : 0.368, "EPS growth past 5 years" : -0.348, "Total Debt/Equity" : 0, "Return on Assets" : 0.086, "Sector" : "Financial", "P/S" : 13.25, "Change from Open" : 0.0047, "Performance (YTD)" : 0.3227, "Performance (Week)" : -0.0302, "Insider Transactions" : 0.5973, "P/B" : 1.4, "EPS growth quarter over quarter" : 2.391, "Payout Ratio" : 1.75, "Performance (Quarter)" : 0.0929, "Forward P/E" : 12.58, "P/E" : 15.82, "200-Day Simple Moving Average" : 0.0159, "Shares Outstanding" : 92.26, "Earnings Date" : ISODate("2013-10-24T12:30:00Z"), "52-Week High" : -0.1859, "Change" : -0.0009, "Analyst Recom" : 3, "Volatility (Week)" : 0.0264, "Country" : "USA", "Return on Equity" : 0.087, "50-Day Low" : 0.123, "Price" : 21.5, "50-Day High" : -0.0574, "Return on Investment" : 0.033, "Shares Float" : 86.66, "Dividend Yield" : 0.0743, "EPS growth next 5 years" : 0.08, "Industry" : "Asset Management", "Beta" : 1.63, "Operating Margin" : 1, "EPS (ttm)" : 1.36, "PEG" : 1.98, "Float Short" : 0.0253, "52-Week Low" : 0.4687, "Average True Range" : 0.59, "EPS growth next year" : 0.0654, "Sales growth past 5 years" : -0.298, "Company" : "AllianceBernstein Holding L.P.", "Gap" : -0.0056, "Relative Volume" : 0.63, "Volatility (Month)" : 0.0298, "Market Cap" : 1985.39, "Volume" : 199677, "Short Ratio" : 6.3, "Performance (Half Year)" : -0.1159, "Relative Strength Index (14)" : 50.05, "Insider Ownership" : 0.002, "20-Day Simple Moving Average" : -0.007, "Performance (Month)" : 0.0847, "P/Free Cash Flow" : 93.21, "Institutional Transactions" : 0.0818, "Performance (Year)" : 0.3884, "LT Debt/Equity" : 0, "Average Volume" : 348.08, "EPS growth this year" : 1.567, "50-Day Simple Moving Average" : 0.0458 }
            { "_id" : ObjectId("52853801bb1177ca391c1895"), "Ticker" : "AGNC", "Profit Margin" : 0.972, "Institutional Ownership" : 0.481, "EPS growth past 5 years" : -0.0107, "Total Debt/Equity" : 8.56, "Return on Assets" : 0.022, "Sector" : "Financial", "P/S" : 3.77, "Change from Open" : 0.0102, "Performance (YTD)" : -0.1652, "Performance (Week)" : -0.017, "Insider Transactions" : 0.4931, "P/B" : 0.86, "EPS growth quarter over quarter" : -8.2, "Payout Ratio" : 0.79, "Performance (Quarter)" : -0.0083, "Forward P/E" : 7.64, "P/E" : 3.68, "200-Day Simple Moving Average" : -0.1282, "Shares Outstanding" : 390.6, "Earnings Date" : ISODate("2013-10-28T20:30:00Z"), "52-Week High" : -0.2938, "P/Cash" : 3.93, "Change" : 0.0131, "Analyst Recom" : 2.6, "Volatility (Week)" : 0.0268, "Country" : "USA", "Return on Equity" : 0.205, "50-Day Low" : 0.0695, "Price" : 21.71, "50-Day High" : -0.1066, "Return on Investment" : 0.015, "Shares Float" : 383.97, "Dividend Yield" : 0.1493, "EPS growth next 5 years" : 0.035, "Industry" : "REIT - Residential", "Beta" : 0.51, "Sales growth quarter over quarter" : 0.073, "Operating Margin" : 0.67, "EPS (ttm)" : 5.82, "PEG" : 1.05, "Float Short" : 0.0311, "52-Week Low" : 0.1117, "Average True Range" : 0.52, "EPS growth next year" : -0.3603, "Company" : "American Capital Agency Corp.", "Gap" : 0.0028, "Relative Volume" : 0.71, "Volatility (Month)" : 0.02, "Market Cap" : 8370.56, "Volume" : 4576064, "Gross Margin" : 0.746, "Short Ratio" : 1.69, "Performance (Half Year)" : -0.2136, "Relative Strength Index (14)" : 43.53, "Insider Ownership" : 0.003, "20-Day Simple Moving Average" : -0.0318, "Performance (Month)" : -0.042, "Institutional Transactions" : 0.0077, "Performance (Year)" : -0.1503, "LT Debt/Equity" : 0, "Average Volume" : 7072.83, "EPS growth this year" : -0.169, "50-Day Simple Moving Average" : -0.0376 }
            { "_id" : ObjectId("52853801bb1177ca391c1950"), "Ticker" : "ARCC", "Profit Margin" : 0.654, "Institutional Ownership" : 0.513, "EPS growth past 5 years" : 0.105, "Total Debt/Equity" : 0.59, "Return on Assets" : 0.08, "Sector" : "Financial", "P/S" : 5.87, "Change from Open" : 0.0105, "Performance (YTD)" : 0.0805, "Performance (Week)" : 0.0023, "P/B" : 1.08, "EPS growth quarter over quarter" : 0.22, "Payout Ratio" : 0.714, "Performance (Quarter)" : 0.0548, "Forward P/E" : 10.69, "P/E" : 8.32, "200-Day Simple Moving Average" : 0.046, "Shares Outstanding" : 266.17, "Earnings Date" : ISODate("2013-11-05T13:30:00Z"), "52-Week High" : -0.0014, "P/Cash" : 46.93, "Change" : 0.0082, "Analyst Recom" : 2, "Volatility (Week)" : 0.0129, "Country" : "USA", "Return on Equity" : 0.13, "50-Day Low" : 0.0527, "Price" : 17.86, "50-Day High" : -0.0014, "Return on Investment" : 0.056, "Shares Float" : 279.11, "Dividend Yield" : 0.0858, "EPS growth next 5 years" : 0.08, "Industry" : "Diversified Investments", "Beta" : 1.62, "Sales growth quarter over quarter" : 0.16, "Operating Margin" : 0.485, "EPS (ttm)" : 2.13, "PEG" : 1.04, "Float Short" : 0.0146, "52-Week Low" : 0.2192, "Average True Range" : 0.21, "EPS growth next year" : 0.0209, "Sales growth past 5 years" : 0.317, "Company" : "Ares Capital Corporation", "Gap" : -0.0023, "Relative Volume" : 0.68, "Volatility (Month)" : 0.0109, "Market Cap" : 4716.6, "Volume" : 938330, "Gross Margin" : 0.528, "Short Ratio" : 2.68, "Performance (Half Year)" : 0.0267, "Relative Strength Index (14)" : 61.2, "20-Day Simple Moving Average" : 0.0211, "Performance (Month)" : 0.0381, "Institutional Transactions" : 0.0183, "Performance (Year)" : 0.1574, "LT Debt/Equity" : 0, "Average Volume" : 1522.64, "EPS growth this year" : 0.417, "50-Day Simple Moving Average" : 0.0272 }
            { "_id" : ObjectId("52853801bb1177ca391c195a"), "Ticker" : "ARI", "Profit Margin" : 0.576, "Institutional Ownership" : 0.631, "EPS growth past 5 years" : 0.1829, "Total Debt/Equity" : 0.28, "Return on Assets" : 0.046, "Sector" : "Financial", "P/S" : 9.35, "Change from Open" : 0.0214, "Performance (YTD)" : 0.0803, "Performance (Week)" : -0.0055, "Insider Transactions" : -0.0353, "P/B" : 0.89, "EPS growth quarter over quarter" : -0.413, "Payout Ratio" : 1.159, "Performance (Quarter)" : 0.0861, "Forward P/E" : 9.57, "P/E" : 11.88, "200-Day Simple Moving Average" : 0.0497, "Shares Outstanding" : 37.37, "Earnings Date" : ISODate("2013-11-04T21:30:00Z"), "52-Week High" : -0.0404, "P/Cash" : 3.88, "Change" : 0.024, "Analyst Recom" : 2.1, "Volatility (Week)" : 0.0135, "Country" : "USA", "Return on Equity" : 0.064, "50-Day Low" : 0.1598, "Price" : 16.67, "50-Day High" : 0.0109, "Return on Investment" : 0.044, "Shares Float" : 36.7, "Dividend Yield" : 0.0983, "EPS growth next 5 years" : 0.025, "Industry" : "REIT - Diversified", "Beta" : 0.55, "Sales growth quarter over quarter" : 0.309, "Operating Margin" : 0.682, "EPS (ttm)" : 1.37, "PEG" : 4.75, "Float Short" : 0.0182, "52-Week Low" : 0.2179, "Average True Range" : 0.24, "EPS growth next year" : 0.1739, "Company" : "Apollo Commercial Real Estate Finance, Inc.", "Gap" : 0.0025, "Relative Volume" : 1.48, "Volatility (Month)" : 0.0152, "Market Cap" : 608.45, "Volume" : 299352, "Gross Margin" : 0.919, "Short Ratio" : 3.01, "Performance (Half Year)" : -0.0502, "Relative Strength Index (14)" : 68.71, "Insider Ownership" : 0.004, "20-Day Simple Moving Average" : 0.0331, "Performance (Month)" : 0.0376, "P/Free Cash Flow" : 126.76, "Institutional Transactions" : 0.0318, "Performance (Year)" : 0.1259, "LT Debt/Equity" : 0.28, "Average Volume" : 222.35, "EPS growth this year" : 0.193, "50-Day Simple Moving Average" : 0.0673 }
            { "_id" : ObjectId("52853801bb1177ca391c1968"), "Ticker" : "ARR", "Profit Margin" : 0.848, "Institutional Ownership" : 0.318, "EPS growth past 5 years" : 0.813, "Total Debt/Equity" : 8.92, "Return on Assets" : 0.031, "Sector" : "Financial", "P/S" : 1.7, "Change from Open" : 0.0223, "Performance (YTD)" : -0.2821, "Performance (Week)" : -0.0025, "Insider Transactions" : 0.2313, "P/B" : 0.68, "Payout Ratio" : 0.474, "Performance (Quarter)" : -0.0195, "Forward P/E" : 6.79, "P/E" : 1.88, "200-Day Simple Moving Average" : -0.1454, "Shares Outstanding" : 372.59, "Earnings Date" : ISODate("2013-10-28T04:00:00Z"), "52-Week High" : -0.3453, "P/Cash" : 1.87, "Change" : 0.0249, "Analyst Recom" : 2.6, "Volatility (Week)" : 0.024, "Country" : "USA", "Return on Equity" : 0.308, "50-Day Low" : 0.0728, "Price" : 4.12, "50-Day High" : -0.0678, "Return on Investment" : 0.011, "Shares Float" : 366.32, "Dividend Yield" : 0.1493, "EPS growth next 5 years" : -0.049, "Industry" : "REIT - Residential", "Beta" : 0.3, "Operating Margin" : 0.858, "EPS (ttm)" : 2.14, "Float Short" : 0.0415, "52-Week Low" : 0.1495, "Average True Range" : 0.09, "EPS growth next year" : -0.0878, "Company" : "ARMOUR Residential REIT, Inc.", "Gap" : 0.0025, "Relative Volume" : 1.37, "Volatility (Month)" : 0.0218, "Market Cap" : 1497.82, "Volume" : 6608855, "Short Ratio" : 2.87, "Performance (Half Year)" : -0.2651, "Relative Strength Index (14)" : 51.26, "Insider Ownership" : 0.002, "20-Day Simple Moving Average" : -0.0024, "Performance (Month)" : -0.0099, "P/Free Cash Flow" : 10.46, "Institutional Transactions" : 0.0016, "Performance (Year)" : -0.286, "LT Debt/Equity" : 0, "Average Volume" : 5299, "EPS growth this year" : 7.533, "50-Day Simple Moving Average" : 0.0048 }
            { "_id" : ObjectId("52853801bb1177ca391c1998"), "Ticker" : "ATHL", "Profit Margin" : 0.732, "Institutional Ownership" : 0.753, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 1.81, "Current Ratio" : 0.5, "Return on Assets" : 0.218, "Sector" : "Basic Materials", "P/S" : 10.42, "Change from Open" : 0.0088, "Performance (YTD)" : 0.1851, "Performance (Week)" : 0.1049, "Quick Ratio" : 0.5, "Insider Transactions" : -0.2682, "P/B" : 7.24, "EPS growth quarter over quarter" : -0.566, "Payout Ratio" : 0, "Performance (Quarter)" : 0.2007, "Forward P/E" : 27.38, "P/E" : 28.16, "200-Day Simple Moving Average" : 0.0877, "Shares Outstanding" : 66.34, "Earnings Date" : ISODate("2013-11-11T21:30:00Z"), "52-Week High" : -0.0439, "P/Cash" : 866.67, "Change" : 0.0126, "Analyst Recom" : 2.3, "Volatility (Week)" : 0.0678, "Country" : "USA", "Return on Equity" : 0.528, "50-Day Low" : 0.2479, "Price" : 33.07, "50-Day High" : -0.0439, "Return on Investment" : 0.08, "Shares Float" : 76.13, "EPS growth next 5 years" : 0.5, "Industry" : "Independent Oil & Gas", "Sales growth quarter over quarter" : 0.964, "Operating Margin" : 0.394, "EPS (ttm)" : 1.16, "PEG" : 0.56, "Float Short" : 0.0046, "52-Week Low" : 0.3097, "Average True Range" : 1.53, "EPS growth next year" : 0.6013, "Company" : "Athlon Energy Inc.", "Gap" : 0.0037, "Relative Volume" : 0.59, "Volatility (Month)" : 0.0464, "Market Cap" : 2166.66, "Volume" : 177265, "Gross Margin" : 0.791, "Short Ratio" : 1.07, "Relative Strength Index (14)" : 56.58, "Insider Ownership" : 0.09, "20-Day Simple Moving Average" : 0.0373, "Performance (Month)" : 0.0102, "LT Debt/Equity" : 1.81, "Average Volume" : 330.36, "EPS growth this year" : 0, "50-Day Simple Moving Average" : 0.0476 }
            { "_id" : ObjectId("52853801bb1177ca391c19f6"), "Ticker" : "AYR", "Profit Margin" : 0.548, "Institutional Ownership" : 0.745, "EPS growth past 5 years" : -0.228, "Total Debt/Equity" : 2.08, "Return on Assets" : 0.066, "Sector" : "Services", "P/S" : 1.92, "Change from Open" : 0.0058, "Performance (YTD)" : 0.5577, "Performance (Week)" : -0.0032, "Insider Transactions" : -0.0052, "P/B" : 0.83, "EPS growth quarter over quarter" : -0.656, "Payout Ratio" : 0.123, "Performance (Quarter)" : 0.1566, "Forward P/E" : 10.45, "P/E" : 126.07, "200-Day Simple Moving Average" : 0.2063, "Shares Outstanding" : 70.35, "Earnings Date" : ISODate("2013-10-31T12:30:00Z"), "52-Week High" : -0.0257, "P/Cash" : 5.58, "Change" : 0.0042, "Analyst Recom" : 2.6, "Volatility (Week)" : 0.0202, "Country" : "USA", "Return on Equity" : 0.257, "50-Day Low" : 0.1304, "Price" : 18.99, "50-Day High" : -0.0257, "Return on Investment" : 0.007, "Shares Float" : 64.67, "Dividend Yield" : 0.0349, "EPS growth next 5 years" : 0.292, "Industry" : "Rental & Leasing Services", "Beta" : 2.07, "Sales growth quarter over quarter" : -0.016, "Operating Margin" : 0.457, "EPS (ttm)" : 0.15, "PEG" : 4.32, "Float Short" : 0.0327, "52-Week Low" : 0.8106, "Average True Range" : 0.37, "EPS growth next year" : 0.4873, "Sales growth past 5 years" : 0.125, "Company" : "Aircastle LTD", "Gap" : -0.0016, "Relative Volume" : 0.39, "Volatility (Month)" : 0.0193, "Market Cap" : 1330.3, "Volume" : 200382, "Short Ratio" : 3.78, "Performance (Half Year)" : 0.2295, "Relative Strength Index (14)" : 58.67, "Insider Ownership" : 0.008, "20-Day Simple Moving Average" : 0.0054, "Performance (Month)" : 0.0849, "P/Free Cash Flow" : 3.39, "Institutional Transactions" : -0.0268, "Performance (Year)" : 0.7493, "LT Debt/Equity" : 2.08, "Average Volume" : 559.42, "EPS growth this year" : -0.72, "50-Day Simple Moving Average" : 0.0545 }
            { "_id" : ObjectId("52853801bb1177ca391c1a97"), "Ticker" : "BK", "Profit Margin" : 0.63, "Institutional Ownership" : 0.826, "EPS growth past 5 years" : -0.03, "Total Debt/Equity" : 0.53, "Return on Assets" : 0.006, "Sector" : "Financial", "P/S" : 11.32, "Change from Open" : -0.0015, "Performance (YTD)" : 0.3095, "Performance (Week)" : 0.0195, "Insider Transactions" : -0.1546, "P/B" : 1.07, "EPS growth quarter over quarter" : 0.344, "Payout Ratio" : 0.304, "Performance (Quarter)" : 0.0898, "Forward P/E" : 13.19, "P/E" : 18.03, "200-Day Simple Moving Average" : 0.127, "Shares Outstanding" : 1148.72, "Earnings Date" : ISODate("2013-10-16T12:30:00Z"), "52-Week High" : -0.0069, "P/Cash" : 0.22, "Change" : 0.003, "Analyst Recom" : 2.7, "Volatility (Week)" : 0.0216, "Country" : "USA", "Return on Equity" : 0.06, "50-Day Low" : 0.1255, "Price" : 33.1, "50-Day High" : -0.0069, "Return on Investment" : 0.042, "Shares Float" : 1146.23, "Dividend Yield" : 0.0182, "EPS growth next 5 years" : 0.066, "Industry" : "Asset Management", "Beta" : 1.16, "Sales growth quarter over quarter" : -0.025, "EPS (ttm)" : 1.83, "PEG" : 2.73, "Float Short" : 0.0125, "52-Week Low" : 0.4512, "Average True Range" : 0.54, "EPS growth next year" : 0.096, "Sales growth past 5 years" : -0.092, "Company" : "The Bank of New York Mellon Corporation", "Gap" : 0.0045, "Relative Volume" : 0.61, "Volatility (Month)" : 0.0155, "Market Cap" : 37907.89, "Volume" : 2578576, "Short Ratio" : 3.1, "Performance (Half Year)" : 0.1156, "Relative Strength Index (14)" : 63.27, "Insider Ownership" : 0.001, "20-Day Simple Moving Average" : 0.032, "Performance (Month)" : 0.0749, "Institutional Transactions" : 0.0015, "Performance (Year)" : 0.4019, "LT Debt/Equity" : 0.53, "Average Volume" : 4611.68, "EPS growth this year" : 0, "50-Day Simple Moving Average" : 0.0626 }
            { "_id" : ObjectId("52853801bb1177ca391c1abd"), "Ticker" : "BLX", "Profit Margin" : 0.588, "Institutional Ownership" : 0.281, "EPS growth past 5 years" : 0.045, "Total Debt/Equity" : 3.73, "Return on Assets" : 0.017, "Sector" : "Financial", "P/S" : 5.22, "Change from Open" : 0.0103, "Performance (YTD)" : 0.2812, "Performance (Week)" : -0.0131, "P/B" : 1.19, "EPS growth quarter over quarter" : -0.506, "Payout Ratio" : 0.372, "Performance (Quarter)" : 0.0597, "Forward P/E" : 9.32, "P/E" : 13.01, "200-Day Simple Moving Average" : 0.1134, "Shares Outstanding" : 38.22, "Earnings Date" : ISODate("2013-10-16T12:30:00Z"), "52-Week High" : -0.0161, "P/Cash" : 1.71, "Change" : 0.0095, "Analyst Recom" : 1.7, "Volatility (Week)" : 0.023, "Country" : "Panama", "Return on Equity" : 0.137, "50-Day Low" : 0.1075, "Price" : 26.54, "50-Day High" : -0.0161, "Return on Investment" : 0.027, "Shares Float" : 29.25, "Dividend Yield" : 0.0456, "EPS growth next 5 years" : 0.0698, "Industry" : "Foreign Money Center Banks", "Beta" : 1.19, "Sales growth quarter over quarter" : 0, "Operating Margin" : 0.809, "EPS (ttm)" : 2.02, "PEG" : 1.86, "Float Short" : 0.0296, "52-Week Low" : 0.366, "Average True Range" : 0.49, "EPS growth next year" : 0.2192, "Sales growth past 5 years" : -0.062, "Company" : "Banco Latinoamericano de Comercio Exterior, S.A", "Gap" : -0.0008, "Relative Volume" : 1.05, "Volatility (Month)" : 0.0205, "Market Cap" : 1004.75, "Volume" : 102478, "Short Ratio" : 8.07, "Performance (Half Year)" : 0.1597, "Relative Strength Index (14)" : 60.34, "Insider Ownership" : 0.0706, "20-Day Simple Moving Average" : 0.0098, "Performance (Month)" : 0.0554, "P/Free Cash Flow" : 56.77, "Institutional Transactions" : 0.0149, "Performance (Year)" : 0.2983, "LT Debt/Equity" : 1.91, "Average Volume" : 107.45, "EPS growth this year" : 0.098, "50-Day Simple Moving Average" : 0.0498 }
            { "_id" : ObjectId("52853801bb1177ca391c1af0"), "Ticker" : "BPO", "Profit Margin" : 0.503, "Institutional Ownership" : 0.958, "EPS growth past 5 years" : 0.354, "Total Debt/Equity" : 1.15, "Current Ratio" : 1, "Return on Assets" : 0.043, "Sector" : "Financial", "P/S" : 4.04, "Change from Open" : 0.001, "Performance (YTD)" : 0.1519, "Performance (Week)" : -0.0052, "Quick Ratio" : 1, "P/B" : 0.9, "EPS growth quarter over quarter" : -0.415, "Payout Ratio" : 0.235, "Performance (Quarter)" : 0.1825, "Forward P/E" : 18.74, "P/E" : 8.65, "200-Day Simple Moving Average" : 0.1124, "Shares Outstanding" : 505, "Earnings Date" : ISODate("2011-02-11T13:30:00Z"), "52-Week High" : -0.022, "P/Cash" : 22.13, "Change" : 0.0021, "Analyst Recom" : 3.1, "Volatility (Week)" : 0.0127, "Country" : "USA", "Return on Equity" : 0.115, "50-Day Low" : 0.1976, "Price" : 19.15, "50-Day High" : -0.022, "Return on Investment" : 0.015, "Shares Float" : 504.86, "Dividend Yield" : 0.0293, "EPS growth next 5 years" : 0.0735, "Industry" : "Property Management", "Beta" : 1.64, "Sales growth quarter over quarter" : 0.01, "Operating Margin" : 0.552, "EPS (ttm)" : 2.21, "PEG" : 1.18, "Float Short" : 0.0062, "52-Week Low" : 0.2728, "Average True Range" : 0.23, "EPS growth next year" : -0.105, "Sales growth past 5 years" : -0.043, "Company" : "Brookfield Properties Corporation", "Gap" : 0.001, "Relative Volume" : 0.17, "Volatility (Month)" : 0.0112, "Market Cap" : 9650.55, "Volume" : 249482, "Gross Margin" : 0.621, "Short Ratio" : 1.9, "Performance (Half Year)" : 0.0269, "Relative Strength Index (14)" : 62.08, "Insider Ownership" : 0.4972, "20-Day Simple Moving Average" : 0.012, "Performance (Month)" : 0.0154, "Institutional Transactions" : -0.004, "Performance (Year)" : 0.2482, "LT Debt/Equity" : 1.15, "Average Volume" : 1650.73, "EPS growth this year" : -0.212, "50-Day Simple Moving Average" : 0.0538 }

b) Liste as ações com perdas (limite a 10 novamente)
    Comando: db.getCollection("stock").find(
                { 
                    "Profit Margin" : { 
                        "$lt" : 0.0
                    }
                }
            ).limit(10);
    Output: { "_id" : ObjectId("52853800bb1177ca391c1806"), "Ticker" : "AAOI", "Profit Margin" : -0.023, "Institutional Ownership" : 0.114, "EPS growth past 5 years" : 0, "Current Ratio" : 1.5, "Return on Assets" : -0.048, "Sector" : "Technology", "P/S" : 2.3, "Change from Open" : -0.0215, "Performance (YTD)" : 0.2671, "Performance (Week)" : -0.0381, "Quick Ratio" : 0.9, "EPS growth quarter over quarter" : -1, "Forward P/E" : 12.77, "200-Day Simple Moving Average" : 0.0654, "Shares Outstanding" : 12.6, "52-Week High" : -0.0904, "P/Cash" : 16.23, "Change" : -0.0269, "Analyst Recom" : 1.8, "Volatility (Week)" : 0.0377, "Country" : "USA", "Return on Equity" : 0.043, "50-Day Low" : 0.3539, "Price" : 12.28, "50-Day High" : -0.0904, "Return on Investment" : -0.004, "Shares Float" : 11.46, "Industry" : "Semiconductor - Integrated Circuits", "Sales growth quarter over quarter" : 0.256, "Operating Margin" : -0.007, "EPS (ttm)" : -0.13, "Float Short" : 0.0011, "52-Week Low" : 0.3539, "Average True Range" : 0.63, "EPS growth next year" : 38.52, "Company" : "Applied Optoelectronics, Inc.", "Gap" : -0.0055, "Relative Volume" : 0.12, "Volatility (Month)" : 0.0608, "Market Cap" : 159.06, "Volume" : 12203, "Gross Margin" : 0.292, "Short Ratio" : 0.12, "Insider Ownership" : 0.021, "20-Day Simple Moving Average" : -0.0251, "Performance (Month)" : 0.2397, "Average Volume" : 110.95, "EPS growth this year" : 0.833, "50-Day Simple Moving Average" : 0.0654 }
            { "_id" : ObjectId("52853800bb1177ca391c180c"), "Ticker" : "AAV", "Profit Margin" : -0.232, "Institutional Ownership" : 0.58, "EPS growth past 5 years" : -0.265, "Total Debt/Equity" : 0.32, "Current Ratio" : 0.8, "Return on Assets" : -0.032, "Sector" : "Basic Materials", "P/S" : 2.64, "Change from Open" : 0.0286, "Performance (YTD)" : 0.1914, "Performance (Week)" : 0.0158, "Quick Ratio" : 0.8, "P/B" : 0.63, "EPS growth quarter over quarter" : 1.556, "Performance (Quarter)" : 0.0349, "200-Day Simple Moving Average" : 0.0569, "Shares Outstanding" : 168.38, "Earnings Date" : ISODate("2011-03-16T04:00:00Z"), "52-Week High" : -0.1242, "Change" : 0.0233, "Analyst Recom" : 2.7, "Volatility (Week)" : 0.0381, "Country" : "Canada", "Return on Equity" : -0.055, "50-Day Low" : 0.1127, "Price" : 3.95, "50-Day High" : -0.0436, "Return on Investment" : -0.068, "Shares Float" : 167.07, "Industry" : "Oil & Gas Drilling & Exploration", "Beta" : 2.05, "Sales growth quarter over quarter" : 0.399, "Operating Margin" : 0.102, "EPS (ttm)" : -0.34, "Float Short" : 0.0008, "52-Week Low" : 0.4158, "Average True Range" : 0.12, "EPS growth next year" : -0.667, "Sales growth past 5 years" : -0.121, "Company" : "Advantage Oil & Gas Ltd.", "Gap" : -0.0052, "Relative Volume" : 0.85, "Volatility (Month)" : 0.0303, "Market Cap" : 649.96, "Volume" : 116750, "Gross Margin" : 0.682, "Short Ratio" : 0.89, "Performance (Half Year)" : 0.0078, "Relative Strength Index (14)" : 52.62, "Insider Ownership" : 0.0025, "20-Day Simple Moving Average" : -0.0001, "Performance (Month)" : 0.0158, "Institutional Transactions" : 0.0402, "Performance (Year)" : 0.1386, "LT Debt/Equity" : 0.32, "Average Volume" : 149.81, "EPS growth this year" : 0.42, "50-Day Simple Moving Average" : 0.023 }
            { "_id" : ObjectId("52853800bb1177ca391c1815"), "Ticker" : "ABCD", "Profit Margin" : -0.645, "Institutional Ownership" : 0.186, "EPS growth past 5 years" : -0.195, "Current Ratio" : 1.4, "Return on Assets" : -0.416, "Sector" : "Services", "P/S" : 0.41, "Change from Open" : 0, "Performance (YTD)" : 0.2072, "Performance (Week)" : 0.0229, "Quick Ratio" : 1.2, "Insider Transactions" : -0.0267, "EPS growth quarter over quarter" : 1.022, "Performance (Quarter)" : -0.0496, "200-Day Simple Moving Average" : 0.0446, "Shares Outstanding" : 47.36, "Earnings Date" : ISODate("2013-11-07T21:30:00Z"), "52-Week High" : -0.2757, "P/Cash" : 1.37, "Change" : 0, "Analyst Recom" : 2, "Volatility (Week)" : 0.0737, "Country" : "USA", "Return on Equity" : 3.596, "50-Day Low" : 0.072, "Price" : 1.34, "50-Day High" : -0.2299, "Return on Investment" : -0.876, "Shares Float" : 15.11, "Industry" : "Education & Training Services", "Beta" : 1.7, "Sales growth quarter over quarter" : 0.059, "Operating Margin" : 0.048, "EPS (ttm)" : -2.06, "Float Short" : 0.0007, "52-Week Low" : 0.5952, "Average True Range" : 0.09, "Sales growth past 5 years" : 0.084, "Company" : "Cambium Learning Group, Inc.", "Gap" : 0, "Relative Volume" : 0.04, "Volatility (Month)" : 0.0584, "Market Cap" : 63.46, "Volume" : 1600, "Gross Margin" : 0.552, "Short Ratio" : 0.21, "Performance (Half Year)" : 0.1356, "Relative Strength Index (14)" : 48.07, "Insider Ownership" : 0.003, "20-Day Simple Moving Average" : 0.0037, "Performance (Month)" : -0.0074, "P/Free Cash Flow" : 2.47, "Institutional Transactions" : -0.095, "Performance (Year)" : 0.6543, "Average Volume" : 48.58, "EPS growth this year" : -1.533, "50-Day Simple Moving Average" : -0.064 }
            { "_id" : ObjectId("52853800bb1177ca391c1817"), "Ticker" : "ABFS", "Profit Margin" : -0.005, "Institutional Ownership" : 0.921, "EPS growth past 5 years" : -0.164, "Total Debt/Equity" : 0.31, "Current Ratio" : 1.3, "Return on Assets" : -0.01, "Sector" : "Services", "P/S" : 0.37, "Change from Open" : -0.006, "Performance (YTD)" : 2.3474, "Performance (Week)" : 0.1949, "Quick Ratio" : 1.3, "Insider Transactions" : 0.1293, "P/B" : 1.69, "EPS growth quarter over quarter" : -0.591, "Performance (Quarter)" : 0.3813, "Forward P/E" : 18.66, "200-Day Simple Moving Average" : 0.6449, "Shares Outstanding" : 25.69, "Earnings Date" : ISODate("2013-11-11T13:30:00Z"), "52-Week High" : -0.0166, "P/Cash" : 6.87, "Change" : -0.0082, "Analyst Recom" : 2.8, "Volatility (Week)" : 0.0625, "Country" : "USA", "Return on Equity" : -0.022, "50-Day Low" : 0.474, "Price" : 31.44, "50-Day High" : -0.0166, "Return on Investment" : -0.008, "Shares Float" : 24.3, "Dividend Yield" : 0.0038, "EPS growth next 5 years" : 0.1, "Industry" : "Trucking", "Beta" : 1.91, "Sales growth quarter over quarter" : 0.13, "Operating Margin" : -0.006, "EPS (ttm)" : -0.4, "Float Short" : 0.1176, "52-Week Low" : 3.9271, "Average True Range" : 1.58, "EPS growth next year" : 7.0142, "Sales growth past 5 years" : 0.024, "Company" : "Arkansas Best Corporation", "Gap" : -0.0022, "Relative Volume" : 0.73, "Volatility (Month)" : 0.0537, "Market Cap" : 814.5, "Volume" : 351906, "Gross Margin" : 0.212, "Short Ratio" : 5.44, "Performance (Half Year)" : 0.8592, "Relative Strength Index (14)" : 67.77, "Insider Ownership" : 0.034, "20-Day Simple Moving Average" : 0.1304, "Performance (Month)" : 0.3319, "P/Free Cash Flow" : 13.67, "Institutional Transactions" : 0.0328, "Performance (Year)" : 3.4336, "LT Debt/Equity" : 0.2, "Average Volume" : 525.42, "EPS growth this year" : -2.348, "50-Day Simple Moving Average" : 0.1974 }
            { "_id" : ObjectId("52853800bb1177ca391c181b"), "Ticker" : "ABMC", "Profit Margin" : -0.0966, "Institutional Ownership" : 0.12, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 0.63, "Current Ratio" : 1.74, "Return on Assets" : -0.1194, "Sector" : "Healthcare", "P/S" : 0.34, "Change from Open" : 0, "Performance (YTD)" : 0.3077, "Performance (Week)" : 0.1333, "Quick Ratio" : 0.57, "P/B" : 1, "EPS growth quarter over quarter" : -2.4252, "Performance (Quarter)" : 0, "200-Day Simple Moving Average" : 0.0413, "Shares Outstanding" : 21.74, "Earnings Date" : ISODate("2013-11-11T05:00:00Z"), "52-Week High" : -0.3929, "P/Cash" : 6.26, "Change" : 0, "Volatility (Week)" : 0.0695, "Country" : "USA", "Return on Equity" : -0.2455, "50-Day Low" : 1.4286, "Price" : 0.17, "50-Day High" : -0.0556, "Return on Investment" : -0.1961, "Shares Float" : 18.7, "Industry" : "Diagnostic Substances", "Beta" : 1.71, "Sales growth quarter over quarter" : -0.1896, "Operating Margin" : -0.0734, "EPS (ttm)" : -0.05, "Float Short" : 0.0003, "52-Week Low" : 1.4286, "Average True Range" : 0.02, "Sales growth past 5 years" : 0.0028, "Company" : "American Bio Medica Corp.", "Gap" : 0, "Relative Volume" : 0.04, "Volatility (Month)" : 0.0517, "Market Cap" : 3.7, "Volume" : 0, "Gross Margin" : 0.3916, "Short Ratio" : 0.43, "Performance (Half Year)" : 0.0625, "Relative Strength Index (14)" : 56.93, "Insider Ownership" : 0.14, "20-Day Simple Moving Average" : 0.1039, "Performance (Month)" : 0.2143, "Institutional Transactions" : -0.1183, "Performance (Year)" : -0.0556, "LT Debt/Equity" : 0.2, "Average Volume" : 13.73, "EPS growth this year" : 0.1416, "50-Day Simple Moving Average" : 0.1502 }
            { "_id" : ObjectId("52853800bb1177ca391c1821"), "Ticker" : "ABX", "Profit Margin" : -0.769, "Institutional Ownership" : 0.739, "EPS growth past 5 years" : -0.206, "Total Debt/Equity" : 1.13, "Current Ratio" : 1.8, "Return on Assets" : -0.241, "Sector" : "Basic Materials", "P/S" : 1.32, "Change from Open" : -0.0019, "Performance (YTD)" : -0.4728, "Performance (Week)" : -0.0131, "Quick Ratio" : 1, "P/B" : 1.33, "EPS growth quarter over quarter" : -0.727, "Performance (Quarter)" : -0.084, "Forward P/E" : 8.19, "200-Day Simple Moving Average" : -0.1368, "Shares Outstanding" : 1001, "Earnings Date" : ISODate("2011-02-17T13:30:00Z"), "52-Week High" : -0.4877, "P/Cash" : 7.94, "Change" : 0.0014, "Analyst Recom" : 2.6, "Volatility (Week)" : 0.0202, "Country" : "Canada", "Return on Equity" : -0.592, "50-Day Low" : 0.0581, "Price" : 18.13, "50-Day High" : -0.121, "Return on Investment" : -0.017, "Shares Float" : 997.93, "Dividend Yield" : 0.011, "EPS growth next 5 years" : 0.02, "Industry" : "Gold", "Beta" : 0.46, "Sales growth quarter over quarter" : -0.122, "Operating Margin" : 0.366, "EPS (ttm)" : -10.08, "Float Short" : 0.0118, "52-Week Low" : 0.3525, "Average True Range" : 0.57, "EPS growth next year" : -0.16, "Sales growth past 5 years" : 0.193, "Company" : "Barrick Gold Corporation", "Gap" : 0.0033, "Relative Volume" : 1.09, "Volatility (Month)" : 0.0277, "Market Cap" : 18118.1, "Volume" : 17478164, "Gross Margin" : 0.444, "Short Ratio" : 0.67, "Performance (Half Year)" : -0.0479, "Relative Strength Index (14)" : 41.96, "20-Day Simple Moving Average" : -0.0436, "Performance (Month)" : 0.018, "Institutional Transactions" : 0.0315, "Performance (Year)" : -0.474, "LT Debt/Equity" : 1.07, "Average Volume" : 17602.98, "EPS growth this year" : -1.147, "50-Day Simple Moving Average" : -0.0239 }
            { "_id" : ObjectId("52853800bb1177ca391c1826"), "Ticker" : "ACCL", "Profit Margin" : -0.014, "Institutional Ownership" : 0.911, "EPS growth past 5 years" : -0.421, "Total Debt/Equity" : 0, "Current Ratio" : 1.4, "Return on Assets" : -0.006, "Sector" : "Technology", "P/S" : 3.13, "Change from Open" : 0.0011, "Performance (YTD)" : 0.0331, "Performance (Week)" : 0.0108, "Quick Ratio" : 1.4, "Insider Transactions" : -0.1768, "P/B" : 2.1, "Performance (Quarter)" : 0.0331, "Forward P/E" : 24.35, "200-Day Simple Moving Average" : 0.0112, "Shares Outstanding" : 55.66, "Earnings Date" : ISODate("2013-10-30T20:30:00Z"), "52-Week High" : -0.071, "P/Cash" : 4.14, "Change" : -0.0064, "Analyst Recom" : 2.3, "Volatility (Week)" : 0.0189, "Country" : "USA", "Return on Equity" : -0.01, "50-Day Low" : 0.0322, "Price" : 9.29, "50-Day High" : -0.071, "Return on Investment" : -0.086, "Shares Float" : 55.4, "EPS growth next 5 years" : 0.2, "Industry" : "Application Software", "Beta" : 0.84, "Sales growth quarter over quarter" : 0.01, "Operating Margin" : -0.091, "EPS (ttm)" : -0.05, "Float Short" : 0.0179, "52-Week Low" : 0.1987, "Average True Range" : 0.21, "EPS growth next year" : 0.1294, "Sales growth past 5 years" : 0.153, "Company" : "Accelrys Inc.", "Gap" : -0.0075, "Relative Volume" : 0.31, "Volatility (Month)" : 0.0236, "Market Cap" : 520.42, "Volume" : 33912, "Gross Margin" : 0.679, "Short Ratio" : 8.32, "Performance (Half Year)" : 0.0872, "Relative Strength Index (14)" : 45.52, "Insider Ownership" : 0.0092, "20-Day Simple Moving Average" : -0.018, "Performance (Month)" : -0.0032, "Institutional Transactions" : 0.0133, "Performance (Year)" : 0.0747, "LT Debt/Equity" : 0, "Average Volume" : 118.95, "EPS growth this year" : -7.333, "50-Day Simple Moving Average" : -0.0226 }
            { "_id" : ObjectId("52853800bb1177ca391c182b"), "Ticker" : "ACFC", "Profit Margin" : -0.18, "Institutional Ownership" : 0.079, "EPS growth past 5 years" : -0.524, "Total Debt/Equity" : 0, "Return on Assets" : -0.007, "Sector" : "Financial", "P/S" : 0.27, "Change from Open" : 0, "Performance (YTD)" : 0.6667, "Performance (Week)" : -0.1184, "P/B" : 0.27, "EPS growth quarter over quarter" : 0.483, "Performance (Quarter)" : -0.1321, "200-Day Simple Moving Average" : -0.2118, "Shares Outstanding" : 2.5, "Earnings Date" : ISODate("2013-11-04T05:00:00Z"), "52-Week High" : -0.4956, "P/Cash" : 0.1, "Change" : 0.0358, "Analyst Recom" : 3, "Volatility (Week)" : 0.0508, "Country" : "USA", "Return on Equity" : -0.147, "50-Day Low" : 0.081, "Price" : 3.47, "50-Day High" : -0.2078, "Return on Investment" : 0.161, "Shares Float" : 1.72, "Industry" : "Regional - Southeast Banks", "Beta" : 0.83, "Sales growth quarter over quarter" : -0.14, "Operating Margin" : -0.18, "EPS (ttm)" : -2.22, "Float Short" : 0.0085, "52-Week Low" : 1.3767, "Average True Range" : 0.12, "Sales growth past 5 years" : -0.096, "Company" : "Atlantic Coast Financial Corporation", "Gap" : 0.0358, "Relative Volume" : 0, "Volatility (Month)" : 0.0228, "Market Cap" : 8.39, "Volume" : 0, "Short Ratio" : 6.07, "Performance (Half Year)" : -0.3667, "Relative Strength Index (14)" : 40.71, "Insider Ownership" : 0.001, "20-Day Simple Moving Average" : -0.0742, "Performance (Month)" : -0.1138, "Institutional Transactions" : -4.3825, "Performance (Year)" : 0.7539, "LT Debt/Equity" : 0, "Average Volume" : 2.41, "EPS growth this year" : 0.354, "50-Day Simple Moving Average" : -0.0993 }
            { "_id" : ObjectId("52853800bb1177ca391c182f"), "Ticker" : "ACH", "Profit Margin" : -0.051, "Institutional Ownership" : 0.02, "EPS growth past 5 years" : -0.227, "Total Debt/Equity" : 2.84, "Current Ratio" : 0.7, "Return on Assets" : -0.039, "Sector" : "Basic Materials", "P/S" : 0.19, "Change from Open" : -0.0032, "Performance (YTD)" : -0.2645, "Performance (Week)" : -0.0437, "Quick Ratio" : 0.7, "P/B" : 0.67, "EPS growth quarter over quarter" : 0.711, "Performance (Quarter)" : 0.0057, "200-Day Simple Moving Average" : -0.0544, "Shares Outstanding" : 540.98, "Earnings Date" : ISODate("2011-03-02T05:00:00Z"), "52-Week High" : -0.3369, "P/Cash" : 2.77, "Change" : 0.0059, "Analyst Recom" : 5, "Volatility (Week)" : 0.015, "Country" : "China", "Return on Equity" : -0.172, "50-Day Low" : 0.0176, "Price" : 8.81, "50-Day High" : -0.1117, "Return on Investment" : -0.029, "Shares Float" : 156.18, "Industry" : "Aluminum", "Beta" : 1.9, "Sales growth quarter over quarter" : 0.065, "Operating Margin" : -0.021, "EPS (ttm)" : -1.76, "Float Short" : 0.02, "52-Week Low" : 0.2154, "Average True Range" : 0.2, "EPS growth next year" : 0.487, "Sales growth past 5 years" : 0.119, "Company" : "Aluminum Corporation Of China Limited", "Gap" : 0.0091, "Relative Volume" : 1.05, "Volatility (Month)" : 0.0183, "Market Cap" : 4738.98, "Volume" : 78010, "Gross Margin" : 0.005, "Short Ratio" : 38.23, "Performance (Half Year)" : -0.124, "Relative Strength Index (14)" : 38.92, "20-Day Simple Moving Average" : -0.0477, "Performance (Month)" : -0.0405, "Institutional Transactions" : -0.0063, "Performance (Year)" : -0.1577, "LT Debt/Equity" : 1.19, "Average Volume" : 81.57, "EPS growth this year" : 0.839, "50-Day Simple Moving Average" : -0.0421 }
            { "_id" : ObjectId("52853800bb1177ca391c1832"), "Ticker" : "ACI", "Profit Margin" : -0.173, "Institutional Ownership" : 0.662, "EPS growth past 5 years" : -0.361, "Total Debt/Equity" : 1.97, "Current Ratio" : 3.5, "Return on Assets" : -0.058, "Sector" : "Basic Materials", "P/S" : 0.28, "Change from Open" : -0.0372, "Performance (YTD)" : -0.4019, "Performance (Week)" : -0.0183, "Quick Ratio" : 3, "Insider Transactions" : 0.0178, "P/B" : 0.35, "EPS growth quarter over quarter" : -5.455, "Performance (Quarter)" : -0.0549, "200-Day Simple Moving Average" : -0.1177, "Shares Outstanding" : 212.11, "Earnings Date" : ISODate("2013-10-29T12:30:00Z"), "52-Week High" : -0.4702, "P/Cash" : 0.66, "Change" : -0.0372, "Analyst Recom" : 2.8, "Volatility (Week)" : 0.0516, "Country" : "USA", "Return on Equity" : -0.207, "50-Day Low" : 0.104, "Price" : 4.14, "50-Day High" : -0.2114, "Return on Investment" : -0.047, "Shares Float" : 209.56, "Dividend Yield" : 0.0279, "EPS growth next 5 years" : 0.05, "Industry" : "Industrial Metals & Minerals", "Beta" : 1.61, "Sales growth quarter over quarter" : -0.272, "Operating Margin" : -0.04, "EPS (ttm)" : -3.16, "Float Short" : 0.1772, "52-Week Low" : 0.1997, "Average True Range" : 0.23, "EPS growth next year" : 0.143, "Sales growth past 5 years" : 0.115, "Company" : "Arch Coal Inc.", "Gap" : 0, "Relative Volume" : 0.66, "Volatility (Month)" : 0.0546, "Market Cap" : 912.08, "Volume" : 5417562, "Gross Margin" : 0.141, "Short Ratio" : 4.12, "Performance (Half Year)" : -0.1224, "Relative Strength Index (14)" : 43.64, "Insider Ownership" : 0.0054, "20-Day Simple Moving Average" : -0.0171, "Performance (Month)" : 0.0437, "Institutional Transactions" : 0.0024, "Performance (Year)" : -0.3741, "LT Debt/Equity" : 1.97, "Average Volume" : 9000.5, "EPS growth this year" : -5.378, "50-Day Simple Moving Average" : -0.0482 }

c) Liste as 10 ações mais rentáveis
    Comando: db.getCollection("stock").find({}).sort(
                { 
                    "Profit Margin" : -1
                }
            ).limit(10);
    Output: { "_id" : ObjectId("52853801bb1177ca391c1af3"), "Ticker" : "BPT", "Profit Margin" : 0.994, "Institutional Ownership" : 0.098, "EPS growth past 5 years" : 0.025, "Total Debt/Equity" : 0, "Sector" : "Basic Materials", "P/S" : 8.81, "Change from Open" : 0.0125, "Performance (YTD)" : 0.2758, "Performance (Week)" : -0.018, "P/B" : 2620, "EPS growth quarter over quarter" : -0.087, "Payout Ratio" : 1.001, "Performance (Quarter)" : -0.0556, "P/E" : 8.87, "200-Day Simple Moving Average" : -0.0305, "Shares Outstanding" : 21.4, "Earnings Date" : ISODate("2013-11-11T05:00:00Z"), "52-Week High" : -0.159, "P/Cash" : 1682.04, "Change" : 0.0064, "Volatility (Week)" : 0.0151, "Country" : "USA", "50-Day Low" : 0.0136, "Price" : 79.1, "50-Day High" : -0.0973, "Shares Float" : 21.4, "Dividend Yield" : 0.1103, "Industry" : "Oil & Gas Refining & Marketing", "Beta" : 0.77, "Sales growth quarter over quarter" : -0.086, "Operating Margin" : 0.994, "EPS (ttm)" : 8.86, "Float Short" : 0.0173, "52-Week Low" : 0.3422, "Average True Range" : 1.37, "Sales growth past 5 years" : 0.024, "Company" : "BP Prudhoe Bay Royalty Trust", "Gap" : -0.0061, "Relative Volume" : 0.93, "Volatility (Month)" : 0.016, "Market Cap" : 1682.04, "Volume" : 71575, "Short Ratio" : 4.41, "Performance (Half Year)" : 0.0022, "Relative Strength Index (14)" : 38.01, "20-Day Simple Moving Average" : -0.0318, "Performance (Month)" : -0.079, "Institutional Transactions" : -0.0057, "Performance (Year)" : 0.1837, "LT Debt/Equity" : 0, "Average Volume" : 84.15, "EPS growth this year" : -0.012, "50-Day Simple Moving Average" : -0.0496 }
            { "_id" : ObjectId("52853802bb1177ca391c1b69"), "Ticker" : "CACB", "Profit Margin" : 0.994, "Institutional Ownership" : 0.547, "EPS growth past 5 years" : -0.584, "Total Debt/Equity" : 0, "Return on Assets" : 0.039, "Sector" : "Financial", "P/S" : 4.66, "Change from Open" : -0.0137, "Performance (YTD)" : -0.1869, "Performance (Week)" : 0.0079, "Insider Transactions" : 1.0755, "P/B" : 1.28, "EPS growth quarter over quarter" : 25.422, "Payout Ratio" : 0, "Performance (Quarter)" : -0.1314, "Forward P/E" : 42.42, "P/E" : 4.71, "200-Day Simple Moving Average" : -0.1709, "Shares Outstanding" : 47.17, "Earnings Date" : ISODate("2013-11-13T21:30:00Z"), "52-Week High" : -0.2994, "P/Cash" : 2.26, "Change" : -0.0118, "Analyst Recom" : 3, "Volatility (Week)" : 0.0353, "Country" : "USA", "Return on Equity" : 0.336, "50-Day Low" : 0.006, "Price" : 5.03, "50-Day High" : -0.2066, "Return on Investment" : 0.346, "Shares Float" : 40.67, "EPS growth next 5 years" : 0.05, "Industry" : "Regional - Pacific Banks", "Beta" : 2.34, "Sales growth quarter over quarter" : -0.101, "Operating Margin" : 0.027, "EPS (ttm)" : 1.08, "PEG" : 0.94, "Float Short" : 0.0088, "52-Week Low" : 0.0817, "Average True Range" : 0.19, "EPS growth next year" : -0.8904, "Sales growth past 5 years" : -0.203, "Company" : "Cascade Bancorp", "Gap" : 0.002, "Relative Volume" : 1.35, "Volatility (Month)" : 0.0399, "Market Cap" : 240.11, "Volume" : 21432, "Short Ratio" : 20.55, "Performance (Half Year)" : -0.1239, "Relative Strength Index (14)" : 29.61, "Insider Ownership" : 0.009, "20-Day Simple Moving Average" : -0.0729, "Performance (Month)" : -0.1039, "Institutional Transactions" : 0.0004, "Performance (Year)" : 0.0241, "LT Debt/Equity" : 0, "Average Volume" : 17.39, "EPS growth this year" : 1.12, "50-Day Simple Moving Average" : -0.116 }
            { "_id" : ObjectId("5285380bbb1177ca391c2c3c"), "Ticker" : "ROYT", "Profit Margin" : 0.99, "Institutional Ownership" : 0.696, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 0, "Return on Assets" : 0.255, "Sector" : "Basic Materials", "P/S" : 7.62, "Change from Open" : 0, "Performance (YTD)" : -0.1408, "Performance (Week)" : -0.0447, "Insider Transactions" : -0.5437, "P/B" : 2.03, "EPS growth quarter over quarter" : 1.75, "Payout Ratio" : 0.338, "Performance (Quarter)" : -0.2202, "Forward P/E" : 7.92, "P/E" : 7.68, "200-Day Simple Moving Average" : -0.1864, "Shares Outstanding" : 38.58, "52-Week High" : -0.243, "Change" : 0.0037, "Analyst Recom" : 2.4, "Volatility (Week)" : 0.0174, "Country" : "USA", "Return on Equity" : 0.255, "50-Day Low" : 0.0088, "Price" : 13.72, "50-Day High" : -0.243, "Return on Investment" : 0.15, "Shares Float" : 38.58, "Dividend Yield" : 0.1295, "EPS growth next 5 years" : 0.126, "Industry" : "Independent Oil & Gas", "Sales growth quarter over quarter" : 1.6, "Operating Margin" : 0.99, "EPS (ttm)" : 1.78, "PEG" : 0.61, "Float Short" : 0.0042, "52-Week Low" : 0.0088, "Average True Range" : 0.3, "EPS growth next year" : -0.0655, "Company" : "Pacific Coast Oil Trust", "Gap" : 0.0037, "Relative Volume" : 0.75, "Volatility (Month)" : 0.0201, "Market Cap" : 527.43, "Volume" : 262050, "Short Ratio" : 0.42, "Performance (Half Year)" : -0.1978, "Relative Strength Index (14)" : 20.73, "Insider Ownership" : 0.5205, "20-Day Simple Moving Average" : -0.0644, "Performance (Month)" : -0.1237, "Institutional Transactions" : 0.0154, "Performance (Year)" : -0.1141, "LT Debt/Equity" : 0, "Average Volume" : 388.63, "EPS growth this year" : 0.745, "50-Day Simple Moving Average" : -0.1265 }
            { "_id" : ObjectId("52853808bb1177ca391c281b"), "Ticker" : "NDRO", "Profit Margin" : 0.986, "Institutional Ownership" : 0.532, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 0, "Return on Assets" : 0.078, "Sector" : "Basic Materials", "P/S" : 8.11, "Change from Open" : 0, "Performance (YTD)" : -0.2111, "Performance (Week)" : -0.0369, "Insider Transactions" : -0.3613, "P/B" : 0.67, "EPS growth quarter over quarter" : -0.378, "Payout Ratio" : 0.313, "Performance (Quarter)" : -0.1716, "Forward P/E" : 7.53, "P/E" : 8.23, "200-Day Simple Moving Average" : -0.1708, "Shares Outstanding" : 33, "Earnings Date" : ISODate("2013-11-11T05:00:00Z"), "52-Week High" : -0.2732, "Change" : -0.0073, "Analyst Recom" : 2.3, "Volatility (Week)" : 0.0224, "Country" : "USA", "Return on Equity" : 0.078, "50-Day Low" : 0.0437, "Price" : 12.17, "50-Day High" : -0.2028, "Return on Investment" : 0.091, "Shares Float" : 33, "Dividend Yield" : 0.1476, "EPS growth next 5 years" : -0.061, "Industry" : "Independent Oil & Gas", "Sales growth quarter over quarter" : -0.388, "Operating Margin" : 0.986, "EPS (ttm)" : 1.49, "Float Short" : 0.0011, "52-Week Low" : 0.0437, "Average True Range" : 0.26, "EPS growth next year" : 0.1097, "Company" : "Enduro Royalty Trust", "Gap" : -0.0073, "Relative Volume" : 1.43, "Volatility (Month)" : 0.0205, "Market Cap" : 404.58, "Volume" : 406061, "Short Ratio" : 0.12, "Performance (Half Year)" : -0.2106, "Relative Strength Index (14)" : 33.3, "Insider Ownership" : 0.6, "20-Day Simple Moving Average" : -0.0471, "Performance (Month)" : 0.0381, "Institutional Transactions" : 0.1111, "Performance (Year)" : -0.1987, "LT Debt/Equity" : 0, "Average Volume" : 311.39, "EPS growth this year" : 4.677, "50-Day Simple Moving Average" : -0.0824 }
            { "_id" : ObjectId("5285380fbb1177ca391c318e"), "Ticker" : "WHZ", "Profit Margin" : 0.982, "Institutional Ownership" : 0.199, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 0, "Return on Assets" : 0.321, "Sector" : "Basic Materials", "P/S" : 4.79, "Change from Open" : -0.0042, "Performance (YTD)" : 0.0782, "Performance (Week)" : 0.0369, "P/B" : 1.67, "EPS growth quarter over quarter" : -0.337, "Payout Ratio" : 1.003, "Performance (Quarter)" : 0.0955, "P/E" : 4.88, "200-Day Simple Moving Average" : 0.0993, "Shares Outstanding" : 18.4, "52-Week High" : -0.0668, "P/Cash" : 1319.28, "Change" : -0.0042, "Analyst Recom" : 3, "Volatility (Week)" : 0.0183, "Country" : "USA", "Return on Equity" : 0.321, "50-Day Low" : 0.12, "Price" : 14.28, "50-Day High" : -0.0138, "Return on Investment" : 0.28, "Shares Float" : 18.4, "Dividend Yield" : 0.2064, "Industry" : "Independent Oil & Gas", "Sales growth quarter over quarter" : -0.343, "Operating Margin" : 0.982, "EPS (ttm)" : 2.94, "Float Short" : 0.004, "52-Week Low" : 0.2081, "Average True Range" : 0.26, "Company" : "Whiting USA Trust II", "Gap" : 0, "Relative Volume" : 2.18, "Volatility (Month)" : 0.0194, "Market Cap" : 263.86, "Volume" : 244298, "Short Ratio" : 0.6, "Performance (Half Year)" : 0.1282, "Relative Strength Index (14)" : 68.85, "20-Day Simple Moving Average" : 0.0301, "Performance (Month)" : 0.0864, "Institutional Transactions" : 0.0834, "Performance (Year)" : -0.0311, "LT Debt/Equity" : 0, "Average Volume" : 123.73, "50-Day Simple Moving Average" : 0.0734 }
            { "_id" : ObjectId("52853808bb1177ca391c27bd"), "Ticker" : "MVO", "Profit Margin" : 0.976, "Institutional Ownership" : 0.048, "EPS growth past 5 years" : 0.044, "Total Debt/Equity" : 0, "Return on Assets" : 1.258, "Sector" : "Basic Materials", "P/S" : 8.25, "Change from Open" : 0.0176, "Performance (YTD)" : 0.2883, "Performance (Week)" : -0.0007, "P/B" : 11.04, "EPS growth quarter over quarter" : -0.147, "Payout Ratio" : 1, "Performance (Quarter)" : 0.0678, "P/E" : 8.43, "200-Day Simple Moving Average" : 0.0422, "Shares Outstanding" : 11.5, "Earnings Date" : ISODate("2013-11-11T05:00:00Z"), "52-Week High" : -0.0998, "Change" : 0.0131, "Analyst Recom" : 4, "Volatility (Week)" : 0.0108, "Country" : "USA", "Return on Equity" : 1.258, "50-Day Low" : 0.0765, "Price" : 27.75, "50-Day High" : -0.0611, "Return on Investment" : 1.355, "Shares Float" : 8.63, "Dividend Yield" : 0.1431, "EPS growth next 5 years" : 0.07, "Industry" : "Oil & Gas Drilling & Exploration", "Beta" : 0.45, "Sales growth quarter over quarter" : -0.143, "Operating Margin" : 0.979, "EPS (ttm)" : 3.25, "PEG" : 1.2, "Float Short" : 0.0123, "52-Week Low" : 0.3994, "Average True Range" : 0.54, "Sales growth past 5 years" : 0.043, "Company" : "MV Oil Trust", "Gap" : -0.0044, "Relative Volume" : 0.36, "Volatility (Month)" : 0.0202, "Market Cap" : 314.98, "Volume" : 14403, "Short Ratio" : 2.44, "Performance (Half Year)" : 0.0367, "Relative Strength Index (14)" : 55.11, "Insider Ownership" : 0.25, "20-Day Simple Moving Average" : 0.0181, "Performance (Month)" : 0.0092, "Institutional Transactions" : -0.0054, "Performance (Year)" : 0.2008, "LT Debt/Equity" : 0, "Average Volume" : 43.54, "EPS growth this year" : 0.029, "50-Day Simple Moving Average" : 0.0058 }
            { "_id" : ObjectId("52853801bb1177ca391c1895"), "Ticker" : "AGNC", "Profit Margin" : 0.972, "Institutional Ownership" : 0.481, "EPS growth past 5 years" : -0.0107, "Total Debt/Equity" : 8.56, "Return on Assets" : 0.022, "Sector" : "Financial", "P/S" : 3.77, "Change from Open" : 0.0102, "Performance (YTD)" : -0.1652, "Performance (Week)" : -0.017, "Insider Transactions" : 0.4931, "P/B" : 0.86, "EPS growth quarter over quarter" : -8.2, "Payout Ratio" : 0.79, "Performance (Quarter)" : -0.0083, "Forward P/E" : 7.64, "P/E" : 3.68, "200-Day Simple Moving Average" : -0.1282, "Shares Outstanding" : 390.6, "Earnings Date" : ISODate("2013-10-28T20:30:00Z"), "52-Week High" : -0.2938, "P/Cash" : 3.93, "Change" : 0.0131, "Analyst Recom" : 2.6, "Volatility (Week)" : 0.0268, "Country" : "USA", "Return on Equity" : 0.205, "50-Day Low" : 0.0695, "Price" : 21.71, "50-Day High" : -0.1066, "Return on Investment" : 0.015, "Shares Float" : 383.97, "Dividend Yield" : 0.1493, "EPS growth next 5 years" : 0.035, "Industry" : "REIT - Residential", "Beta" : 0.51, "Sales growth quarter over quarter" : 0.073, "Operating Margin" : 0.67, "EPS (ttm)" : 5.82, "PEG" : 1.05, "Float Short" : 0.0311, "52-Week Low" : 0.1117, "Average True Range" : 0.52, "EPS growth next year" : -0.3603, "Company" : "American Capital Agency Corp.", "Gap" : 0.0028, "Relative Volume" : 0.71, "Volatility (Month)" : 0.02, "Market Cap" : 8370.56, "Volume" : 4576064, "Gross Margin" : 0.746, "Short Ratio" : 1.69, "Performance (Half Year)" : -0.2136, "Relative Strength Index (14)" : 43.53, "Insider Ownership" : 0.003, "20-Day Simple Moving Average" : -0.0318, "Performance (Month)" : -0.042, "Institutional Transactions" : 0.0077, "Performance (Year)" : -0.1503, "LT Debt/Equity" : 0, "Average Volume" : 7072.83, "EPS growth this year" : -0.169, "50-Day Simple Moving Average" : -0.0376 }
            { "_id" : ObjectId("5285380ebb1177ca391c3101"), "Ticker" : "VOC", "Profit Margin" : 0.971, "Institutional Ownership" : 0.161, "EPS growth past 5 years" : 0, "Total Debt/Equity" : 0, "Return on Assets" : 0.253, "Sector" : "Basic Materials", "P/S" : 9.03, "Change from Open" : -0.0129, "Performance (YTD)" : 0.4186, "Performance (Week)" : 0.0103, "P/B" : 2.44, "EPS growth quarter over quarter" : -0.304, "Payout Ratio" : 1, "Performance (Quarter)" : 0.1116, "P/E" : 9.3, "200-Day Simple Moving Average" : 0.2104, "Shares Outstanding" : 17, "52-Week High" : -0.0417, "P/Cash" : 948.6, "Change" : 0.0024, "Analyst Recom" : 3, "Volatility (Week)" : 0.0289, "Country" : "USA", "Return on Equity" : 0.253, "50-Day Low" : 0.1106, "Price" : 16.78, "50-Day High" : -0.0417, "Return on Investment" : 0.304, "Shares Float" : 12.75, "Dividend Yield" : 0.1266, "Industry" : "Independent Oil & Gas", "Sales growth quarter over quarter" : -0.286, "Operating Margin" : 0.971, "EPS (ttm)" : 1.8, "Float Short" : 0.006, "52-Week Low" : 0.529, "Average True Range" : 0.47, "Company" : "VOC Energy Trust", "Gap" : 0.0155, "Relative Volume" : 0.47, "Volatility (Month)" : 0.0292, "Market Cap" : 284.58, "Volume" : 32718, "Short Ratio" : 0.98, "Performance (Half Year)" : 0.2847, "Relative Strength Index (14)" : 54.66, "Insider Ownership" : 0.3505, "20-Day Simple Moving Average" : 0.009, "Performance (Month)" : 0.0582, "Institutional Transactions" : -0.0349, "Performance (Year)" : 0.3892, "LT Debt/Equity" : 0, "Average Volume" : 77.47, "EPS growth this year" : 0.542, "50-Day Simple Moving Average" : 0.0418 }
            { "_id" : ObjectId("52853807bb1177ca391c279a"), "Ticker" : "MTR", "Profit Margin" : 0.97, "Institutional Ownership" : 0.024, "EPS growth past 5 years" : -0.217, "Total Debt/Equity" : 0, "Return on Assets" : 0.518, "Sector" : "Financial", "P/S" : 12.1, "Change from Open" : -0.0038, "Performance (YTD)" : 0.1833, "Performance (Week)" : -0.0241, "P/B" : 7.82, "EPS growth quarter over quarter" : -0.255, "Payout Ratio" : 0.997, "Performance (Quarter)" : 0.0156, "P/E" : 12.68, "200-Day Simple Moving Average" : -0.0568, "Shares Outstanding" : 1.86, "Earnings Date" : ISODate("2013-11-11T05:00:00Z"), "52-Week High" : -0.1539, "P/Cash" : 23.5, "Change" : -0.0135, "Volatility (Week)" : 0.018, "Country" : "USA", "Return on Equity" : 0.593, "50-Day Low" : 0.0168, "Price" : 21.14, "50-Day High" : -0.1062, "Return on Investment" : 0.655, "Shares Float" : 1.86, "Dividend Yield" : 0.0845, "Industry" : "Diversified Investments", "Beta" : 0.93, "Sales growth quarter over quarter" : -0.222, "Operating Margin" : 0.939, "EPS (ttm)" : 1.69, "Float Short" : 0.0004, "52-Week Low" : 0.2026, "Average True Range" : 0.53, "Sales growth past 5 years" : -0.208, "Company" : "Mesa Royalty Trust", "Gap" : -0.0098, "Relative Volume" : 1.14, "Volatility (Month)" : 0.0226, "Market Cap" : 39.95, "Volume" : 4150, "Short Ratio" : 0.2, "Performance (Half Year)" : -0.1221, "Relative Strength Index (14)" : 34.54, "Insider Ownership" : 0.0385, "20-Day Simple Moving Average" : -0.0408, "Performance (Month)" : -0.0294, "Institutional Transactions" : -0.4527, "Performance (Year)" : 0.0418, "LT Debt/Equity" : 0, "Average Volume" : 3.97, "EPS growth this year" : -0.348, "50-Day Simple Moving Average" : -0.0539 }
            { "_id" : ObjectId("52853809bb1177ca391c2946"), "Ticker" : "OLP", "Profit Margin" : 0.97, "Institutional Ownership" : 0.481, "EPS growth past 5 years" : 0.008, "Total Debt/Equity" : 0.91, "Return on Assets" : 0.072, "Sector" : "Financial", "P/S" : 8.28, "Change from Open" : 0.0072, "Performance (YTD)" : 0.0398, "Performance (Week)" : -0.0156, "Insider Transactions" : 0.0039, "P/B" : 1.2, "EPS growth quarter over quarter" : 1.261, "Payout Ratio" : 0.456, "Performance (Quarter)" : -0.0804, "Forward P/E" : 10.48, "P/E" : 22.12, "200-Day Simple Moving Average" : -0.0742, "Shares Outstanding" : 14.84, "Earnings Date" : ISODate("2013-05-06T04:00:00Z"), "52-Week High" : -0.2453, "P/Cash" : 7.31, "Change" : 0.0077, "Analyst Recom" : 3, "Volatility (Week)" : 0.0166, "Country" : "USA", "Return on Equity" : 0.146, "50-Day Low" : 0.027, "Price" : 20.28, "50-Day High" : -0.1166, "Return on Investment" : 0.051, "Shares Float" : 13.88, "Dividend Yield" : 0.0695, "EPS growth next 5 years" : 0.111, "Industry" : "REIT - Diversified", "Beta" : 2.2, "Sales growth quarter over quarter" : 0.099, "Operating Margin" : 0.537, "EPS (ttm)" : 0.91, "PEG" : 1.99, "Float Short" : 0.0126, "52-Week Low" : 0.2285, "Average True Range" : 0.45, "EPS growth next year" : 0.171, "Sales growth past 5 years" : 0.06, "Company" : "One Liberty Properties Inc.", "Gap" : 0.0005, "Relative Volume" : 0.2, "Volatility (Month)" : 0.023, "Market Cap" : 298.81, "Volume" : 6907, "Gross Margin" : 0.983, "Short Ratio" : 4.64, "Performance (Half Year)" : -0.2219, "Relative Strength Index (14)" : 37.17, "Insider Ownership" : 0.158, "20-Day Simple Moving Average" : -0.0315, "Performance (Month)" : -0.0455, "Institutional Transactions" : 0.0003, "Performance (Year)" : 0.1663, "LT Debt/Equity" : 0.91, "Average Volume" : 37.56, "EPS growth this year" : -0.013, "50-Day Simple Moving Average" : -0.0356 }

d) Qual foi o setor mais rentável?
    Comando: db.getCollection("stock").aggregate(
                [
                    { 
                        "$group" : { 
                            "_id" : "$Sector", 
                            Total : { 
                                $sum : "$Profit Margin"
                            }
                        }
                    },
                    {
                        $sort : { 
                            Total: -1 
                            }
                        }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "_id" : "Financial", "Total" : 162.5356 }
            { "_id" : "Services", "Total" : 20.5515 }
            { "_id" : "Consumer Goods", "Total" : 13.23 }
            { "_id" : "Industrial Goods", "Total" : 11.0327 }
            { "_id" : "Utilities", "Total" : 7.423 }
            { "_id" : "Conglomerates", "Total" : 0.3835 }
            { "_id" : "Basic Materials", "Total" : -9.190900000000001 }
            { "_id" : "Technology", "Total" : -18.8968 }
            { "_id" : "Healthcare", "Total" : -316.68649999999997 }

e) Ordene as ações pelo profit e usando um cursor, liste as ações
    Comando: var cur = db.getCollection("stock").find({}).sort(
                { 
                    "Profit Margin" : -1.0
                }
            );

            cur.hasNext();
            cur.next();
    Output: true
            {
                "_id" : ObjectId("52853801bb1177ca391c1af3"),
                "Ticker" : "BPT",
                "Profit Margin" : 0.994,
                "Institutional Ownership" : 0.098,
                "EPS growth past 5 years" : 0.025,
                "Total Debt/Equity" : 0,
                "Sector" : "Basic Materials",
                "P/S" : 8.81,
                "Change from Open" : 0.0125,
                "Performance (YTD)" : 0.2758,
                "Performance (Week)" : -0.018,
                "P/B" : 2620,
                "EPS growth quarter over quarter" : -0.087,
                "Payout Ratio" : 1.001,
                "Performance (Quarter)" : -0.0556,
                "P/E" : 8.87,
                "200-Day Simple Moving Average" : -0.0305,
                "Shares Outstanding" : 21.4,
                "Earnings Date" : ISODate("2013-11-11T05:00:00Z"),
                "52-Week High" : -0.159,
                "P/Cash" : 1682.04,
                "Change" : 0.0064,
                "Volatility (Week)" : 0.0151,
                "Country" : "USA",
                "50-Day Low" : 0.0136,
                "Price" : 79.1,
                "50-Day High" : -0.0973,
                "Shares Float" : 21.4,
                "Dividend Yield" : 0.1103,
                "Industry" : "Oil & Gas Refining & Marketing",
                "Beta" : 0.77,
                "Sales growth quarter over quarter" : -0.086,
                "Operating Margin" : 0.994,
                "EPS (ttm)" : 8.86,
                "Float Short" : 0.0173,
                "52-Week Low" : 0.3422,
                "Average True Range" : 1.37,
                "Sales growth past 5 years" : 0.024,
                "Company" : "BP Prudhoe Bay Royalty Trust",
                "Gap" : -0.0061,
                "Relative Volume" : 0.93,
                "Volatility (Month)" : 0.016,
                "Market Cap" : 1682.04,
                "Volume" : 71575,
                "Short Ratio" : 4.41,
                "Performance (Half Year)" : 0.0022,
                "Relative Strength Index (14)" : 38.01,
                "20-Day Simple Moving Average" : -0.0318,
                "Performance (Month)" : -0.079,
                "Institutional Transactions" : -0.0057,
                "Performance (Year)" : 0.1837,
                "LT Debt/Equity" : 0,
                "Average Volume" : 84.15,
                "EPS growth this year" : -0.012,
                "50-Day Simple Moving Average" : -0.0496
            }

f) Renomeie o campo “Profit Margin” para apenas “profit”
    Comando: db.getCollection("stock").updateMany( {}, { 
                $rename: { 
                    "Profit Margin": "profit" 
                } 
            });
    Output: acknowledged" : true, "matchedCount" : 6756, "modifiedCount" : 4302 }

g) Agora liste apenas a empresa e seu respectivo resultado
    Comando: db.getCollection("stock").find({}, 
                { 
                    "Company" : 1.0, 
                    "profit" : 1.0
                }
            ).sort(
                { 
                    "profit" : -1.0
                }
            );
    Output: { "_id" : ObjectId("52853801bb1177ca391c1af3"), "Company" : "BP Prudhoe Bay Royalty Trust", "profit" : 0.994 }
            { "_id" : ObjectId("52853802bb1177ca391c1b69"), "Company" : "Cascade Bancorp", "profit" : 0.994 }
            { "_id" : ObjectId("5285380bbb1177ca391c2c3c"), "Company" : "Pacific Coast Oil Trust", "profit" : 0.99 }
            { "_id" : ObjectId("52853808bb1177ca391c281b"), "Company" : "Enduro Royalty Trust", "profit" : 0.986 }
            { "_id" : ObjectId("5285380fbb1177ca391c318e"), "Company" : "Whiting USA Trust II", "profit" : 0.982 }
            { "_id" : ObjectId("52853808bb1177ca391c27bd"), "Company" : "MV Oil Trust", "profit" : 0.976 }
            { "_id" : ObjectId("52853801bb1177ca391c1895"), "Company" : "American Capital Agency Corp.", "profit" : 0.972 }
            { "_id" : ObjectId("5285380ebb1177ca391c3101"), "Company" : "VOC Energy Trust", "profit" : 0.971 }
            { "_id" : ObjectId("52853807bb1177ca391c279a"), "Company" : "Mesa Royalty Trust", "profit" : 0.97 }
            { "_id" : ObjectId("52853809bb1177ca391c2946"), "Company" : "One Liberty Properties Inc.", "profit" : 0.97 }
            { "_id" : ObjectId("52853809bb1177ca391c29c8"), "Company" : "Permian Basin Royalty Trust", "profit" : 0.97 }
            { "_id" : ObjectId("52853802bb1177ca391c1d1b"), "Company" : "Cross Timbers Royalty Trust", "profit" : 0.969 }
            { "_id" : ObjectId("52853805bb1177ca391c22aa"), "Company" : "Harvest Capital Credit Corporation", "profit" : 0.967 }
            { "_id" : ObjectId("5285380fbb1177ca391c318d"), "Company" : "Whiting USA Trust I", "profit" : 0.966 }
            { "_id" : ObjectId("52853807bb1177ca391c2779"), "Company" : "Mesabi Trust", "profit" : 0.963 }
            { "_id" : ObjectId("5285380bbb1177ca391c2cbe"), "Company" : "Sabine Royalty Trust", "profit" : 0.959 }
            { "_id" : ObjectId("52853808bb1177ca391c28a3"), "Company" : "North European Oil Royalty Trust", "profit" : 0.958 }
            { "_id" : ObjectId("5285380bbb1177ca391c2cfb"), "Company" : "Sandridge Mississippian Trust II", "profit" : 0.933 }
            { "_id" : ObjectId("52853805bb1177ca391c22d4"), "Company" : "Hugoton Royalty Trust", "profit" : 0.93 }
            { "_id" : ObjectId("5285380bbb1177ca391c2cfe"), "Company" : "SandRidge Mississippian Trust I", "profit" : 0.928 }
            Type "it" for more

h) Analise as ações. É uma bola de cristal na sua mão... Quais as três ações você investiria?
    Comando: db.getCollection("stock").find(
                { 
                    "Return on Investment" : { 
                        "$gt" : 5.0
                    }, 
                    "profit" : { 
                        "$gt" : 0.5
                    }
                }, 
                { 
                    "Company" : 1.0, 
                    "Performance (Year)" : 1.0, 
                    "Return on Investment" : 1.0, 
                    "profit" : 1.0
                }
            ).sort(
                { 
                    "Performance (Year)" : -1.0
                }
            );
    Output: { "_id" : ObjectId("5285380bbb1177ca391c2cbe"), "Return on Investment" : 12.78, "Company" : "Sabine Royalty Trust", "Performance (Year)" : 0.222, "profit" : 0.959 }
            { "_id" : ObjectId("52853809bb1177ca391c29c8"), "Return on Investment" : 67.5, "Company" : "Permian Basin Royalty Trust", "Performance (Year)" : 0.1883, "profit" : 0.97 }
            { "_id" : ObjectId("52853807bb1177ca391c2779"), "Return on Investment" : 25.583, "Company" : "Mesabi Trust", "Performance (Year)" : 0.0026, "profit" : 0.963 }

i) Liste as ações agrupadas por setor
    Comando: db.getCollection("stock").aggregate([ 
            {
                "$group": {
                    _id: "$Sector", 
                    tickets: {
                        $addToSet: "$Ticker"
                        }
                    }
                } 
            ]);
    Output: { "_id" : "Conglomerates", "tickets" : [ "ANDA", "MMM", "MWRX", "ENT", "SPLP", "CACG", "GDEF", "EAGL", "HRG", "MITSY", "HMTV", "IEP", "HTWO", "AQU", "NC", "JACQ", "QPAC", "PBSK", "SAEX", "LDL", "PME" ] }
            { "_id" : "Healthcare", "tickets" : [ "CRME", "SGYP", "DCTH", "CMRX", "RGLS", "RPTP", "TNXP", "TXMD", "LAKE", "IMRS", "NVS", "PIP", "ADHD", "IDXX", "BKD", "VSCI", "PTCT", "SPEX", "BVX", "ARAY", "NYMX", "XOMA", "FATE", "ACUR", "AHPI", "CERS", "KYTH", "SUPN", "PSDV", "REGN", "ATHX", "ONVO", "ARTC", "MDCI", "VASC", "MSA", "PACB", "SYK", "VCYT", "ANTH", "CYNO", "TGX", "RPRX", "EMIS", "BDSI", "CRDC", "TNGN", "TRGT", "RDY", "CLSN", "ICLR", "ZLTQ", "BSX", "AMED", "OPK", "ARIA", "MEIP", "DGX", "MR", "SKBI", "SSH", "ACHN", "AGEN", "ANCI", "HITK", "GALT", "GHDX", "ALIM", "SIRO", "INFU", "VTUS", "BABY", "BGMD", "CASM", "BMRN", "HMA", "MAKO", "SIGA", "HWAY", "HH", "THLD", "SEM", "ACST", "EPZM", "AUXL", "CRTX", "VVUS", "HCA", "QCOR", "FPRX", "SNTS", "PETS", "RMTI", "EXAS", "WAT", "HTWR", "ALXN", "NLTX", "ABMC", "ARNA", "ADK", "LHCG", "PATH", "BIIB", "UAM", "CAPS", "FMI", "HGR", "DVAX", "NVO", "SPPI", "MD", "EDAP", "SRDX", "OPXA", "SLTM", "MDRX", "PPHM", "GWPH", "ANAC", "OXGN", "PBYI", "ISRG", "GERN", "SRNE", "CYCC", "PRGO", "UTHR", "VRX", "BIND", "LCI", "ARRY", "HNT", "AMSG", "OGXI", "ULGX", "VAR", "MNOV", "BLUE", "SNTA", "AMPE", "GTIV", "BAX", "TTPH", "AEZS", "DVCR", "ITMN", "USPH", "CRL", "THC", "LXRX", "SQNM", "BIOS", "SRPT", "ABMD", "CYTK", "FCSC", "PTLA", "BIOD", "TMO", "HRC", "CXM", "ONTY", "ANIK", "ATRC", "ABIO", "ARQL", "LDRH", "NXTM", "STEM", "CBPO", "COO", "CBMX", "Q", "CFN", "VICL", "MRNA", "GENE", "IG", "LIFE", "TFX", "MACK", "TELK", "ENSG", "ENZY", "NPSP", "ZLCS", "ACT", "CGEN", "CSU", "PLX", "AVNR", "LLY", "DYNT", "SYN", "CHTP", "ABAX", "ISIS", "VPHM", "CADX", "VRNM", "ONCY", "VNDA", "HBIO", "ALSE", "CLDX", "ALNY", "EVHC", "BCR", "MNK", "HUM", "CNMD", "GTXI", "ENZ", "STXS", "CBLI", "SGMO", "CNDO", "RNA", "CPHI", "LPTN", "SCLN", "LMAT", "AIQ", "MNKD", "RELV", "ZMH", "CI", "ATRI", "THRX", "ATOS", "XLRN", "ZIOP", "ABBV", "ALKS", "ADXS", "AMBI", "HZNP", "ENMD", "MYL", "CBRX", "ARWR", "JAZZ", "LPDX", "MSTX", "VSTM", "TRNX", "QDEL", "CBST", "NBIX", "LCAV", "NVAX", "PRSC", "HPTX", "LMNX", "CSII", "OMER", "ONTX", "WLP", "DSCO", "EBS", "AHS", "PGNX", "CEMP", "NAII", "SPAN", "NATR", "MLAB", "GENT", "MMSI", "ASTM", "PBMD", "CDXS", "OHRP", "INCY", "IVC", "RNN", "VOLC", "RVP", "NNVC", "PTIE", "PSTI", "IBIO", "BSPM", "NWBO", "DHRM", "WX", "GEVA", "HTBX", "ATEC", "DRRX", "GNVC", "CYH", "NHC", "SCR", "SGEN", "HIIQ", "EXAC", "JNJ", "LGND", "STJ", "TTHI", "PODD", "XRAY", "INSM", "PRTA", "CELG", "UNH", "CVD", "AXGN", "OSUR", "HLS", "IDRA", "WST", "NBY", "FLML", "TROV", "SSY", "AXDX", "IMMU", "CBM", "INO", "DRTX", "FVE", "CNC", "OCRX", "AFFY", "CCXI", "NBS", "THOR", "KOOL", "DYAX", "CRY", "CHE", "DSCI", "SVA", "OFIX", "NKTR", "ZGNX", "CRMD", "STAA", "DEPO", "TARO", "LPNT", "APPA", "GILD", "STML", "AMRI", "GNBT", "BDX", "STE", "ALXA", "CLVS", "HNSN", "ILMN", "ISR", "IMMY", "OSIR", "SPHS", "AZN", "MOH", "CUTR", "SKH", "NVGN", "DRAD", "BAXS", "ALR", "AGIO", "DNDN", "PRPH", "TSRO", "HSKA", "RMD", "FOLD", "IRWD", "BMY", "XON", "OVAS", "ECTE", "MASI", "QLTI", "PCYC", "ACOR", "ETRM", "CCM", "ICEL", "CYTX", "GNMK", "ENTA", "PKI", "SGNT", "NLNK", "AXN", "ACHC", "DARA", "RDNT", "UNIS", "PFE", "CO", "PMD", "TEVA", "BTX", "ERB", "INSY", "AGN", "RTIX", "SPNC", "SCMP", "GIVN", "BOTA", "PETX", "TRIB", "NSPH", "NAVB", "AFAM", "CYBX", "ELGX", "AMAG", "ANIP", "MGCD", "RGDX", "NSTG", "TGTX", "PTX", "ENZN", "MGNX", "TPI", "USMD", "GB", "ORMP", "PDLI", "CNAT", "MDXG", "ESPR", "PBIO", "KERX", "OPHT", "BRLI", "DXR", "UTMD", "HALO", "MGLN", "EVOK", "MTD", "BIOL", "GSK", "ANGO", "EW", "OGEN", "LH", "PDEX", "ATRS", "AEGR", "PHMD", "ECYT", "HOLX", "UHS", "ESC", "MNTA", "ENDP", "KIPS", "SURG", "ROCM", "VRML", "AMS", "CYAN", "LFVN", "NDZ", "SNN", "RGEN", "APPY", "NUVA", "PTN", "RIGL", "SNSS", "FONR", "HRT", "KND", "AMRN", "APRI", "SLXP", "TECH", "MRK", "INFI", "CYTR", "MSON", "ESMC", "BSTC", "VRTX", "AERI", "TSPT", "NVDQ", "PRXL", "ACAD", "IMGN", "NURO", "BCRX", "DVA", "POZN", "PRAN", "APT", "MYRX", "BONE", "CUR", "VIVO", "MELA", "COV", "SMA", "IPCM", "GALE", "HAE", "HSP", "STSI", "ELOS", "ADUS", "NEO", "CTIC", "ELN", "SNY", "ICCC", "ALGN", "BEAT", "WCG", "AKRX", "ESRX", "NEOG", "UPI", "CMN", "PCRX", "CRIS", "USNA", "WMGI", "ACRX", "GMED", "IPCI", "NSPR", "TEAR", "ICPT", "ZTS", "OREX", "A", "ELMD", "MDT", "EXEL", "AIRM", "IDIX", "IRIX", "KPTI", "ICUI", "HEB", "CPRX", "KBIO", "IMUC", "CORT", "ABT", "BSDM", "OXBT", "OMED", "FMS", "IART", "FRX", "MDCO", "CVM", "AET", "AMGN", "RCPT", "MDVN", "ROSG", "XNPT", "DXCM", "OCLS", "CPIX", "IPXL", "CEMI", "AVEO" ] }
            { "_id" : "Utilities", "tickets" : [ "OGE", "SBS", "SCG", "ED", "FCEL", "SJI", "SRE", "FE", "ATLS", "ADGE", "TAC", "EGAS", "UNS", "ITC", "EBR", "MDU", "OPTT", "PPL", "EQT", "SO", "VVC", "POR", "UTL", "PNG", "DTE", "KEP", "PCG", "PEG", "STR", "SWX", "AWK", "AEE", "NWE", "SMLP", "BEP", "CLNE", "EE", "GAS", "ORA", "ARTNA", "DUK", "CMS", "CNP", "PNW", "DGAS", "RGCO", "GXP", "SXE", "UGI", "WTR", "NJR", "APU", "XEL", "CWCO", "HE", "HNP", "LG", "MGEE", "UIL", "AMID", "WR", "PNY", "WEC", "POM", "DYN", "EDE", "ALE", "BKH", "CHC", "CORR", "CTWS", "WGL", "NU", "TEG", "CWT", "CPN", "CZZ", "NI", "LNT", "PEGI", "ENI", "SJW", "JE", "OTTR", "TRP", "NGG", "SPH", "NKA", "AT", "CNL", "EDN", "FNRG", "PNM", "AWR", "EIX", "OKE", "NEE", "PAM", "YORW", "NWN", "ETR", "EOC", "CDZI", "HTM", "NRG", "D", "NYLD", "CPL", "AEP", "BIP", "CIG", "AVA", "ELP", "ELLO", "TGS", "MSEX", "NVE", "EXC", "CPK", "PCYO", "TE", "IDA", "ATO", "AES" ] }
            { "_id" : "Technology", "tickets" : [ "STV", "VLTC", "COGO", "ASUR", "ESIO", "SLTC", "TRAK", "UIS", "XLNX", "FNSR", "MTSL", "ZHNE", "ZOOM", "ENTG", "FEIC", "GSIG", "ALSK", "RKUS", "CNSL", "TBOW", "CALL", "MVIS", "SGMA", "WTT", "TIBX", "SPWR", "COVR", "CTL", "UBIC", "IGOI", "OTIV", "BCOV", "TIK", "OPAY", "NSR", "ANGI", "BLKB", "AMX", "HSOL", "MKTO", "FB", "RATE", "DVOX", "DRCO", "EXFO", "CIMT", "ALVR", "AVNW", "ISS", "HMNY", "MRCY", "GWAY", "MRVL", "RSYS", "INPH", "KONE", "TEL", "LIQD", "DATE", "AOSL", "CHL", "LDOS", "ABTL", "GLOW", "JNPR", "NATI", "PCYG", "RITT", "ATEA", "TMUS", "TSRI", "ADNC", "ASMI", "MSTR", "NANO", "LSI", "NTS", "QUIK", "SPRT", "TACT", "EQIX", "LRAD", "ANAD", "JIVE", "PMTC", "STX", "TSYS", "VECO", "LOGI", "PMCS", "PNTR", "EPIQ", "CSCD", "AKAM", "DGII", "CCIH", "EMAN", "LMOS", "SEV", "VG", "YNDX", "CLIR", "ASIA", "BITA", "INFN", "ECOM", "NTGR", "PLCM", "MBT", "GLUU", "FRP", "PSMI", "PTNR", "SIMG", "FFIV", "AVX", "CVLT", "BRKS", "IEC", "CLS", "FICO", "IGLD", "PFPT", "TSEM", "EMKR", "TEF", "TWER", "TRNS", "SAPE", "WPCS", "BHE", "CHT", "BBOX", "MEET", "CTCH", "PCTI", "MGIC", "SAP", "DQ", "TWTR", "EGAN", "YOKU", "SONS", "SPNS", "AWAY", "ORCT", "EXAR", "FEIM", "MARK", "FSLR", "QTM", "BRCD", "SSNI", "MOVE", "LOCK", "GVP", "MSI", "VZ", "FARO", "WWWW", "SYNA", "PAR", "AMD", "SQI", "ALTR", "OIBR-C", "NTL", "CCMP", "SOL", "T", "ALU", "MANT", "MSCI", "SHOR", "CUB", "AFFX", "SPA", "SCMR", "TU", "HLIT", "ACTV", "ASX", "AUDC", "CBB", "ORBT", "RDA", "OLED", "TYPE", "VIV", "CODE", "IRF", "MOCO", "RNWK", "USMO", "MDSO", "PWRD", "UNXL", "PRKR", "VRNT", "CTSH", "SWI", "KOPN", "ISNS", "AUO", "PAMT", "ENPH", "MAMS", "MLNX", "NTT", "RDWR", "S", "ATGN", "SANM", "SWKS", "TZOO", "DRWI", "VEEV", "JCOM", "WDC", "WIFI", "ADTN", "OESX", "CLFD", "EXTR", "DTLK", "ADI", "ONNN", "LEAP", "LPTH", "LSCC", "NQ", "ASYS", "MOLX", "CHU", "EONC", "JBL", "COHU", "IMI", "CHYR", "MIXT", "TYL", "AVID", "CCUR", "ORBC", "WGA", "NTE", "NICE", "SCKT", "EGHT", "LVLT", "BSQR", "TCCO", "ATVI", "DCM", "DDD", "LXK", "SNPS", "DRIV", "MPWR", "XRTX", "COMM", "IPHI", "MCHP", "STM", "ELON", "MXWL", "DELL", "BR", "VHC", "DLB", "AMAT", "IHS", "USM", "SUNE", "ALAN", "BIRT", "CRM", "IGT", "ATMI", "PANW", "VIP", "ASTI", "CHA", "CPWR", "ELLI", "CBEY", "FTNT", "MTSN", "CMTL", "RHT", "WIN", "SKM", "LORL", "PLNR", "CSC", "GTAT", "ADP", "AVG", "CYOU", "RCI", "RALY", "EFUT", "MBIS", "LOOK", "CEVA", "SQNS", "ISSI", "YELP", "HCOM", "PINC", "COHR", "SCSC", "GEOS", "DPW", "CERN", "EA", "ESE", "ETAK", "AAOI", "INVN", "ARCW", "ATE", "ATML", "KEM", "JRJC", "KBALB", "ALLT", "GSAT", "MKTG", "TNAV", "EVTC", "TRIP", "LTXC", "GTT", "PULS", "LOGM", "GLW", "MEI", "FCS", "PRFT", "PT", "LLTC", "MORN", "SOHU", "AOL", "CY", "MANH", "TISA", "NVDA", "TI", "MOSY", "VOD", "TIGR", "LOCM", "IXYS", "CALX", "HITT", "NSIT", "GOGO", "ONSM", "KLAC", "INFA", "LRCX", "SGK", "ASML", "CVT", "EVOL", "IMOS", "KVHI", "NOW", "ORBK", "TLK", "GNCMA", "ALTI", "KONG", "N", "GILT", "CCI", "TDS", "MNDO", "CHKP", "IPGP", "MKTY", "OIBR", "PGI", "WAVX", "XPLR", "AFOP", "AMBA", "ELNK", "OCLR", "UBNT", "BIO", "PTGI", "SUPX", "AERG", "OVTI", "ATRM", "PDFS", "OVRL", "TTWO", "YHOO", "ACCL", "CEL", "ADBE", "EGOV", "ANEN", "WIT", "BPHX", "BVSN", "IRDM", "CNTF", "AEIS", "NINE", "RWC", "SIFY", "BCOM", "VDSI", "ATTU", "TXN", "ADSK", "LDR", "IPAS", "VMW", "ZIXI", "SNCR", "SYMM", "CAMP", "BLIN", "LNKD", "GRMN", "IIJI", "RVLT", "SLP", "MSCC", "CAVM", "GIG", "ELTK", "PLUG", "TTMI", "ALOT", "CREE", "EOPN", "SLAB", "TCL", "CLRX", "MIND", "VRNG", "VRTU", "BELFB", "SIMO", "EBIX", "BIDU", "NOK", "SPIR", "MCRL", "WBMD", "XRX", "ACTS", "OTEX", "CNQR", "UPIP", "CRUS", "KNM", "SGI", "AMCC", "BCE", "BNFT", "COOL", "AWRE", "VSAT", "XRSC", "PHI", "NCIT", "MEAS", "LONG", "MOBI", "CYNI", "PTIX", "VNET", "AGYS", "JST", "LEDS", "MXL", "NTWK", "NXPI", "PSEM", "RSTI", "FSL", "FIS", "IDCC", "ARRS", "CTRX", "CTXS", "LTRX", "SNDK", "SMIT", "TXCC", "TLAB", "QBAK", "NLST", "CSOD", "EFII", "FALC", "SCTY", "STP", "I", "FIO", "SPRD", "ATNI", "GIGA", "VMEM", "DAEG", "LTON", "JCS", "ORAN", "BSFT", "SCON", "GIGM", "MITK", "KEYW", "QNST", "ST", "CAMT", "DMRC", "SYKE", "CTRL", "GSIT", "TKC", "TSM", "VJET", "VELT", "EMC", "DSGX", "NTLS", "PRSS", "QLGC", "FDS", "IFON", "NCR", "QIHU", "QUMU", "VSH", "RVBD", "FENG", "GRVY", "BT", "IMPV", "LLNW", "NMRX", "XXIA", "CRTO", "ACXM", "KTCC", "NPTN", "NTES", "TER", "PRCP", "CRAY", "TAOM", "CYBE", "YY", "BCOR", "CNIT", "SMSI", "AMAP", "IBM", "QSII", "IGTE", "SPLK", "SWIR", "ELSE", "CIEN", "FLTX", "GRPN", "SAAS", "CSPI", "AMKR", "ESP", "MXIM", "RTEC", "IT", "OCZ", "FU", "ATNY", "MERU", "SSNC", "MSFT", "CIS", "MCRS", "COVS", "ITRI", "HAUP", "NUAN", "KYO", "IDT", "LUNA", "OPEN", "ORCL", "PKT", "LPL", "LIVE", "BDR", "BV", "DAIO", "FLEX", "RNIN", "RST", "ALOG", "IQNT", "IACI", "TDC", "QLIK", "TRT", "IRM", "RMBS", "TSL", "TSTC", "VPG", "WDAY", "PEGA", "IMMR", "NVEC", "TXTR", "API", "CA", "HSTM", "IIVI", "ULTI", "VCLK", "RFMD", "DWCH", "NEON", "TRLA", "VII", "QCOM", "INFY", "CRNT", "INTC", "JASO", "MTSI", "SILC", "TEO", "VTSS", "CNET", "BMI", "ITI", "TQNT", "BTUI", "SMI", "PKE", "INAP", "HILL", "JDSU", "SEAC", "LXFT", "GKNT", "SLI", "ZNGA", "CMGE", "OPLK", "GIB", "GSB", "ARX", "BRCM", "AVGO", "CCOI", "AEHR", "FLDM", "HTCO", "IKAN", "IMN", "AMSWA", "CALD", "INS", "DLGC", "EPAY", "ININ", "OTEL", "POWI", "PXLW", "MFLX", "TNGO", "UMC", "WIRE", "YGE", "OMCL", "NCTY", "CTG", "VIAS", "CPHD", "MITL", "SYNT", "CDNS", "CSCO", "MDAS", "REDF", "SFUN", "TST", "MRIN", "GAME", "HIMX", "SYPR", "DST", "LDK", "OIIM", "GA", "DWRE", "NSYS", "WSTL", "ANSS", "RFIL", "SYX", "ACIW", "DNB", "ALTV", "ARMH", "IVAC", "FEYE", "ACLS", "ADVS", "AZPN", "CTS", "ERIC", "EZCH", "CPSI", "MENT", "ENTR", "NEWN", "NTAP", "NVMI", "NVTL", "PLXT", "AXTI", "HTCH", "MXT", "FTR", "NETE", "DYSL", "RNET", "ROVI", "STRM", "STRN", "RNG", "PERI", "TSRA", "TTGT", "VICR", "APH", "BOSC", "GOOG", "GWRE", "IPDN", "IDTI", "JKHY", "BRKR", "ISIL", "NTCT", "PLAB", "AMBT", "PLXS", "PRGS", "SMCI", "IL", "RRST", "SMTX", "MU", "INOD", "AYI", "INVE", "PACT", "SSYS", "EXE", "SYNC", "TI-A", "TRMR", "TWTC", "WUBA", "ZIGO", "SLH", "INTT", "SPCB", "EDGW", "TCX", "UCTT", "DSPG", "FORTY", "VOCS", "VRSN", "DTSI", "BBRY", "NIHD", "PRO", "GUID", "INTU", "DGLY", "GCOM", "KLIC", "LFUS", "DBD", "QLYS", "QADA", "TRMB", "AMSC", "UTEK", "CKSW", "HURC", "KT", "HPQ", "MX", "MATR", "MKSI", "EXA", "NLSN", "MCZ", "ICAD", "SATS", "BRC", "SAIC", "ARUN", "RDCM", "SABA", "PCO", "CLRO", "SREV", "STRP", "CSGS", "ADAT", "ENVI", "IDSY", "SPSC", "UTSI", "VCRA", "CBR", "CGNX", "GIMO", "DRAM", "ELX", "DOX", "RAX", "DSTI", "RBCN", "RP", "SOFO", "SYMC", "TSU", "IO", "HRS", "DATA", "ACN", "PLT", "SHEN", "SINA", "EIGI", "CSUN", "MRGE", "CSIQ", "DMD", "MSPD", "EPAM", "MONT", "MTSC", "FORM", "PLUS", "SMTC", "SPIL", "DIOD", "CRDS", "SIGM", "VIDE", "INXN", "VIMC" ] }
            { "_id" : "Consumer Goods", "tickets" : [ "CROX", "BF-B", "INGR", "SHLO", "JVA", "DW", "BEST", "HOFT", "ETH", "FLXS", "FOSL", "BDE", "SORL", "KTEC", "BC", "SYUT", "DLA", "JAKK", "THRM", "VRA", "GIL", "MKC", "BERY", "FFHL", "MWV", "DMND", "CCE", "KEQU", "KRFT", "UNF", "LEA", "VGR", "JSDA", "FSS", "ESCA", "PVH", "GEF", "BREW", "CENT", "FMX", "DSKX", "TM", "NLS", "MNST", "HAS", "MTOR", "LANC", "AKO-B", "CCH", "BEAM", "BUD", "DECK", "FBHS", "LULU", "WGO", "KID", "CHMP", "PBH", "SCSS", "MFRM", "POST", "CXDC", "FOXF", "GAGA", "GM", "SHOO", "ADM", "STS", "TSLA", "DAN", "UVV", "CALM", "NPK", "WVVI", "HMC", "SPU", "TBAC", "ARCI", "HELE", "COTY", "KOF", "CMT", "FBR", "GNTX", "THS", "DORM", "BTI", "HNI", "LEG", "CVGW", "CRESY", "LUK", "LBIX", "NTIC", "OBCI", "PERY", "MOD", "ONP", "RCKY", "ECL", "TG", "TXIC", "SR", "FN", "QTWW", "WNC", "AEPI", "BNNY", "CQB", "GT", "ABV", "F", "SKUL", "UFS", "BG", "GLDC", "NUS", "SNAK", "FNP", "HSH", "SHFL", "LNCE", "LZB", "SMP", "STZ", "STRI", "TLF", "OINK", "EVK", "KO", "NP", "PHG", "REMY", "SGOC", "WWAV", "AMTY", "STLY", "CAJ", "CHD", "CTB", "FLO", "MGPI", "DF", "FL", "DFZ", "LKQ", "KODK", "MPAA", "UG", "STKL", "DLPH", "OI", "ALN", "CPS", "GPIC", "FARM", "FDML", "KOSS", "BLL", "OME", "AMWD", "IBA", "SNE", "WWW", "MINI", "MLHR", "UFPT", "ALV", "ZA", "CAW", "GRIF", "ALCO", "OBT", "PBI", "XRM", "THST", "ZQK", "RKT", "SENEA", "ATR", "JJSF", "RAI", "TWI", "ALSN", "AVY", "FIZZ", "ENR", "COKE", "MDLZ", "SGC", "WPRT", "CRWS", "WHR", "CPB", "EL", "EVRY", "CAG", "MLR", "AAPL", "SUMR", "CHSCP", "FSYS", "BTH", "OSK", "ANDE", "POOL", "PG", "AVP", "SON", "BWA", "CCU", "TUP", "WPP", "CSL", "GIS", "WBC", "BTN", "CLX", "HSY", "CRI", "DPS", "TPX", "AGRO", "SEED", "TRW", "GRO", "SCS", "TIS", "ZX", "UEIC", "ELY", "PAY", "SRI", "COLM", "KMB", "UL", "SLGN", "CRMB", "KS", "NCFT", "IPAR", "TTM", "ROX", "VC", "NKE", "ICON", "NWL", "CWTR", "HOG", "MYE", "BDBD", "XNY", "KNDI", "SENEB", "PM", "MSN", "PF", "JAH", "LF", "CLW", "GMK", "HBI", "SAFM", "LBY", "DEO", "BRFS", "HAR", "IP", "MOV", "PRMW", "BGS", "LMNR", "MERC", "REED", "TR", "WILC", "SQBG", "MAT", "TEN", "JOEZ", "PPC", "ATX", "ACCO", "CAAS", "COH", "HLF", "PII", "RL", "VRS", "ZEP", "STRT", "BSET", "FDP", "GPK", "SPAR", "LCUT", "CCK", "MPX", "TAP", "EDS", "ACW", "NAV", "SCL", "SJM", "CELH", "SKX", "TOF", "SUP", "NSANY", "RMCF", "MO", "COBR", "BMS", "TFCO", "DAKT", "JOUT", "RDEN", "THO", "PEP", "CELM", "FHCO", "JBSS", "LWAY", "CPGI", "DEER", "DOLE", "CMFO", "NTZ", "WEYS", "K", "SAM", "GMCR", "AKO-A", "SANW", "MTEX", "SWM", "TSN", "BRID", "UA", "ACU", "NUTR", "ACAT", "ESYS", "MJN", "AXL", "COT", "DSWL", "GIII", "PCAR", "IRBT", "SEB", "SWSH", "CTIB", "EBF", "EGT", "HY", "PLOW", "RFP", "ROG", "SEE", "VFC", "LO", "HRL", "APP", "CL", "UN", "VCO", "MNRO", "GLT", "PKG", "REV", "AOI", "BORN", "KNL", "OXM", "VIRC", "JCI", "SODA" ] }
            { "_id" : "Industrial Goods", "tickets" : [ "MHK", "AEGN", "CAE", "ESLT", "TKR", "TS", "ETN", "DXYN", "GTLS", "DCO", "HDNG", "GNRC", "MLI", "HWG", "BZH", "CFI", "GLPW", "ISSC", "OC", "RYN", "SRCL", "JCTCF", "TOL", "CYD", "LMT", "TILE", "UFPI", "VE", "XLS", "HIHO", "TRS", "SNA", "HUB-B", "ZOLT", "RTN", "CAS", "COL", "DHI", "MTZ", "GFA", "AIRI", "ULBI", "IR", "MOG-A", "PWR", "WWD", "GE", "GGG", "BLT", "FLS", "NTK", "GY", "ORN", "PGTI", "PIKE", "RBC", "SPR", "SIF", "B", "NDSN", "RXN", "TPC", "DAR", "IESC", "HII", "HEES", "ORB", "PESI", "ATK", "CRS", "SWHC", "TWIN", "ITW", "AP", "ZBB", "TRIT", "CBAK", "TASR", "ARTW", "LECO", "AERT", "PH", "NJ", "REFR", "ROLL", "DEL", "TPH", "HXM", "MEA", "KMT", "MASC", "RSG", "ITT", "XONE", "ACFN", "CRH", "TGI", "ATI", "DRC", "KAMN", "MAS", "TEX", "BWC", "HEI", "VMC", "WCN", "AVHI", "PSIX", "AMRC", "AWI", "CVV", "AIXG", "AME", "CR", "FWLT", "GIFI", "AZZ", "GV", "LLL", "NCS", "HEAT", "CCCL", "PCP", "PRLB", "ROK", "SCX", "BNSO", "TECUA", "CLC", "SXI", "USCR", "GVA", "AETI", "NX", "CWST", "FTEK", "CCIX", "ATU", "GRC", "SI", "MHO", "ERJ", "THTI", "HW", "VTNR", "ROP", "NVR", "LEN", "BA", "MRC", "CHCI", "CX", "DE", "MTRX", "CCF", "BDC", "ZEUS", "KBH", "XYL", "MIDD", "ASTC", "AVAV", "CADC", "HOLI", "HOV", "BLDP", "IIN", "MICT", "TAYD", "BGG", "CDTI", "GHM", "TNC", "CPST", "BGC", "WY", "EAC", "LGL", "ACPW", "GD", "DY", "JOY", "TREX", "BOOM", "BWEN", "LAYN", "TOWR", "BCC", "CVR", "APOG", "FIX", "JHX", "JKS", "TXI", "CSTM", "CW", "SNHY", "HPJ", "HI", "IDSA", "PHM", "MAG", "CMCO", "IGC", "TXT", "FLIR", "MNTX", "WM", "LYTS", "PLPC", "UQM", "HAYN", "HON", "CAT", "WOR", "AAON", "BECN", "CVU", "MTH", "LNN", "TDG", "STCK", "AIMC", "PRIM", "SVT", "XIN", "EME", "BIN", "NES", "BRSS", "RSOL", "CREG", "UTX", "DHR", "CSTE", "MLM", "TDY", "DCI", "UFI", "NOC", "PNR", "RGR", "ADES", "MKTAY", "MYRG", "FAST", "ICA", "POWL", "PGEM", "STRL", "CUO", "EML", "ASTE", "EMR", "LXFR", "ADEP", "AOS", "SCHN", "EEI", "ABB", "ESL", "MY", "USG", "GRH", "CLH", "IEX", "CCC", "SSD", "GPRC", "SPW", "AGX", "ENS", "KAI", "OSIS", "ALG", "TMHC", "DGI", "SPB", "SMED", "SWK", "AMOT", "AGCO", "ECOL", "EFOI", "LMIA", "TATT", "HCCI", "CMI", "RYL", "NPO", "RAVN", "THR", "MDC", "PPO", "GTI", "CUI", "CPAC", "TTC", "APWC", "PATK", "SPF", "PKOH", "POPE", "GLDD", "WSCI", "DOV", "PMFG", "PFIN", "ARTX", "CBI", "BEAV", "NFEC", "LII", "AWX", "CFX", "BZC", "FLOW", "FELE", "GENC", "ATRO", "HNH", "JBT", "CIR", "CVCO", "MTW", "GAI", "RINO", "TRR", "FLR", "RS", "USLM", "EXP", "HXL", "HYGS", "CLNT", "IDN", "PLL", "VMI", "EVAC", "CECE", "CVA", "WTS", "MFRI", "ZBRA", "SKY", "DOOR", "NNBR", "OFLX", "AIN", "CNHI", "GFF", "MWA", "CLWT", "ERII" ] }
            { "_id" : "Services", "tickets" : [ "APOL", "BWS", "TV", "YOD", "INOC", "NETC", "ORLY", "TNP", "KSS", "NNA", "CPRT", "UNP", "RYAAY", "BONA", "ACM", "UACL", "HTSI", "SAIA", "UWN", "ZNH", "MCO", "RLGT", "CALI", "NCMI", "NED", "RT", "IMAX", "HRB", "CJJD", "KEX", "BAMM", "DRII", "PATR", "TWMC", "ATHN", "RICK", "DLIA", "LVS", "DVD", "MYCC", "TUES", "VSI", "WERN", "FUN", "VPRT", "AYR", "WFM", "SKS", "UNTD", "AMCX", "CSV", "ISH", "TGT", "CTRP", "CBZ", "JMBA", "ALGT", "CNSI", "GSL", "DG", "DCIX", "CAH", "FISV", "LIN", "EXPO", "LINTA", "FREE", "PSMT", "COST", "CHUY", "FRS", "NYNY", "ASC", "AIR", "EXPR", "AAWW", "IRG", "AIT", "RDI", "ASEI", "APEI", "EVC", "SAVE", "SBH", "CACH", "FINL", "SFE", "SHOS", "ANN", "CETV", "DM", "GWR", "ALCS", "GMAN", "DJCO", "BWL-A", "PAG", "FWRD", "RCL", "SBUX", "AZO", "CATO", "CSX", "HD", "BIDZ", "NAUH", "DGIT", "CVO", "PIR", "RRTS", "CDW", "SGMS", "MCHX", "CPA", "BDMS", "SSTK", "STB", "HTZ", "HCSG", "ECHO", "PTRY", "MHH", "SPRO", "HOLL", "STN", "STON", "PCMI", "JCP", "TLYS", "TRK", "PTNT", "DRYS", "WAIR", "XPO", "STRZA", "CHKE", "KAR", "RMKR", "CDI", "ISIG", "EXPD", "GFN", "CHH", "DXPE", "LOW", "TAX", "ULTA", "QKLS", "KNOP", "UUU", "VIPS", "RGS", "VTNC", "DV", "PAC", "SHLD", "XRS", "UPS", "BID", "HTLD", "EZPW", "CODI", "CUK", "MWIV", "VALU", "WACLY", "CTCT", "WSM", "LQDT", "TOO", "CNTY", "STAN", "DAVE", "MG", "ELRC", "KUTV", "ARCO", "BH", "NEWT", "CXW", "DHT", "CNI", "GDOT", "LOJN", "WLFC", "JRN", "GBX", "RUTH", "SKYW", "URS", "JACK", "CHRM", "KORS", "MGM", "HSON", "LRN", "ENG", "PZZI", "ASNA", "FORR", "IMKTA", "MGRC", "PRLS", "SPTN", "AER", "CTHR", "KBR", "VOXX", "EMMS", "ASGN", "ACY", "LAWS", "FSTR", "ERA", "CHRW", "RECN", "TGP", "CEDU", "EXAM", "STNG", "ABG", "RTI", "SSI", "WSO", "BEBE", "CCSC", "G", "GASS", "DSX", "COCO", "IHG", "JNY", "DAL", "HDSN", "JOBS", "NILE", "FLWS", "DCIN", "LABL", "MGT", "PBPB", "HPY", "PTSX", "REIS", "CKP", "CTRN", "FTDDV", "BBY", "GAIA", "FCN", "GLBS", "HGG", "CMLS", "III", "ENOC", "LINC", "MDP", "LL", "OSTK", "BONT", "CST", "MYGN", "AAP", "ABCO", "CAB", "DLX", "FRGI", "DWA", "LBTYA", "LTM", "NPD", "FURX", "PNRA", "EDUC", "AAN", "EDG", "QUNR", "SMRT", "JEC", "CVG", "NGVC", "INUV", "NEWL", "PENN", "SGRP", "JBHT", "RMGN", "TESS", "FLY", "TOPS", "TTEK", "TECD", "NM", "NSP", "TWC", "UEPS", "USTR", "WMK", "LCC", "BAH", "NYT", "MED", "RCII", "WTW", "SINO", "HIBB", "PFSW", "VLRS", "CNW", "BAGL", "BKW", "ERS", "PERF", "STEI", "DTV", "QLTY", "PZZA", "PRAA", "BBSI", "ROIAK", "GLNG", "PFMT", "XUE", "AMZN", "BBW", "CARB", "DANG", "HAIN", "MPEL", "CKH", "BGFV", "BBRG", "CEB", "FC", "MGAM", "IKGH", "RLJE", "SCVL", "TISI", "OEH", "MMYT", "PWX", "TSCO", "EXLS", "UTI", "ROST", "WEX", "LYV", "CRMT", "HCKT", "JBLU", "KMX", "MTN", "RLOC", "HPOL", "SPDC", "RGC", "SRT", "KIRK", "PSUN", "CRWN", "MLNK", "ITRN", "UPG", "URBN", "PDCO", "BPI", "DGSE", "TTS", "LPSN", "HZO", "MAR", "RHI", "BLOX", "SBAC", "EDMC", "TAST", "RUSHB", "VALV", "VCI", "VSCP", "BURL", "PETM", "BODY", "ESEA", "LVNTA", "PHII", "KNX", "LITB", "NAT", "ONVI", "AXE", "ONE", "LUV", "LMCA", "SCIL", "AN", "VLGEA", "CNR", "CAST", "VNTV", "EVI", "DEG", "KSU", "VRSK", "CGX", "CBD", "FOXA", "LACO", "BBGI", "LIOX", "INWK", "MUSA", "RLD", "TWX", "BRS", "CVS", "CAKE", "CONN", "GWW", "NTSC", "ABCD", "NWSA", "R", "TCS", "WINA", "GK", "DENN", "KFRC", "ODFL", "CVC", "BYI", "ADS", "SONC", "TAL", "YUME", "LAD", "AIRT", "ENV", "HAST", "DKS", "FLT", "IILG", "BJRI", "COSI", "ISLE", "KONA", "LIME", "MANU", "CASY", "MRTN", "NWY", "PCLN", "RJET", "RUK", "SVU", "MAN", "FRM", "MCK", "TA", "SIX", "DHX", "UHAL", "AHC", "NRCIB", "VISN", "YUM", "ICFI", "EXPE", "TGH", "JWN", "ALK", "LGF", "NFLX", "OMI", "PSO", "MSO", "PRGX", "DIS", "BLMN", "DDS", "MNDL", "RBA", "ESSX", "TEU", "WSTG", "ARC", "ASFI", "WWE", "CBRL", "LOV", "EEFT", "CHEF", "CTCM", "BKE", "CVGI", "ATSG", "AL", "PLCE", "EBAY", "PACR", "RNDY", "GCI", "WPO", "BXC", "HOT", "OMAB", "WYN", "MWW", "WLDN", "ACTG", "CPLP", "SFXE", "MELI", "DLTR", "CLCT", "BCO", "RH", "STNR", "LFL", "WSTC", "CRVP", "MNI", "WEST", "AH", "SCHL", "CPHC", "FRAN", "FLL", "GMT", "MOC", "SSW", "GPC", "WMT", "JOSB", "BKS", "H", "PTEK", "SUSP", "SALM", "GNC", "ETM", "P", "QUAD", "GTIM", "MSG", "DIT", "CECO", "SCOR", "MGA", "LAS", "ASCMA", "RAIL", "RENT", "ARO", "SWFT", "ARW", "CAP", "CZR", "PRGN", "EGLE", "PRIS", "WYY", "SBGI", "EDU", "TRI", "VITC", "GLP", "BGI", "HHS", "MNTG", "SAH", "WTSL", "SHIP", "DLHC", "BDL", "TIVO", "KR", "XOXO", "GMLP", "LEE", "CMCSA", "FORD", "NMM", "GOL", "BOBE", "HURN", "CACI", "HWCC", "MMS", "OUTR", "CHTR", "SFLY", "EPAX", "VLCCF", "DXLG", "UNFI", "WPPGY", "DAC", "CHDX", "WNS", "VAC", "CRRC", "RPXC", "SUSS", "FIVE", "KKD", "FTD", "TUMI", "USAK", "EAT", "HSNI", "MSM", "SB", "OWW", "URI", "MATW", "ESI", "CATM", "BASI", "CNK", "CEC", "RRD", "DSS", "JOB", "ARKR", "DSW", "LPS", "HMSY", "PRTS", "SFL", "M", "CCRN", "DISH", "PMC", "VIFL", "HSII", "INTX", "BIG", "DISCA", "IM", "DIAL", "VSR", "TK", "JW-A", "MEG", "DIN", "GCO", "VVI", "CRAI", "DFRG", "WAG", "CRV", "NXST", "SCI", "OCR", "CBS", "CORE", "NTN", "CP", "SYY", "CNCO", "GPI", "DL", "WMAR", "NDLS", "TIF", "CCGM", "CIX", "NTRI", "BSI", "NCI", "UNTK", "ATAI", "OMC", "SBLK", "SSP", "LPX", "RLOG", "TTEC", "BLC", "LUB", "PAYX", "ATV", "BWLD", "STRA", "GES", "PDII", "CBK", "WCC", "MW", "RLH", "PTSI", "TJX", "ISCA", "VVTV", "CSS", "HMIN", "HIL", "SED", "CGI", "FRO", "CNYD", "HVT", "MHFI", "MHGC", "BALT", "TMNG", "USAT", "RSH", "AEO", "WAGE", "ABC", "AMCO", "OMEX", "TRN", "MCRI", "NSC", "RRGB", "SEAS", "THI", "RADA", "GTN", "SBSA", "SWY", "MCOX", "CMRE", "ADT", "BAGR", "CLUB", "CEA", "DOVR", "CAR", "DXM", "GSH", "IDI", "ASR", "MATX", "NATH", "CRRS", "ARDNA", "CMG", "ICLD", "AVT", "NAFC", "STMP", "BLDR", "GPX", "TAIT", "HUBG", "DNKN", "FDO", "HOTR", "GNK", "GPN", "ABFS", "CIDM", "DRI", "LTRE", "MDCA", "ODP", "SIG", "SIRI", "PNK", "SALE", "SNI", "ENL", "PRXI", "SNX", "ROIA", "SPCHB", "BYD", "FWM", "GCFB", "CTAS", "HA", "FDX", "ANF", "KFY", "IPG", "MCD", "GEO", "HDS", "DEST", "GSOL", "HSIC", "CHDN", "NSSC", "PBY", "LOPE", "OMX", "MM", "PCCC", "RAD", "SFN", "SGA", "LSTR", "ULTR", "UAL", "TXRH", "BBBY", "EGL", "VIAB", "KELYA", "VSEC", "WAB", "XWES", "SPLS", "YRCW", "ZAGG", "AMCN", "TBI", "RENN", "ZLC", "CKEC", "TMH", "GLOG", "GRAM", "TUC", "CPLA", "AFCE", "CCO", "CHS", "MAGS", "DDE", "LTD", "CDII", "POWR", "CTP", "RELL", "GPS", "RCMT", "FRED", "MCS", "TFM", "TITN", "TYC", "WEN", "HTHT", "LAMR", "KTOS", "LUX", "DPZ", "CVTI", "AEY", "NEWP", "ABM", "SFM", "CCL", "ROL", "SJR", "TNK", "TW", "WOOF", "MIC", "WYNN", "GME", "UTIW", "BFAM", "ARII", "CASS", "FUEL", "QGEN", "ZUMZ" ] }
            { "_id" : "Basic Materials", "tickets" : [ "EXLP", "AEM", "ARG", "URG", "CHK", "KGJI", "FOE", "RGLD", "RVM", "PLG", "CGG", "DO", "EMXX", "CJES", "KOG", "EQU", "RNO", "SHI", "CMP", "PBR-A", "SOQ", "MTL", "ZAZA", "NFG", "UAMY", "FNV", "SYRG", "AG", "BRN", "CVE", "DWSN", "PAGP", "MXC", "XCO", "MPLX", "SYNL", "ZINC", "WGP", "ACH", "JRCC", "CRT", "CXO", "CVI", "HUSA", "EROC", "EOX", "GDP", "NL", "NR", "SZYM", "SCEI", "PTEN", "PPP", "GURE", "LYB", "NG", "PKD", "MDW", "REX", "MCF", "MPC", "APD", "QEP", "GTU", "PSTR", "MEMP", "EVEP", "HMY", "PHX", "ALB", "IOC", "AMCF", "ATW", "FST", "OXF", "MNGA", "SGY", "EPB", "TPLM", "MIL", "NE", "PGH", "SWC", "VTG", "FSM", "CBT", "DNR", "GORO", "CDE", "BHP", "VNR", "WLB", "AKS", "SID", "PEIX", "OII", "MTDR", "MPET", "DVN", "WHX", "BTU", "FXEN", "IPHS", "NUE", "RDS-B", "SD", "PBT", "BAK", "CIE", "STO", "MEOH", "VHI", "GPOR", "NOR", "CLD", "HNR", "PZG", "SMG", "CDY", "HFC", "FISH", "FTI", "OILT", "DPM", "PDO", "PSE", "NGL", "WES", "GGB", "ARSD", "ORIG", "ABX", "LXU", "IOSP", "NGS", "GBR", "HK", "JONE", "LGCY", "PWE", "NEU", "MGN", "CYT", "ROYT", "URRE", "CPE", "SFY", "GRA", "AVD", "MBLX", "ENB", "KGC", "BPL", "DD", "PES", "LIWA", "ALDW", "SDT", "NOV", "SDR", "MPO", "BRD", "QMM", "TGC", "CEP", "CPSL", "BIOF", "FI", "OLN", "ODC", "QEPM", "CERE", "TX", "KMP", "GSI", "NAK", "MTX", "TGA", "EMES", "SXC", "VGZ", "SXL", "TRQ", "REXX", "ARP", "RGP", "PAL", "AR", "AVL", "DKL", "FRD", "HOS", "ANR", "DBLE", "LPI", "OCIP", "POT", "RIC", "COP", "BOLT", "DDC", "NBL", "KALU", "REI", "MMLP", "MUX", "EC", "PDCE", "KBX", "PED", "SWN", "SYT", "URZ", "ROCK", "MMP", "CMC", "WLT", "APL", "MUR", "MON", "KRA", "TAHO", "HWKN", "ATL", "LNCO", "TAM", "END", "MDM", "SXT", "AGI", "ALJ", "TCP", "APFC", "NGD", "PXD", "TEP", "ACI", "NSH", "CEO", "LEI", "NWPX", "EXK", "LRE", "TGB", "AREX", "PVG", "SJT", "SIAL", "BXE", "RTK", "FCX", "IKNX", "ANV", "PVA", "NSLP", "OMG", "YZC", "IFF", "PZE", "IMO", "DRQ", "MGH", "SYMX", "LTBR", "CRZO", "MILL", "ROSE", "GEL", "GTE", "ACO", "EGN", "EQM", "SGU", "VALE", "TLM", "AUMN", "EXXI", "IFNY", "UNT", "SSLT", "KIOR", "SCOK", "MEIL", "PBR", "IVAN", "AMRS", "CHOP", "GG", "BCEI", "X", "APC", "XOM", "OAS", "RECV", "AA", "CLF", "SNMX", "SRLP", "TCK", "SCCO", "FET", "GFI", "EPL", "VOC", "ESTE", "AAV", "HCLP", "KEG", "KMR", "HES", "APA", "BP", "IPI", "BBL", "EPD", "AE", "PBM", "GOLD", "NTI", "SNP", "CLMT", "SSRI", "SYNM", "WRES", "DNN", "RRMS", "ASM", "ECA", "GLF", "GNI", "GSJK", "PAAS", "SLCA", "CENX", "FPP", "TAT", "SARA", "WLL", "SDRL", "CHKR", "CQP", "ACMP", "DRD", "ARLP", "BPT", "BVN", "PTR", "RNF", "RRC", "ACET", "KRO", "HUN", "USU", "DK", "RPM", "TROX", "RIOM", "GMET", "CNX", "CERP", "ROYL", "POL", "WH", "MBII", "UGP", "GSV", "PGRX", "USAC", "QRE", "GEVO", "RIG", "WHZ", "WMB", "WLK", "XTXI", "SVBL", "REGI", "VET", "WFT", "AHGP", "XTEX", "BTE", "EGY", "FES", "KWR", "TC", "AXX", "HL", "AXLL", "PAA", "PDS", "SHLM", "ISRL", "HP", "OIS", "WDFC", "E", "SIM", "CRR", "CF", "CGR", "BIOA", "CVX", "LLEN", "MOS", "GMO", "LINE", "FSI", "GSS", "LSG", "PBA", "ECT", "MT", "TRGP", "CLR", "HAL", "KOS", "MACE", "REE", "MWE", "RIO", "EGO", "EPM", "LNDC", "NS", "TAS", "CGA", "GSE", "TDW", "STLD", "NRP", "GPRE", "XPL", "AKG", "ETP", "AAU", "AUQ", "KMI", "YONG", "MHR", "HSC", "RBY", "MVO", "BBEP", "SXCP", "FGP", "PBF", "BCPC", "CLB", "SAND", "FTK", "APAGF", "TSO", "MDR", "COG", "IAG", "BAS", "ETE", "NDRO", "SHW", "AZC", "CAM", "GST", "MRO", "SLW", "SPN", "BBG", "NOG", "SE", "USEG", "TTI", "AXAS", "UEC", "LGP", "ANW", "NBR", "SQM", "SVM", "THM", "EEP", "FANG", "CNQ", "LODE", "BWP", "REN", "SA", "PSXP", "CCJ", "AWC", "ASH", "PACD", "QRM", "SBGL", "XEC", "GNE", "PLM", "GSM", "CMLP", "BPZ", "PVR", "SEMG", "TGD", "TRX", "FMC", "HDY", "SLB", "WPX", "GPL", "PSX", "EMN", "PNRG", "WNR", "DEJ", "EXH", "HNRG", "CVRR", "NCQ", "PPG", "EGI", "DOW", "AXU", "CAK", "NOA", "HBM", "OSN", "SSN", "WPZ", "ZN", "BHI", "CEQP", "FUL", "HEP", "UAN", "UPL", "GGS", "PDH", "AGU", "HERO", "OXY", "PX", "VLO", "PURE", "MCP", "NGLS", "NFX", "RES", "PQ", "SUTR", "SVLC", "TORM", "OMN", "TLP", "KWK", "MTRN", "ATHL", "TLLP", "TNH", "AU", "IIIN", "XRA", "NEM", "CHNR", "SSL", "YPF", "OCIR", "ERF", "HGT", "LNG", "SU", "PKX", "WNRL", "TESO", "MCEP", "FF", "BKEP", "WG", "CHGS", "INT", "BAA", "EOG", "EEQ", "NSU", "CWEI", "PENX", "AUY", "CHMT", "SM", "MVG", "KMG", "ESV", "BRY", "HLX", "RCON", "ROC", "WTI", "DVR", "KOP", "TOT", "CRK", "SN", "SEP", "VAL", "RDC", "TGE", "OKS", "USAP", "SDLP", "TLR", "CE", "PER" ] }
            { "_id" : "Financial", "tickets" : [ "SNBC", "IYLD", "AV", "PCH", "UBSH", "AWP", "CSGP", "BRAZ", "FFG", "MGF", "RGI", "TEI", "ULQ", "CHY", "HPP", "MMU", "CSLS", "EV", "HEDJ", "QEH", "TBAR", "IHY", "FAV", "ECNS", "LARK", "MHE", "EPP", "NDAQ", "ORRF", "ABCB", "METR", "SMMF", "DFT", "ADRD", "ROM", "SZO", "UHN", "VCV", "XPH", "EXI", "EPI", "FEZ", "MSBF", "DIA", "EWP", "OSBC", "FKU", "SPXH", "AXIT", "PGM", "SCHV", "FAC", "ISL", "AKR", "DLR", "MRH", "EWM", "SIVB", "SMPL", "TCBI", "VTWG", "GNW", "ISRA", "FII", "GIM", "SDIV", "EGBN", "LATM", "REK", "DZK", "PZI", "TNDQ", "HPF", "TELOZ", "MATL", "HYV", "EMMT", "UHT", "HBOS", "CUPM", "CM", "CZNC", "RJF", "VOYA", "ESR", "EES", "CARV", "AUD", "GMF", "AMRE", "NFBK", "SH", "TWN", "CHXF", "VONE", "WFD", "EJ", "HQL", "MFC", "DRR", "RNE", "PFF", "NRO", "TSC", "URTY", "AAME", "MLPN", "NYF", "SKYY", "BBD", "VOO", "CANE", "PSCD", "MLPI", "GWX", "ARR", "OIL", "EMIF", "MHF", "AXEN", "MCRO", "AINV", "IGD", "UAG", "VNQI", "VSB", "CEE", "CH", "COLB", "EHI", "ELD", "FNI", "JKK", "SUNS", "VRD", "GRF", "RUSL", "NASH", "MSB", "MUH", "JDD", "BOTJ", "RBL", "SWZ", "IYF", "ESNT", "JJM", "VCF", "XL", "EPU", "AMSF", "IYC", "CLI", "PXE", "NATL", "IAK", "WPC", "WSBC", "RVT", "ITM", "SSG", "HTBK", "BMO", "WEET", "USL", "PCM", "MUNI", "PGF", "ZSL", "CLMS", "TDV", "WBCO", "WBB", "EVP", "PNI", "KBWP", "DBS", "HYS", "PGC", "MBI", "XLV", "IPFF", "TDF", "HWBK", "BRKL", "RCS", "EMDG", "IDU", "PYN", "ARI", "XLK", "DNO", "VKQ", "BZF", "FMER", "IDXJ", "HYLD", "VIXY", "AFCB", "FFKY", "EDR", "VCSH", "XIV", "CMK", "PERM", "RJI", "GEMS", "VCBI", "JEQ", "MTU", "DDP", "FLAG", "BKK", "SBFG", "EVV", "IAT", "AXP", "NBG", "KCG", "PIZ", "AVIV", "AXJL", "NCA", "SSBI", "STSA", "MVT", "MHD", "ILTB", "MOFG", "USBI", "IJT", "HPI", "IFSM", "NXP", "ONEK", "USA", "ETG", "IBB", "JJN", "EFNL", "XTN", "BSCG", "BKU", "FDT", "IBDB", "BCF", "DHIL", "EIO", "FSP", "NBTB", "MZF", "SAFT", "DEE", "MLPY", "VXZ", "EMCB", "NRIM", "PUW", "JPM", "ANGL", "JJS", "GSVC", "UBS", "ISI", "ATLC", "FXCB", "ULE", "VIOO", "COB", "FWDB", "PWOD", "PXF", "SCHW", "MSP", "RF", "EEB", "BYM", "DBBR", "IRC", "CFFI", "EFSC", "DHF", "NLY", "FULL", "NOAH", "PKO", "MFT", "TLH", "UVXY", "EEHB", "GCBC", "EFX", "ALX", "MET", "ROLA", "TPRE", "VOT", "FAX", "CYB", "IDHQ", "PIQ", "PPT", "RDIV", "MFSF", "WBK", "WDIV", "ASA", "RPT", "IFEU", "SIZ", "TYD", "PGD", "GSMA", "IFNA", "TZG", "AXSL", "UGA", "WSH", "QDF", "PYH", "AIA", "DBB", "IGOV", "ACNB", "VTWV", "CIM", "NXC", "STRS", "ALL", "FSC", "DRE", "JQC", "MBB", "TSRE", "PLND", "TZV", "VCLT", "PHYS", "WETF", "EMF", "OBAF", "FBC", "NYCB", "TRNO", "AHH", "BHH", "SMH", "BUND", "CVY", "LKFN", "CME", "DLBS", "INB", "BQY", "MQT", "SBNY", "MAA", "CACB", "DLS", "JHP", "NGE", "EPOL", "SCHE", "TRF", "VEGA", "AVB", "FCNCA", "IRET", "SIJ", "DBE", "EWO", "KBWY", "KINS", "NSM", "PWV", "ESD", "RPAI", "PLTM", "EGP", "FFC", "WIP", "LTC", "PRFG", "MNE", "YAO", "NYX", "ALFA", "JPNL", "BIL", "HST", "PFN", "NPT", "PNXQ", "BRP", "CBL", "ILB", "EFV", "ENZL", "FBT", "DB", "FDM", "TRST", "EQL", "HCP", "MEN", "EELV", "QLTB", "SCO", "LCNB", "VRTB", "CINF", "XOP", "MLP", "BMR", "TTT", "ONB", "IWB", "FMNB", "PFL", "PL", "SCHG", "BFK", "PBIP", "PHB", "GASL", "IAF", "GTS", "CEF", "HBC", "IBCP", "GULF", "NXK", "SHG", "EMHD", "ECF", "DDG", "GXG", "MKL", "RLY", "CARZ", "UTLT", "IQI", "BLE", "EGPT", "RLJ", "XES", "NBO", "ICGE", "HOME", "BCA", "NZF", "AHT", "SOR", "HYB", "EWX", "NPF", "IHE", "MIY", "AI", "FDD", "IWC", "SJNK", "JCE", "GTIP", "UYG", "EIG", "HBK", "MNA", "HYT", "UGE", "GOOD", "GBLI", "FMK", "FCFS", "QIWI", "ARGT", "BLW", "ZION", "CLDT", "REG", "LTPZ", "TRMK", "RHS", "BSV", "DFJ", "CUBE", "RWX", "IAI", "AMU", "ITG", "IWY", "DZZ", "MGYR", "STAG", "EWZS", "USAG", "PRFS", "CNY", "FLM", "TPL", "AIV", "ECH", "PHK", "FPO", "ADX", "OKSB", "SBBX", "RWG", "MAC", "JXSB", "YDKN", "BNCL", "GLCH", "CITZ", "CART", "GUR", "BVA", "GPT", "CPSS", "FIEU", "IVV", "ESRT", "KOL", "AMG", "NMR", "JTD", "NY", "EWU", "BMRC", "CYS", "DTD", "GLRE", "IVOV", "LOR", "PXJ", "PRFH", "SHM", "HFWA", "GSRA", "NPV", "SLYG", "SYBT", "DHY", "TROW", "TZD", "UMDD", "UYM", "VNM", "FNF", "HHH", "GMFS", "BSCI", "VNO", "FT", "FFIC", "HTA", "PZN", "XOVR", "CQQQ", "NGPC", "PFD", "FVD", "ONN", "FEP", "NQP", "EGF", "PCL", "KRE", "HAV", "LPLA", "EOS", "NINI", "NIO", "RMAX", "KF", "URE", "IWV", "NXR", "CET", "SBM", "SEIC", "FXP", "TZE", "EWUS", "VEGI", "KCE", "GABC", "CHN", "EIHI", "KORU", "TREE", "CHII", "JPZ", "QDYN", "IYG", "EGRW", "KBE", "BIB", "DBA", "DPD", "KORZ", "NUJ", "AOK", "PBP", "ICOL", "PRFF", "AMLP", "BWV", "PTP", "RTM", "BKJ", "PJC", "WF", "PXLC", "ASPS", "DCOM", "FRA", "CHIX", "ICB", "AGNC", "SHV", "DLLR", "MES", "TBF", "BLNG", "VGSH", "AMTD", "EUFN", "IEZ", "KBWR", "TUZ", "FLAT", "INDA", "HFBL", "BJZ", "RYF", "FBIZ", "IRR", "EIM", "TTH", "UVU", "WD", "ZIPR", "NECB", "KFN", "WMCR", "JGV", "JJE", "OCFC", "CZWI", "DRL", "FFCO", "ONFC", "ARK", "L", "HIFS", "NMA", "EWK", "PRFN", "HYD", "TAGS", "TENZ", "BBF", "USO", "WAC", "JJU", "PICO", "SLVO", "CNO", "AROW", "FIW", "RYJ", "FORX", "SCPB", "WSR", "ISBC", "ASBI", "ERUS", "IBDD", "PCK", "EFT", "PIV", "CDR", "MCBI", "CFT", "MFV", "NAVG", "SEF", "ITIP", "NUCL", "LIT", "MRLN", "QCRH", "SDP", "YXI", "BRF", "LRY", "FRN", "PICK", "DHS", "AXJS", "BSAC", "IHF", "JFBC", "OILZ", "PSA", "PZC", "KXI", "BAM", "NQC", "KHI", "HIO", "IYW", "COF", "IAU", "EEML", "JPC", "NOM", "SAL", "GOVT", "KRU", "SPXL", "GLL", "LGI", "WABC", "HIW", "XRT", "GSP", "MYM", "CSQ", "FOL", "BXS", "HDG", "PICB", "PPLT", "TRC", "FMO", "CHIM", "FHY", "CIK", "UNAM", "EDEN", "CCXE", "LNBB", "ZF", "JPP", "VIXM", "ETY", "CSG", "BRZS", "IDLV", "NWLI", "DXD", "EMDI", "NVG", "SKK", "NLR", "UNTY", "UST", "AMNB", "MIDU", "NRK", "EEV", "EZU", "FCT", "JGBD", "FCO", "GLD", "PBS", "TLT", "IEO", "CGW", "CHW", "MFI", "RJZ", "CXP", "EUM", "HMPR", "BRE", "DEW", "OIH", "AXR", "FTY", "PRF", "EWD", "RSE", "ERH", "SGG", "BPK", "UPW", "LTS", "IRL", "NNP", "SBV", "VLY", "VRTS", "NBTF", "VXF", "GGT", "VT", "BPO", "CBU", "PXN", "AXFN", "DOD", "CMF", "PNNT", "CHOC", "GXC", "MYJ", "NEAR", "SCHA", "ITOT", "EPV", "ESBK", "PSCU", "HSPX", "ONEQ", "PNFP", "RNP", "EEMA", "EVAL", "CPT", "IXP", "CTNN", "BBVA", "RVNU", "SBB", "OFG", "STPZ", "TWM", "AMRB", "CSWC", "AIG", "IEV", "ORM", "APSA", "CMBS", "MINT", "IYH", "MQY", "AOA", "PNBK", "GTY", "PPS", "QAI", "STBZ", "TZL", "BBRC", "SCIF", "EBND", "RYH", "FTA", "MLPL", "VPL", "AMIC", "SKT", "VTIP", "RYT", "WRLD", "FIBK", "PCF", "NPI", "VMM", "MYY", "PRU", "SDOG", "DCA", "EMB", "IBCA", "EWEM", "FEO", "JPS", "BEN", "SRV", "WBS", "DGZ", "IOT", "MSFG", "SNV", "IWX", "HYHG", "DGAZ", "FHK", "SFNC", "TLL", "ACFC", "VUG", "DOL", "JRS", "GARS", "RMT", "PTH", "IWS", "SGL", "TZA", "EMEY", "GFED", "MLVF", "AUBN", "LSC", "EVF", "IBDC", "INDL", "DPU", "PSTB", "EWHS", "TDH", "EWL", "HBCP", "UBCP", "BHB", "SCHP", "DEX", "CSP", "VLUE", "GZT", "AGG", "SYA", "GDF", "EVBN", "SOXX", "NLP", "GCV", "NNI", "XOOM", "UWC", "FCZA", "BCM", "INCO", "BFOR", "FRAK", "LEAF", "MUAC", "OFED", "PAI", "QLTA", "SNH", "SZK", "VDC", "VYM", "BAC", "CCCR", "AMPS", "WDTI", "RCAP", "ZFC", "TNA", "CSJ", "GRU", "EWG", "IYR", "YCL", "DON", "EQS", "FAM", "OAKS", "CHLC", "BOND", "RWXL", "TOWN", "CMD", "DRV", "RFV", "EARN", "TTF", "BUSE", "TWOK", "AMH", "MAV", "DCT", "FWDI", "DJCI", "UBNK", "MCN", "FNDF", "NFJ", "NUM", "ARCC", "EIDO", "MCGC", "CUZ", "EVER", "DNL", "PDT", "SBND", "GFIG", "WHLR", "SST", "RM", "CBIN", "CXH", "MGK", "DNBF", "CMSB", "TMK", "FXCH", "NYC", "SGF", "WAYN", "PSCM", "SLX", "IPF", "PWC", "EWH", "OTP", "BXDB", "HRZN", "IYJ", "FSA", "EWJ", "ACE", "CNBC", "SFK", "BSE", "IDV", "DNY", "WU", "KEY", "NKY", "PSJ", "RTR", "SONA", "PXSG", "TSI", "IJK", "BIV", "RALS", "STC", "VO", "IRS", "LAG", "CSD", "DVM", "JO", "TDTT", "MFM", "AF", "IXG", "KNOW", "ANH", "PVI", "SIL", "HTR", "EU", "HBNC", "LYG", "RESI", "FCE-A", "DBO", "RSU", "TLTE", "BIZD", "FXY", "PFBX", "ACCU", "BAB", "DFVS", "INXX", "BWX", "MONY", "VIIZ", "IIM", "STIP", "GRT", "CU", "DBP", "EMD", "HTGC", "FDL", "FVI", "CTO", "GGP", "SOHO", "BDJ", "FUD", "IWZ", "BGT", "BNY", "JHI", "PWB", "FDUS", "GRI", "GAB", "BXMT", "CVLY", "CPF", "AAXJ", "FINF", "MCBC", "IAH", "QQQE", "FCHI", "ITB", "IYE", "PULB", "BND", "FNX", "GBF", "GGOV", "BQR", "CAC", "HGSH", "ROOF", "EFR", "DOC", "BHD", "FBMS", "WFC", "FFIN", "XBKS", "KRC", "PZA", "JNK", "JPNS", "HMNF", "IPW", "RBS", "CIT", "NGZ", "CBND", "PCEF", "PFBC", "FM", "ACWI", "ALD", "IGU", "INFL", "USCI", "AEG", "PHDG", "VSPY", "XLE", "PTF", "PSBH", "EMHY", "CHEV", "QID", "ATLO", "NPP", "IOIL", "ADRU", "IYT", "MIN", "SAR", "SIGI", "ADRA", "TAYC", "BGY", "WITE", "CVOL", "PHD", "RZG", "JRO", "MMT", "DIG", "KBWD", "BX", "PMBC", "TBNK", "HVPW", "DUG", "SMK", "CNPF", "ESXB", "BAL", "GBDC", "FCBC", "GNR", "ANCX", "FILL", "GAF", "IBKC", "IWR", "PML", "BAF", "MYI", "TCAP", "EWRS", "UBG", "DGP", "FXR", "AGO", "STBA", "GWL", "WTBA", "EIV", "CRBQ", "DMLP", "SBRA", "VIG", "FWDD", "DCNG", "NRT", "EBSB", "FFNM", "FTBK", "GII", "MGC", "RETL", "HTD", "MCY", "EPS", "VTHR", "CSH", "CBAN", "ASBC", "GROW", "FSGI", "VRTA", "VTV", "CBOE", "PRFM", "IBOC", "LVL", "PRA", "CLBH", "SNFCA", "DGRW", "REM", "QABA", "GLQ", "LM", "FYX", "BYFC", "EQR", "HTY", "IIH", "IDX", "ROMA", "SAA", "BRAF", "NCBC", "SIZE", "UMX", "DAG", "DEF", "DPO", "PFXF", "MTB", "SBW", "SPG", "DDF", "TCI", "UFCS", "XPP", "FFR", "OB", "BSCJ", "CMU", "SCC", "THRD", "FBG", "NOVB", "TAXI", "PEK", "GDXJ", "JUNR", "NASB", "PJP", "VBR", "FISI", "DRGS", "SAN", "MLPJ", "BABZ", "BSRR", "MPW", "PIM", "HCC", "PHO", "SF", "AMBC", "MXE", "CCA", "BSP", "FUR", "MFL", "NAZ", "JGG", "TIPX", "HR", "UBOH", "ETO", "QTS", "KLD", "EHTH", "BJK", "FXC", "DUST", "EEA", "FXI", "INP", "HYF", "NNY", "XBI", "FEX", "TKF", "PBW", "PCN", "BSD", "BYLK", "SOCL", "VAW", "PSEC", "DSUM", "HIG", "BNCN", "GLV", "IVOP", "MLPW", "HFFC", "IFAS", "IVZ", "BIS", "ERY", "PLMT", "PRI", "PSP", "SFBC", "FFA", "TDTF", "UVG", "RZV", "DJP", "JFC", "MPA", "VIIX", "BAP", "CNBKA", "ENGN", "IBCE", "EWQ", "TSH", "URA", "CBG", "ERC", "XXV", "GRN", "BRT", "PRE", "BFO", "DGT", "CPTA", "PGR", "PEY", "LBF", "UWM", "WEA", "JSC", "EIP", "JJA", "NBN", "TZI", "GAM", "PEO", "RSXJ", "HAO", "SCHB", "OZM", "CMO", "SLRC", "CEW", "INTL", "WMW", "GLPI", "AOD", "EMLP", "FNDB", "LABC", "MNR", "ABR", "OLP", "TLI", "NMO", "PHH", "BIK", "CSM", "CONE", "UMBF", "PIN", "RINF", "PCBK", "DEAR", "KBWI", "AMTG", "HTLF", "VWO", "NMB", "FIVZ", "CRRB", "COPX", "FAD", "SHY", "ETB", "SCHZ", "PNX", "RPG", "SFG", "IWL", "MDYG", "FAF", "MRF", "CISG", "ACG", "MUS", "IGN", "PZD", "CII", "EEN", "QMN", "FRBK", "HHC", "GBCI", "FAB", "CORN", "CGO", "MTS", "CZA", "OPY", "KW", "PLD", "ISHG", "PWP", "IYY", "RJA", "TFI", "CWI", "KED", "OLO", "SIVR", "UCD", "MUAG", "VCIT", "MTUM", "CRD-B", "ICH", "WSBF", "HCN", "CHSP", "PXQ", "FXD", "BRAQ", "FFKT", "OPHC", "FGB", "CEV", "RUDR", "UGAZ", "BNA", "EFG", "PLCC", "PEX", "IHI", "DFE", "IPS", "LAZ", "SCJ", "STFC", "TY", "CHEP", "FRT", "ORI", "PSR", "CHI", "UINF", "PXR", "CATY", "GYRO", "MIG", "EFZ", "OFS", "STPP", "TYN", "FMN", "RYU", "ASG", "BCV", "PMR", "HMG", "LND", "IFN", "IJR", "ALLB", "JEM", "RRGR", "MLPX", "EWRI", "MAIN", "IBCD", "EQY", "USB", "TRV", "NAN", "IPD", "RWM", "VPFG", "URTH", "NPY", "LOAN", "PXSV", "WIBC", "MUB", "MXI", "VKI", "AAT", "BOH", "ARE", "SGB", "IBKR", "NCP", "ITUB", "DWTI", "PMO", "BKLN", "ENX", "XHE", "HGI", "RSCO", "CIFC", "BTA", "SBR", "EWA", "PFO", "PPA", "VXUS", "AFFM", "MSL", "PTM", "EWY", "CRF", "BRXX", "EFU", "GREK", "IRY", "BKCC", "RJN", "ROIC", "WRE", "EWC", "RSP", "BCSB", "BLH", "COBK", "SLF", "PFLT", "CXE", "FSRV", "TOK", "PDM", "HBAN", "FXCM", "JFBI", "MUAF", "IF", "SIR", "KOLD", "PSCT", "ONEF", "QTEC", "TWTI", "PPR", "CB", "LSTK", "BHV", "BQH", "XSLV", "NQU", "LPHI", "IST", "DGL", "DTN", "IJS", "MXF", "MZA", "VNQ", "PTY", "DVYE", "IBTX", "IVOO", "MFNC", "FRI", "AAMC", "FVL", "MHY", "BLMT", "MCC", "FPX", "AXTE", "RWT", "AEL", "EEM", "PSB", "UBFO", "UGL", "JKL", "WVFC", "MBG", "MKH", "TZO", "FEU", "ZROZ", "DNP", "EWSS", "FAN", "MTK", "GUT", "EWGS", "FCH", "BRK-A", "SRTY", "TYBS", "KME", "GGAL", "ITA", "TIP", "AMP", "ESGR", "PVTB", "FNB", "VEU", "RSX", "MFLR", "CYE", "SRLN", "THD", "UDN", "PFS", "PMT", "CFNB", "CCNE", "CPER", "IBND", "AIZ", "BPS", "FBNC", "PBE", "COR", "FXO", "NAC", "SBSI", "SDY", "SQQQ", "HFBC", "PCC", "DVYL", "GNMA", "HCI", "MFD", "FMBI", "RIF", "IGV", "SRCE", "VTN", "BBDO", "MZZ", "PWJ", "MDYV", "WMC", "SFI", "TAI", "VTI", "EMCF", "TCB", "SASR", "AYN", "SMIN", "FNDC", "WREI", "EIRL", "OVLY", "CRVL", "WAFD", "HMH", "SOXS", "FOR", "PJG", "DBGR", "BOM", "MDIV", "YDIV", "IOO", "PPBI", "BOXC", "PXMC", "PBNY", "PXSC", "OABC", "MKTX", "GEX", "BKBK", "GLAD", "CBNK", "NUC", "UMH", "BPY", "LEO", "PSCF", "PEBO", "FITB", "FXF", "HASI", "DMF", "EWRM", "NASI", "ITIC", "AGII", "EWW", "CSMN", "FDV", "OVBC", "COLE", "RCG", "RCKB", "VBFC", "AFG", "VIOG", "RCD", "BOKF", "RING", "SOXL", "UCC", "VPV", "BFZ", "EMLC", "IGE", "FNHC", "CLGX", "WOOD", "IQDE", "UTH", "BSCM", "FXA", "NUGT", "HALL", "KFS", "MXN", "OLEM", "DBEF", "DX", "MLN", "NHI", "EDD", "VBK", "CNDA", "CWH", "CUT", "SWS", "KYE", "ING", "EBTC", "PNQI", "TWGP", "TYG", "RWV", "WTFC", "HVB", "DEM", "CMDT", "MSXX", "IQDF", "VVR", "KCLI", "SCD", "FDEF", "MIW", "IYK", "PEJ", "PJF", "IFT", "JKF", "FTF", "HIX", "DBIZ", "FPE", "AXDI", "REW", "FSU", "MUAD", "WRB", "PWY", "AOM", "BFY", "CVBF", "ILF", "ITR", "MARPS", "MBFI", "ASRV", "SHBI", "SPHQ", "UBT", "SPE", "VOOV", "MUA", "FULT", "DGICB", "EVT", "APTS", "DGS", "GHI", "WIA", "RBPAA", "TVIZ", "DBC", "RYE", "IQDY", "GSGO", "SRS", "CUBI", "MYD", "EMCI", "EAPS", "FXE", "GASZ", "GHL", "BRK-B", "PVD", "BFR", "SPXU", "SCHO", "JJT", "IYM", "PXH", "RY", "VMO", "LCM", "OBAS", "BLX", "EMI", "TCBK", "CAFI", "CHFC", "AGM", "MUI", "PSAU", "QQQX", "SBY", "TTFS", "NVSL", "GLU", "FSG", "FUNC", "BKT", "FMAR", "GMTB", "PRFZ", "ICI", "UVSP", "YCS", "RVSB", "RPX", "FXZ", "BSCH", "ACC", "FAS", "AGLS", "BDGE", "IGM", "RUSS", "SDOW", "ARCP", "PFI", "AGF", "MOO", "AZIA", "NKX", "NVC", "TDX", "UDR", "UKW", "ESS", "VONG", "SLG", "BKN", "AGD", "LWC", "TOFC", "PRK", "GSY", "HSA", "PEB", "HAP", "BCBP", "PFG", "STEL", "MVF", "RPI", "FAUS", "V", "XLY", "TDIV", "DSTJ", "UTF", "RSO", "UCBI", "BCAR", "GBL", "JSN", "MLPG", "ORIT", "BXUB", "PSK", "DWM", "RIVR", "SIEB", "GERJ", "BSCK", "ETW", "FCG", "FPT", "SUB", "CVCY", "FCLF", "FLTR", "TBBK", "RTH", "TBT", "TMP", "UJB", "VEA", "ADZ", "NSEC", "BLK", "CUBA", "PSCC", "UOIL", "DRW", "EXL", "CIZN", "EDIV", "RXI", "ERX", "PAGG", "GURU", "ACGL", "BSMX", "CHFN", "EOD", "GLDI", "MYC", "NNN", "PQSC", "OCN", "UIHC", "Z", "LBAI", "BKOR", "XVZ", "IVE", "NBCB", "OAK", "MHLD", "PMX", "OIA", "TRND", "CNOB", "DBJP", "RDN", "SJL", "TOTS", "KEF", "PGHY", "IMCB", "KB", "ENH", "FRME", "NKG", "RPV", "EVR", "VDE", "EEH", "VWOB", "IEI", "EWV", "PGJ", "HMST", "GRID", "LD", "VONV", "EXR", "DIV", "IGA", "NCO", "FBSS", "MUJ", "BSCF", "DSU", "MDY", "GASX", "IRV", "PUK", "LAND", "BTF", "BIE", "JOE", "FCTY", "PROV", "NBHC", "AMJ", "NPM", "DTUS", "MPV", "NBW", "PFSI", "NEN", "BPFH", "AAIT", "CHIQ", "PRFU", "RLI", "SGOL", "C", "MCI", "EFC", "IAE", "BDCS", "BSCL", "GBNK", "NQJ", "OPOF", "FCVA", "JJP", "RWO", "SAGG", "SWH", "INKM", "BEE", "BNDX", "LXP", "MNP", "FLRN", "CBNJ", "NXQ", "SMMU", "SSFN", "SSO", "KRG", "GOV", "IPN", "FNFG", "ERW", "TINY", "TQQQ", "BLJ", "VFL", "TWO", "FR", "TECS", "XLI", "WRI", "TLO", "SPXS", "GCH", "SCHF", "EFO", "PXMV", "LFC", "WASH", "SPYV", "EMDD", "IFGL", "EVX", "CHXX", "FNLC", "ICE", "APB", "IVW", "JKI", "NCT", "GSBC", "RHP", "CORP", "PWO", "SDS", "UCBA", "CHCO", "CHMG", "COW", "EMFN", "BLV", "XME", "HTS", "PFIG", "IESM", "CLY", "HBHC", "MITT", "PEBK", "SIBC", "THFF", "BSCD", "XLP", "VXX", "ESBF", "JMP", "MCA", "ASDR", "HYEM", "TYO", "JPG", "EPHE", "MYF", "EWAS", "FMD", "FSZ", "EMJ", "FRNK", "STL", "VTA", "VGLT", "AWF", "BCH", "INBK", "HDB", "PXLV", "DVYA", "KMPR", "MCR", "PIC", "OTR", "PLBC", "BHLB", "RBCAA", "FAZ", "UBD", "BMTC", "MA", "VMBS", "GNAT", "IIF", "BWZ", "IELG", "NMZ", "SMBC", "USMI", "KIE", "WTM", "XLU", "LPSB", "EDV", "PFA", "EWBC", "BKF", "OSHC", "FUBC", "UKK", "EBMT", "JKD", "FSBK", "PST", "XGC", "PHF", "DPK", "PMNA", "TBX", "UNM", "HYXU", "QCLN", "PSI", "TPS", "CIB", "DTO", "GVT", "DIM", "JKH", "MBWM", "FTC", "FDN", "SDK", "HOMB", "VQT", "PCY", "RRF", "XMPT", "CBF", "EMFT", "STND", "VSS", "DOG", "AKP", "BMA", "NUO", "SBCF", "EUO", "JNS", "DIRT", "UMPQ", "EVY", "MUAE", "VBF", "AFH", "BSCE", "GRWN", "GS", "HPT", "NWBI", "OLBK", "BRZU", "EET", "NTC", "INN", "RFG", "MMV", "SPPR", "TAO", "IMH", "MTR", "RFI", "TSS", "DSI", "QDEF", "TYY", "HBNK", "UBM", "USV", "HUSE", "CTBI", "PFBI", "APAM", "VR", "GXF", "WIW", "BFS", "AWH", "RKH", "FGM", "LQD", "EWS", "BTO", "PSCI", "EMCD", "FCAN", "VHT", "XMLV", "VOE", "GDL", "NIB", "SHO", "ZTR", "DLN", "FCAP", "HTH", "GPM", "SCHC", "CFR", "ASBB", "FSFG", "ICN", "REZ", "KRNY", "LION", "OFF", "PGP", "XLB", "FBMI", "EMITF", "GAL", "IDHB", "BPOP", "QLTC", "AYT", "FXG", "MDD", "SCBT", "KWT", "AXMT", "UBN", "AHL", "IXJ", "RAND", "MHI", "ICF", "IWN", "HIH", "AJG", "CPI", "FFNW", "JFR", "EVN", "BIF", "BBH", "MHN", "NKSH", "PEI", "PFM", "AMT", "PKW", "NZH", "FIG", "SOCB", "UBR", "MVV", "TSBK", "PJB", "ACAS", "PZT", "CFBK", "FCF", "NORW", "PKB", "CURE", "WDR", "KTF", "GFY", "JJC", "RTLA", "BDD", "INDY", "HHY", "ADRE", "PSQ", "DSM", "MTGE", "PBIB", "ESSA", "IMF", "BDN", "FSE", "FXU", "TRSK", "EDZ", "AXUT", "HDGE", "QQQC", "DTF", "TDBK", "UBC", "NUV", "UNB", "PLW", "XLF", "DTYS", "TCFC", "MSD", "FCCO", "RXD", "DHG", "UXJ", "EEME", "LNC", "EWCS", "DBV", "IEF", "KBWC", "NEA", "CIU", "BHY", "JJG", "PDN", "QQXT", "GML", "SDYL", "SLY", "SOIL", "TECL", "CKX", "NCZ", "NWFL", "PB", "IVR", "UCI", "VYFC", "SSS", "BGCP", "AFSI", "FCL", "CASH", "HIS", "JKJ", "NYMT", "TGR", "TWQ", "CTC", "ASEA", "JTA", "PID", "TDD", "AXHE", "VCR", "BHK", "OFC", "AUSE", "CFP", "IXN", "ANCB", "TD", "GOF", "GLBZ", "GLCB", "SLA", "MFA", "FNGN", "CRUD", "DBUK", "EFA", "EXT", "EOI", "EZJ", "O", "CZFC", "JGBS", "NNC", "STWD", "BBCN", "GSAX", "TICC", "NSL", "CSBK", "BERK", "SEA", "PNF", "PKBK", "ENY", "ETFC", "RWW", "HT", "LBJ", "PAF", "GIY", "CACC", "TIPT", "DNI", "TUR", "SOYB", "HYG", "UNL", "VOX", "HILO", "BOCH", "STT", "BICK", "GDX", "MUE", "KBWX", "TPGI", "NOBL", "DTYL", "MN", "JKG", "BDH", "HAFC", "GF", "COWN", "KYN", "FGD", "SCZ", "ECON", "WHG", "WSFS", "NIM", "BZM", "UCFC", "SVXY", "MUC", "SCHR", "FRC", "VV", "HAWK", "GLTR", "ECPG", "PRFQ", "MGI", "RGA", "ASP", "CSMA", "CHIE", "IPE", "PRB", "SJH", "FHC", "STI", "UCO", "CMA", "XLG", "GLPIV", "BANF", "GTAA", "LSE", "BOFI", "MBRG", "EWN", "PMM", "SNLN", "RSW", "MMI", "UTG", "PBCT", "ACWX", "NRZ", "AFL", "DFS", "HEOP", "SRC", "RWR", "COBZ", "GVI", "AGZ", "FLC", "CCG", "IPCC", "LDF", "EXG", "CAF", "DBAP", "GSG", "BFIN", "PPH", "FLOT", "PRN", "RWJ", "XHB", "XVIX", "IX", "NXM", "PIO", "NVX", "FXSG", "NQM", "AB", "UVE", "FXH", "RAS", "BANC", "GYLD", "SPY", "BXP", "REMX", "JLA", "IID", "CWBC", "XAA", "CS", "IWM", "COY", "IPU", "HYMB", "IJJ", "BBK", "JAXB", "LAQ", "RWK", "APF", "IGF", "UPV", "CFNL", "UNG", "SUBK", "ALEX", "BNO", "NXJ", "SVBI", "CCBG", "HCAP", "UPRO", "BBT", "AFK", "NHS", "BSBR", "ERIE", "RTL", "MBTF", "FXL", "IBDA", "NVY", "USD", "XTL", "LHO", "FXN", "MINC", "MPB", "SUI", "CSFS", "KIM", "AQQ", "RE", "TBZ", "CHLN", "SILJ", "UVT", "FHN", "HBMD", "BK", "NAD", "UBSI", "APO", "LBND", "ANAT", "HEVY", "MXA", "NMY", "CFFN", "NYH", "TCRD", "IHT", "DES", "EWT", "DTH", "IHC", "MSF", "GAIN", "GGN", "ITE", "CAD", "BBNK", "KRS", "YINN", "EWI", "FOF", "NMFC", "NXN", "DEI", "IVOG", "FFBH", "JTP", "TYNS", "BKMU", "INTG", "HME", "FFBC", "MNRK", "PMF", "TFSL", "DBEM", "VIOV", "VPU", "NPBC", "AEC", "DOIL", "ARPI", "BME", "FNDA", "BKYF", "AGA", "JLL", "QCCO", "CNA", "AVK", "KKR", "NTX", "BANR", "NGX", "OZRK", "QQQ", "CSE", "PUI", "THG", "WBKC", "FUND", "KFYP", "SPLV", "ETJ", "GCAP", "MCBK", "PFEM", "TMV", "AUNZ", "PEZ", "ACRE", "IYZ", "NBH", "TVIX", "ETF", "SMN", "MAYS", "SLVP", "YANG", "EVM", "SPBC", "NQS", "EDC", "VTR", "AOR", "NCU", "RAVI", "FONE", "MATH", "RNR", "RWL", "SMDD", "YYY", "IWW", "VB", "DRN", "NBBC", "KIPO", "GTWN", "PYZ", "SPYG", "JPX", "UXI", "BABS", "LSBK", "CWB", "EIA", "GAZ", "DXJ", "DOM", "REXR", "GRR", "IBN", "BSC", "BBX", "NMT", "IWF", "UKF", "PBHC", "TMF", "MAB", "HCBK", "MTG", "VFH", "CCX", "VTWO", "INY", "HF", "UBA", "WEBK", "NFO", "PW", "BCS", "RNST", "MMC", "SMB", "PSL", "SLYV", "NCV", "PALL", "EKH", "ELS", "PSCH", "EZA", "LSBI", "PSCE", "AFB", "UCP", "PCQ", "IRE", "MGV", "ADC", "NTRS", "VIS", "WEAT", "ZIV", "ATAX", "BKSC", "TIPZ", "JKE", "XRO", "RIT", "WAL", "DVY", "TRCB", "GLDX", "KBWB", "FDTS", "LGLV", "VLT", "AADR", "GUNR", "AGQ", "VIXH", "CHMI", "EWZ", "IJH", "BNS", "PRFE", "IBCB", "GHYG", "PHT", "PDP", "BOE", "JXI", "MJI", "PEOP", "PGX", "NMI", "TAN", "CAFE", "CG", "GBB", "NEWS", "QQEW", "UDOW", "OHI", "DOO", "DUC", "ARL", "PBD", "GCC", "SMFG", "TDN", "BOS", "DWX", "SUSQ", "ICLN", "IWD", "ETV", "CBSH", "EVJ", "GCA", "PWT", "SLV", "HDGI", "FMY", "PACW", "EZM", "FCCY", "INR", "HMN", "SKF", "UUP", "BTZ", "SLM", "SMLV", "FLIC", "NHTB", "CSMB", "SPHB", "CLM", "FSBW", "FRF", "CIF", "MGU", "PIE", "PJM", "PWZ", "SIFI", "INDB", "SJF", "VGM", "VOOG", "VSBN", "MYN", "JHS", "BZQ", "FXS", "FBP", "PBCP", "BOIL", "HQH", "SGAR", "RXL", "UWTI", "DGRE", "DDM", "CSFL", "BONO", "MBVT", "IBCC", "MS", "MVC", "NXZ", "FEN", "VGK", "RQI", "KROO", "IDOG", "IRT", "TILT", "GDV", "AON", "EIS", "IPK", "FEMS", "WPS", "HKK", "IWO", "IWP", "KMM", "SYLD", "Y", "ITF", "NRF", "THHY", "KCAP", "FUE", "BRO", "SDD", "FDI", "BNJ", "KFFB", "SCIN", "IXC", "TCO", "EPR", "SCHX", "SGM", "GRES", "XSD", "KSM", "KST", "MFG", "EVO", "AXS", "HPS", "FNDX", "EVBS", "GSC", "CLNY", "FBNK", "DDR", "JMI", "NNJ", "EAD", "NQI", "IGR", "TRNM", "DRH", "FNIO", "GMM", "REXI", "SFST", "CYN", "VGT", "LTL", "VGIT", "PXI", "PXMG", "FEFN", "SBI", "ACIM", "EZY", "FXB", "WFBI", "GCE", "PXLG", "FBRC", "HTBI", "DBU", "TLTD", "CXA", "IROQ", "DBEU", "MIDZ", "NICK", "PBJ", "QLD", "ERO", "JOF", "RLGY", "HLSS", "CUNB", "DYY", "CNS", "IFMI", "FWV", "WMH", "SPGH", "EUSA", "BWINB", "CIA", "OEF", "BGR", "BTAL", "PNC", "EVG", "PKY" ] }


Exercício 4 –Fraude na Enron

a) Liste as pessoas que enviaram e-mails (de forma distinta, ou seja, sem repetir). Quantas pessoas são?
    Comando: db.getCollection("enron").aggregate(
                [
                    { 
                        "$project" : { 
                            "sender" : "$sender", 
                            "_id" : NumberInt(0)
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : null, 
                            "distinct" : { 
                                "$addToSet" : "$$ROOT"
                            }
                        }
                    }, 
                    { 
                        "$unwind" : { 
                            "path" : "$distinct", 
                            "preserveNullAndEmptyArrays" : false
                        }
                    }, 
                    { 
                        "$replaceRoot" : { 
                            "newRoot" : "$distinct"
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            );
    Output: { "sender" : "marlya0264@aol.com" }
            { "sender" : "amepya2@hotmail.com" }
            { "sender" : "fwolgel@azurix.com" }
            { "sender" : "alexis415@yahoo.com" }
            { "sender" : "lianne.cairns@enron.com" }
            { "sender" : "steve.montovano@enron.com" }
            { "sender" : "laurel.crafts@library.gatech.edu" }
            { "sender" : "customerservice@paragonsports.com" }
            { "sender" : "rebecca.longoria@enron.com" }
            { "sender" : "cmisseldine@mindspring.com" }
            { "sender" : "addyee@aol.com" }
            { "sender" : "jaeschke@marin.cc.ca.us" }
            { "sender" : "kirkwitzberger@hotmail.com" }
            { "sender" : "teri@igc.org" }
            { "sender" : "cynthia.sandherr@enron.com" }
            { "sender" : "j2468@webtv.net" }
            { "sender" : "mark.palmer@enron.com" }
            { "sender" : "collage@igc.org" }
            { "sender" : "annie_moore@yahoo.com" }
            { "sender" : "rondap@earthlink.net" }
            Type "it" for more

    Comando: db.getCollection("enron").aggregate(
                [
                    { 
                        "$project" : { 
                            "sender" : "$sender", 
                            "_id" : NumberInt(0)
                        }
                    }, 
                    { 
                        "$group" : { 
                            "_id" : null, 
                            "distinct" : { 
                                "$addToSet" : "$$ROOT"
                            }
                        }
                    }, 
                    { 
                        "$unwind" : { 
                            "path" : "$distinct", 
                            "preserveNullAndEmptyArrays" : false
                        }
                    }, 
                    { 
                        "$replaceRoot" : { 
                            "newRoot" : "$distinct"
                        }
                    }
                ], 
                { 
                    "allowDiskUse" : true
                }
            ).itcount();
    Output: 2200

b) Contabilize quantos e-mails tem a palavra “fraud”
    Comando: db.getCollection("enron").find(
                { 
                    "$or" : [
                        { 
                            "text" : /.*fraud.*/i
                        }, 
                        { 
                            "subject" : /.*fraud.*/i
                        }
                    ]
                }
            ).count();
    Output: 25





